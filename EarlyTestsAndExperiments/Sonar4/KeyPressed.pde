
void keyPressed() {

  // use menu button to toggle keyboard
  // via: http://stackoverflow.com/a/2348030
  if (key == CODED && keyCode == MENU) {
    InputMethodManager inputMgr = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
    inputMgr.toggleSoftInput(0, 0);
  }

  // toggle blindless!
  else if (key == 'o') {
    showObjects = !showObjects;
  }
  
  // toggle sonar scan visibility
  else if (key == 's') {
    showSonar = !showSonar;
  }
}
