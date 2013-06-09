
// normal gameplay (ie: non-title screens)
void playLevel() {

  background(0);
  if (arrowTrans >= 0) {
    fill(255, arrowTrans);
    textFont(headlineFont);
    text("[ objects are coming toward you ]", width/2, arrowPos);
    // text("⇣    ⇣    ⇣    ⇣    ⇣    ⇣", width/2, arrowPos);
    // text("↓    ↓    ↓    ↓    ↓    ↓", width/2, arrowPos);
    arrowPos += 10;
    arrowTrans -= 2.0;
  }

  // sonar scan
  sonar.runScan();
  if (showSonar) sonar.display();

  // display player
  player.move();
  player.display();

  // display and display obstacles
  updateObstacleOrder();
  for (int i=obstacles.size()-1; i>=0; i-=1) {
    Obstacle obs = obstacles.get(i);
    obs.updatePosition();
    obs.testCollision();
    if (showObjects) obs.display();

    if (obs.y > height + obs.diameter) {
      obstacles.remove(i);
      obstacles.add(new Obstacle(random(0, width), random(-height, 0)));
    }
  }
}

