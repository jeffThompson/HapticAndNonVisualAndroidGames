
void winScreen() {
  background(255);

  if (millis() % 500 < 250) {
    noStroke();
    fill(0);
    textFont(titleFont, 72);
    text("YOU WIN!", width/2, height/2);
  }
}

void deadScreen() {
  background(255,0,0);
  
  textAlign(CENTER, CENTER);
  textFont(titleFont, 72);
  fill(0);
  text("YOU'RE DEAD", width/2,height/2);
  textFont(detailsFont, 20);
  text("sorry", width/2, height/2+60);
}

