
class Sonar {

  float triggerThreshold = 0.2;
  int noteDuration = 5;     // in milliseconds
  int lowPitch = 220;
  int highPitch = 440;
  int radius = 80;

  boolean isPlaying = false;
  float[] scan = new float[180];
  float averageSample = 0.0;

  Sonar () {
    // nothing to do here :)
  }

  // scan for obstacles
  void runScan() {
    for (int i=0; i<scan.length; i++) {
      scan[i] = 0;
    }
    for (Obstacle obs : obstacles) {
      int left = int(degrees(obs.angleLeft));
      int center = int(degrees(obs.angleCenter));
      int right = int(degrees(obs.angleRight));
      for (int i=left; i<right; i++) {
        try {
          scan[i] = max(obs.colorDist, scan[i]);
        }
        catch (ArrayIndexOutOfBoundsException aioobe) {
          // skip if out of range
        }
      }
    }
  }

  // draw scan onscreen
  void display() {
    for (int i=0; i<scan.length; i++) {
      pushMatrix();
      translate(player.x, player.y);
      rotate(radians(i) - PI);
      stroke(scan[i]);
      strokeWeight(3);
      line(0, 0, radius, 0);
      popMatrix();
    }
    fill(150, 255, 50);
    noStroke();
    rect(0, 0, averageSample * width, 30);
  }

  // listen for audio input and trigger playback
  void listen() {
    // get average volume of input
    averageSample = 0.0;
    for (int i=0; i<audioIn.bufferSize(); i++) {
      averageSample += abs(audioIn.left.get(i));
    }
    averageSample /= audioIn.bufferSize();

    // if above the threshold and not already playing, trigger playback
    if (averageSample > triggerThreshold && !isPlaying) {
      thread("playSweep");
    }
  }
}

void playSweep() {

  boolean playing = true;

  float[] scan = sonar.scan;
  int noteDuration = sonar.noteDuration;
  int lowPitch = sonar.lowPitch;
  int highPitch = sonar.highPitch;

  for (int whichNote = 0; whichNote < scan.length; whichNote++) {

    // very high click in the middle
    //if (whichNote == 90) {
    //  centerClick.play(0);
    //  delay(100);
    // }

    // create note based on distance and stereo position 
    // else {
      float freq = map(scan[whichNote], 0, 255, lowPitch, highPitch);
      sine.setFreq(freq);
      float amp = map(scan[whichNote], 255, 0, 1.0, 0.05);      
      sine.setAmp(amp);
      float pan = map(whichNote, 0, scan.length-1, -1.0, 1.0);
      sine.setPan(pan);
      delay(noteDuration);  // wait (while continuing the animation)
    // }
  }

  sine.setAmp(0);
  playing = false;
}

