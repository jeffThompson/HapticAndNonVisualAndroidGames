
class Player {
  float visionDist = 1000;
  int diameter = 30;
  float speed = 20;    // side-to-side speed (not obstacle move speed)
  float x, y;
  int radius = diameter/2;

  Player (float _x, float _y) {
    x = _x;
    y = _y;
  }

  // update position when L/R arrow keys are pressed
  void move(int direction) {
    if (direction == RIGHT) {
      x += speed;
      if (x + radius > width) {
        x = width-radius;
      }
    }
    else if (direction == LEFT) {
      x -= speed;
      if (x - radius < 0) {
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
