
void displayStartScreen() {
  background(0);
  
  noStroke();
  fill(255);
  textAlign(CENTER, CENTER);
  
  textFont(headlineFont);
  text("Chromosome #20", width/2,height/2);
  
  textFont(detailFont);
  text("( arrow keys to navigate     |     any key to start )", width/2, height/2 + 100);
}
