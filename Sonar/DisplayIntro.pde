
void displayIntro() {
  
  background(0);
  
  fill(255);
  noStroke();
  textFont(headlineFont);
  text("SONAR", width/2, height/2-30);
  
  textFont(detailsFont);
  text("Jeff Thompson | 2013\n\n[ dodge/catch objects | tilt to move | tap for sonar ]", width/2, height/2+60);  
}
