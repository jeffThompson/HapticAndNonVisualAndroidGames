

class Grass {
  int x, y;
  int len;
  int maxLen;
  int tilt;
  color bladeColor;
  int colorOffset;
  float distFromCenter;
  float angleTowardCenter;

  Grass (String onOffScreen) {

    // onscreen for initial blades, offscreen to create new ones
    if (onOffScreen.equals("on")) {
      x = int(random(-max(width, height) * 2, max(width, height) * 2));
      y = int(random(-max(width, height) * 2, max(width, height) * 2));
    }
    else {
      x = int(random(0, max(width, height) * 2));      // spawn offscreen
      if (random(1) > 0.5) {                                  // place on random side (L/R)
        x += width+100;
        x *= -1;
      }
      y = int(random(0, max(width, height) * 2));
      if (random(1) > 0.5) {
        y += height+100;
        y *= -1;
      }
    }

    maxLen = int(random(10, 40));
    tilt = int(random(-6, 6));
    colorOffset = int(random(0, 50));
  }

  void update() {
    distFromCenter = dist(x, y, width/2, height/2);
    float bladeR = map(distFromCenter, 0, height/2, 30, 20);    // map b/w two colors
    float bladeG = map(distFromCenter, 0, height/2, 100, 50);
    bladeColor = color(bladeR + colorOffset, bladeG + colorOffset, colorOffset, 230);

    angleTowardCenter = atan2(width/2 - x, height/2 - y);
    if (angleTowardCenter < 0) {
      angleTowardCenter += TWO_PI;
    }
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
    len = int(map(distFromCenter, 0, height, 0, maxLen));
    if (y > height/2) {
      len *= -1;
    }

    stroke(bladeColor);
    strokeWeight(4);
    line(0, 0, tilt, -len);

    popMatrix();
  }
}

