
void keyPressed() {
  
  // use menu button to toggle keyboard
  // via: http://stackoverflow.com/a/2348030
  if (key == CODED && keyCode == MENU) {
    InputMethodManager inputMgr = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
    inputMgr.toggleSoftInput(0, 0);
  }
  
  // R = reset player location
  else if (key == 'r') {
    playerX = level.width/2;
    playerY = level.height/2;
    startScreen = true;
  }
  
}
