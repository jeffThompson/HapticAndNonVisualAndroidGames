
void instructionBasics(String nextLevel) {
  background(255);
  noStroke();
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(titleFont, 72);
  text("NEXT LEVEL: " + nextLevel.toUpperCase() + "!", width/2, height/2 - 80);
}

void detailsAndBlinkStart(String details) {
  textFont(detailsFont, 20);
  text(details, width/2, height/2+40);
  fill(255,150,0);
  if (millis() % 1000 < 500) {
    text("[ press any key to start ]", width/2, height/2 + 200);
  }
}

void instruction_walk() {
  instructionBasics("walk");
  String details = "use left/right arrow keys to dodge obstacles\nuse up arrow key to step forward\nclick/snap into the mic to run a sonar scan\n\ngoal: dodge " + remainingObstacles + " obstacles";
  detailsAndBlinkStart(details);
}

void instruction_run() {
  instructionBasics("run");
  String details = "automatic running now - good luck!\n\ngoal: dodge " + remainingObstacles + " obstacles";
  detailsAndBlinkStart(details);
}
void instruction_bike() {
  instructionBasics("bike");
  String details = "biking is a little harder (and hurts a little more)\n\ngoal: dodge " + remainingObstacles + " obstacles";
  detailsAndBlinkStart(details);
}

void instruction_motorcycle() {
  instructionBasics("motorcycle");
  String details = "motorcycles are dangerous... and fast!\n\ngoal: dodge " + remainingObstacles + " obstacles";
  detailsAndBlinkStart(details);
}
