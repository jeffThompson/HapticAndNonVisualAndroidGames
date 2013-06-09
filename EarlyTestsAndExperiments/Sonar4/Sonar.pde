
class Sonar {

  float triggerThreshold = 0.2;
  int noteDuration = 5;     // in milliseconds
  int radius = 200;

  boolean isPlaying = false;
  float[] scan = new float[180];

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
  }
}

void playSweep() {
  sonar.isPlaying = true;
  float amp, panL, panR;

  if (!pitch.isPlaying()) pitch.start();
  pitch.seekTo(0);

  for (int i=0; i<sonar.scan.length; i++) { 
    amp = map(sonar.scan[i], 255, 0, 1.0, 0.01);    // just a little sound for no objects (easier to hear the pan)
    panL = map(i, 0, sonar.scan.length-1, 1.0, 0.0);
    panR = map(i, 0, sonar.scan.length-1, 0.0, 1.0);
    pitch.setVolume(panL*amp, panR*amp);
    delay(sonar.noteDuration);
  }

  // very high click in the middle
  //if (whichNote == 90) {
  //  centerClick.play(0);
  //  delay(100);
  // }

  if (pitch.isPlaying()) pitch.pause();
  sonar.isPlaying = false;
}

