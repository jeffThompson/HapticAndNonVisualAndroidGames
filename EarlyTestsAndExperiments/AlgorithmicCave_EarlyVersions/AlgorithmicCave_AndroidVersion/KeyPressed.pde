

void keyPressed() {

  // use menu button to toggle keyboard
  if (key == CODED && keyCode == MENU) {

    // turn on keyboard - via: http://stackoverflow.com/a/2348030
    InputMethodManager inputMgr = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
    inputMgr.toggleSoftInput(0, 0);
  }
  
  // toggle map and compass
  if (key == 'm') {
    displayMap = !displayMap;
  }
  else if (key == 'd') {
    displayDirection = !displayDirection;
  }
}
