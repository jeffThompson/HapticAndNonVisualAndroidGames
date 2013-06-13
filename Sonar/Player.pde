
class Player {
  float visionDist = width/3;
  int diameter = 200;
  float speed = 10.0;                 // multiply sensor reading for faster movement
  float x, y;
  int radius = diameter/2;
  boolean hitWall = false;

  Player (float _x) {
    x = _x;
    y = height-diameter-20;
  }

  // update position on tilt
  void move() {
    if (accelData != null) {
      x -= accelData[0] * speed;
      if (x + radius > width) {           // off L side
        x = width-radius;
        if (!sideSound.isPlaying() && !hitWall) {
          sideSound.setVolume(0.0, 1.0);
          sideSound.start();
          hitWall = true;
        }
      }
      else if (x - radius < 0) {          // off R side
        x = radius;
        if (!sideSound.isPlaying() && !hitWall) {
          sideSound.setVolume(1.0, 0.0);
          sideSound.start();
          hitWall = true;
        }
      }
      else {
        hitWall = false;
      }
    }
  }

  // display onscreen
  void display() {
    noStroke();
    fill(255);
    ellipse(x, y, diameter, diameter);
  }
}

