
void drawDirection() {

  /*
   fill(255);
   noStroke();
   String dir = "";
   switch (direction) {
   case 'n': 
   dir = "N"; 
   break;
   case 'e': 
   dir = "E"; 
   break;
   case 's': 
   dir = "S"; 
   break;
   case 'w': 
   dir = "W"; 
   break;
   }
   text(dir, 50, height-50);*/

  float rotAngle = 0;
  String dir = "";

  pushMatrix();
  translate(50, height-50);
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
  line(0, -10, 0, 10);
  line(0, -10, -5, -5);
  line(0, -10, 5, -5);

  noStroke();
  fill(255);
  if (direction != 'n') {
    translate(0, -24);
    rotate(radians(-rotAngle));
    textFont(font, 14);
    text("N", 0, 0);
  }
  popMatrix();

  textFont(font, 24);
  text(dir, 50, height-80);
}

