/*
BIG D-PAD
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 
 */

int playerSize = 150;
PolygonButton up, right, down, left;
CenterButton button;

void setup() {
  // orientation(LANDSCAPE);
  size(900,600);
  mouseX = width/2;
  mouseY = height/2;

  // create buttons
  createButtons();
  button = new CenterButton(playerSize, color(255,150,0), color(255,0,0));
}

void draw() {

  background(0);

  // draw buttons
  up.display();
  right.display();
  down.display();
  left.display();

  // dividing lines
  stroke(255, 200);
  line(0, 0, width/2-playerSize/2, height/2-playerSize/2);
  line(width/2+playerSize/2, height/2-playerSize/2, width,0);
  line(0, height, width/2-playerSize/2, height/2+playerSize/2);
  line(width/2+playerSize/2, height/2+playerSize/2, width,height);
  noStroke();

  // player in center
  button.display();
}

void mousePressed() {
  up.checkClick();
  right.checkClick();
  down.checkClick();
  left.checkClick();
  button.checkClick();  
}
void mouseDragged() {
  up.checkClick();
  right.checkClick();
  down.checkClick();
  left.checkClick();
  button.checkClick();
}

// on release, turn off all buttons
void mouseReleased() {
  up.isClicked = false;
  right.isClicked = false;
  down.isClicked = false;
  left.isClicked = false;
  button.isClicked = false;
}

class CenterButton {
  int buttonSize;
  boolean isClicked = false;
  color offColor;
  color onColor;
  
  CenterButton (int _buttonSize, color _off, color _on) {
    buttonSize = _buttonSize;
    offColor = _off;
    onColor = _on;
  }
  
  void checkClick() {
    if (mouseX > width/2-buttonSize/2 && mouseX < width/2+buttonSize/2 && mouseY > height/2-buttonSize/2 && mouseY < height/2+buttonSize/2) {
      button.isClicked = true;
    }
    else {
      button.isClicked = false;
    }
  }
  
  void display() {
    rectMode(CENTER);
    noStroke();
    if (isClicked) fill(onColor);
    else fill(offColor);
    rect(width/2, height/2, buttonSize, buttonSize);
  }
}
