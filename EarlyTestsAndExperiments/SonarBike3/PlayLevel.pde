
// normal gameplay (ie: non-title screens)
void playLevel() {
  background(0);

  // sonar scan
  sonar.runScan();
  sonar.listen();
  sonar.display();
  //if (sonar.isPlaying) {
  //  sonar.play();
  //}

  // display player
  player.display();

  // display and display obstacles
  updateObstacleOrder();
  for (int i=obstacles.size()-1; i>=0; i-=1) {
    Obstacle obs = obstacles.get(i);
    obs.updatePosition();
    obs.testCollision();
    obs.display();
    if (obs.y > height + obs.diameter) {
      obstaclesPassed++;          // # obstacles successfully dodged
      remainingObstacles -= 1;
      checkLevel();               // check if we get to progress!
      obstacles.remove(i);
      obstacles.add(new Obstacle(random(0, width), random(-height, 0)));
    }
  }

  // details
  textFont(detailsFont, 20);
  noStroke();
  fill(255);
  textAlign(RIGHT, TOP);
  text("LIVES: " + numLives + "\nTO GO: " + remainingObstacles, width-30, 30);
}

