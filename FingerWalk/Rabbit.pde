
class Rabbit {
  int x, y;
  int spX, spY;
  int size = 30;
  boolean running;

  Rabbit () {
    respawn();
  }

  void respawn() {
    x = width + size;
    y = int(random(0, height));
    spX = int(random(-10, -1));
    spY = int(random(-10, 10));
    running = true;
  }

  void update() {
    x += spX;
    y += spY;

    if (x-size < -width || x+size > width*2 || y-size < -height || y+size > height*2) {
      running = false;
    }
  }

  void display() {
    fill(255);
    noStroke();
    ellipse(x, y, size, size);
  }
}
