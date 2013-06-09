
void keyPressed() {

  // use menu button to toggle keyboard
  // via: http://stackoverflow.com/a/2348030
  if (key == CODED && keyCode == MENU) {
    InputMethodManager inputMgr = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
    inputMgr.toggleSoftInput(0, 0);
  }

  // spacebar redraws a new level
  else if (key == 32) {
    setup();
  }
  
  // R key does full restart
  else if (key == 'r') {
    titleScreen = true;
    setup();
  }
  
  // adjust vision distance (+/-)
  else if (key == '+') {
    visionDist += 1;
    gridSize = min(width/(visionDist*2), height/(visionDist*2));
  }
  else if (key == '-') {
    visionDist -= 1;
    if (visionDist < 1) {      // can't be less than 1!
      visionDist = 1;
    }
    gridSize = min(width/(visionDist*2), height/(visionDist*2));
  }
  
  // display fullscreen map
  else if (key == 'm') {
    displayMap = !displayMap;
  }
  
  // display small map
  else if (key == 't') {
    displaySmallMap = !displaySmallMap;
  }
  
  // display direction
  else if (key == 'd') {
    displayDirection = !displayDirection;
  }
  
  // S to test dripping
  else if (key == 's') {
    playDrip();
  }
}
