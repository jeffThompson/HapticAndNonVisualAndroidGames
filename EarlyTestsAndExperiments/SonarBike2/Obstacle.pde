
class Obstacle {
  float x, y;
  float angle;
  float dist;
  int diameter = 30;
  int radius = diameter/2;
  float speed;

  Obstacle (float _x, float _y, float _speed) {
    x = _x;
    y = _y;
    speed = _speed;
  }

  void updateSonar() {
    angle = atan2(y - playerY, x - playerX) + angleOffset;
    dist = dist(x, y, playerX, playerY);
  }
  void updateY() {
    y += speed;
  }

  void testCollision() {
    if (!crash.isPlaying() && x + radius > playerX - playerSize/2 && x - radius < playerX + playerSize/2 && 
      y + radius > playerY - playerSize/2 && y - radius < playerY + playerSize/2) {
      crash.play(0);
      collisionCount++;
    }
  }

  void display(int i) {
    noStroke();
    fill(map(dist, 0, visionDist, 255, 0), map(dist, 0, visionDist, 150, 0), 0);
    ellipse(x, y, diameter, diameter);

    // show angle
    //fill(255);
    //textAlign(CENTER, CENTER);
    //text(getAngleInDegrees(), x, y);
  }

  int getAngleInDegrees() {
    return int(degrees(angle));
  }
}


// orders clockwise (for sonar beeps!)
void updateOrder() {
  Collections.sort(obstacles, new Comparator<Obstacle>() {
    @Override public int compare(Obstacle o1, Obstacle o2) {
      return int(o1.getAngleInDegrees() - o2.getAngleInDegrees());
    }
  }
  );
}

