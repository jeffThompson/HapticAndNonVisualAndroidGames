
// normal gameplay (ie: non-title screens)
void playLevel() {

  background(0);

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

    // if specified, display obstacles onscreen
    if (showObjects) obs.display();

    // when offscreen, remove and make a new obstacle above
    if (obs.y > height + obs.diameter) {
      obstacles.remove(i);
      obstacles.add(new Obstacle(random(0, width), random(-height, 0)));
    }
  }
  
  // check if any obstacles are being hit: if none are, turn off sound
  boolean anyHit = false;           // flag to test
  for (Obstacle o : obstacles) {    // iterate all obstacles
    if (o.isHit) anyHit = true;     // if one is hit, set flag
  }
  if (!anyHit) hitSound.pause();    // if none hit, pause sound

  if (showDebug) {
    String info = "DEGUGGING INFO";
    info += "\nFPS: " + nf(frameRate, 0,2);
    info += "\n# OBS: " + numObstacles;
    
    fill(255);
    noStroke();
    textFont(detailsFont);
    textAlign(LEFT, TOP);
    text(info, 50, 50);
  }
}
