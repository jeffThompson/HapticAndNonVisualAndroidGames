
class Obstacle {
  int diameter = width/10;
  float x, y, leftX, leftY, rightX, rightY;
  float angleCenter, angleLeft, angleRight;
  float dist;
  int colorDist;
  int radius = diameter/2;
  boolean isHit = false;

  Obstacle (float _x, float _y) {
    x = _x;
    y = _y;
  }

  // update vertical position, angle, and distance
  void updatePosition() {
    y += levelSpeed;
    dist = dist(x, y, player.x, player.y);
    colorDist = int(map(dist, 0, player.visionDist, 255, 0));
    colorDist = constrain(colorDist, 0, 255);

    angleCenter = atan2(y-player.y, x-player.x);

    leftX = x + radius * cos(angleCenter-HALF_PI);
    leftY = y + radius * sin(angleCenter-HALF_PI);
    angleLeft = atan2(player.y - leftY, player.x - leftX);

    rightX = x + radius * cos(angleCenter+HALF_PI);
    rightY = y + radius * sin(angleCenter+HALF_PI);
    angleRight = atan2(player.y - rightY, player.x - rightX);
  }

  // check for collision with player
  void testCollision() {
    // if we're close enough for a collision and NOT already playing the sound, do so
    if (dist < radius + player.radius && !hitSound.isPlaying()) {
      collision(x);  // pass x position for panning L/R
      isHit = true;
    }
    else {
      isHit = false;
    }
  }

  // draw onscreen
  void display() {
    noStroke();
    fill(255,150,0, map(dist, 0, player.visionDist, 255, 0));    // vary transparency with distance
    ellipse(x, y, diameter, diameter);
  }

  // return angle in degrees (for sorting)
  int getAngleInDegrees() {
    return int(degrees(angleCenter));
  }
}

// orders clockwise (for sonar beeps!)
void updateObstacleOrder() {
  Collections.sort(obstacles, new Comparator<Obstacle>() {
    @Override public int compare(Obstacle o1, Obstacle o2) {
      return int(o1.getAngleInDegrees() - o2.getAngleInDegrees());
    }
  }
  );
}

