
class SonarObj {

  int noteDuration = 5;               // in milliseconds
  int radius = 200;                   // how far the visuals extend from player
  boolean playCenterClick = true;    // play a sound at top of sweep

  boolean isPlaying = false;
  float[] scan = new float[180];

  SonarObj () {
    // nothing to do here :)
  }

  // scan for obstacles
  void runScan() {

    // iterate all obstacles, get data
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
      strokeWeight(5);
      line(0, 0, radius, 0);
      popMatrix();
    }
  }
}

// play the sonar sound
void playSweep() {
  sonar.isPlaying = true;
  float amp, panL, panR;

  if (!sonarSweep.isPlaying()) sonarSweep.start();
  sonarSweep.seekTo(0);

  for (int i=0; i<sonar.scan.length; i++) { 

    // very high click in the middle
    if (sonar.playCenterClick && i == 90) {
      centerClick.setVolume(0.8, 0.8);   // volume for center click
      centerClick.seekTo(0);             // play audio
      delay(100);                        // set time for click (best if a little longer than the rest of the sonar)
      centerClick.pause();               // stop audio
    }

    // regular sweep
    else {
      amp = map(sonar.scan[i], 255, 0, 1.0, 0.01);        // just a little sound for no objects (easier to hear the pan)
      panL = map(i, 0, sonar.scan.length-1, 1.0, 0.0);    // set panning based on position in array
      panR = map(i, 0, sonar.scan.length-1, 0.0, 1.0);
      sonarSweep.setVolume(panL*amp, panR*amp);
      delay(sonar.noteDuration);
    }
  }

  if (sonarSweep.isPlaying()) sonarSweep.pause();
  sonar.isPlaying = false;
}

