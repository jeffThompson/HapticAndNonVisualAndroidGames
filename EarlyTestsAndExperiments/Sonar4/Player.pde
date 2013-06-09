
class Player {
  float visionDist = width/3;
  int diameter = 50;
  float speed = 10.0;                 // multiply sensor reading for faster movement
  float x, y;
  int radius = diameter/2;

  Player (float _x, float _y) {
    x = _x;
    y = _y;
  }

  // update position on tilt
  void move() {
    if (accelData != null) {
      x -= accelData[0] * speed;
      if (x + radius > width) {
        x = width-radius;
      }
      else if (x - radius < 0) {
        x = radius;
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

