
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
    isClicked = false;
    if (mouseX > width/2-buttonSize/2 && mouseX < width/2+buttonSize/2 && mouseY > height/2-buttonSize/2 && mouseY < height/2+buttonSize/2) {
      isClicked = true;
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
