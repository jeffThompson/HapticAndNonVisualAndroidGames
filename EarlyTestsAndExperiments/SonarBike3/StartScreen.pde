
void startScreen() {
  background(255);

  // title and details
  noStroke();
  fill(0);
  textFont(titleFont, 72);
  text("SONAR BIKE", width/2, height/2 - 40);

  // blink start text
  textFont(detailsFont, 20);
  fill(255,150,0);
  if (millis() % 1000 < 500) {
    text("[ press any key to start ]", width/2, height/2 + 40);
  }
}

