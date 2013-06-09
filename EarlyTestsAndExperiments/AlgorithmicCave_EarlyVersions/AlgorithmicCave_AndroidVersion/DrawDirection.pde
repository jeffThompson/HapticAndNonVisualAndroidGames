
void drawDirection() {

  float rotAngle = 0;
  String dir = "";

  pushMatrix();
  translate(100, height-100);
  switch (direction) {
  case 'n': 
    rotAngle = 0;
    dir = "N";
    break;
  case 'e': 
    rotAngle = 90;
    dir = "E"; 
    break;
  case 's': 
    rotAngle = 180;
    dir = "S";
    break;
  case 'w': 
    rotAngle = 270;
    dir = "W";
    break;
  }

  rotate(radians(rotAngle));
  stroke(255);
  line(0, -20, 0, 20);
  line(0, -20, -10, -10);
  line(0, -20, 10, -10);

  noStroke();
  fill(255);
  if (direction != 'n') {
    translate(0, -height/50-20);
    rotate(radians(-rotAngle));
    textFont(font, height/50);
    text("N", 0, 0);
  }
  popMatrix();

  textFont(font, height/30);
  text(dir, 100, height-160);
}
