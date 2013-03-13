
class Tree {
  int x, y;
  int size;
  int trunkHeight, trunkWidth, maxHeight;
  float distFromCenter;
  float angleTowardCenter;

  color leafColor, trunkColor;
  int colorOffset;

  Tree (String onOffScreen) {

    // onscreen for initial trees, offscreen to create new ones
    if (onOffScreen.equals("on")) {
      x = int(random(-max(width, height) * 2, max(width, height) * 2));
      y = int(random(-max(width, height) * 2, max(width, height) * 2));
    }
    else {
      x = int(random(0, max(width, height) * 2));      // spawn offscreen
      if (random(1) > 0.5) {                                  // place on random side (L/R)
        x *= -1;
      }
      else {
        x += width+100;
      }
      y = int(random(0, max(width, height) * 2));
      if (random(1) > 0.5) {
        y *= -1;
      }
      else {
        y += height+100;
      }
    }

    size = int(random(100, 400));
    trunkWidth = int(random(size/7, size/4));
    maxHeight = size*2;
    colorOffset = int(random(0, 50));
  }

  void update() {

    distFromCenter = dist(x, y, width/2, height/2);
    float leafR = map(distFromCenter, 0, height/2, 30, 20);    // map b/w two colors
    float leafG = map(distFromCenter, 0, height/2, 100, 50);
    leafColor = color(leafR + colorOffset, leafG + colorOffset, colorOffset, 230);

    float trunkR = map(distFromCenter, 0, height/2, 60, 0);
    float trunkG = map(distFromCenter, 0, height/2, 35, 0);
    float trunkB = map(distFromCenter, 0, height/2, 20, 0);
    trunkColor = color(trunkR, trunkG, trunkB);

    angleTowardCenter = atan2(width/2 - x, height/2 - y);
    if (angleTowardCenter < 0) {
      angleTowardCenter += TWO_PI;
    }
  }

  int getDistFromCenter() {
    return int(distFromCenter);
  }

  boolean isDead() {
    if (distFromCenter > max(width, height) * 2) {
      return true;
    }
    return false;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    if (y <= height/2) {
      rotate(-angleTowardCenter);
    }
    else {
      rotate(-angleTowardCenter - PI);
    }
    trunkHeight = int(map(distFromCenter, 0, height, 0, maxHeight));
    if (y > height/2) {
      trunkHeight *= -1;
    }

    // fill(trunkColor);
    // rect(x-trunkWidth/2, y, trunkWidth, trunkHeight);
    // ellipse(0, 0, trunkWidth, trunkWidth);
    // rect(-trunkWidth/2, 0, trunkWidth, trunkHeight);
    stroke(trunkColor);
    strokeWeight(trunkWidth);
    strokeCap(ROUND);
    line(0, trunkHeight/3, 0, trunkHeight);
    strokeWeight(trunkWidth/2);
    line(0, trunkHeight/3, -size/4, 0);
    line(0, trunkHeight/3, size/6, 0);

    noStroke();
    fill(leafColor);
    ellipse(0, 0, size, size);
    popMatrix();
  }
}

