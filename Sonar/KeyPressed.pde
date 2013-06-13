
void keyPressed() {

  // use menu button to toggle keyboard
  // via: http://stackoverflow.com/a/2348030
  if (key == CODED && keyCode == MENU) {
    InputMethodManager inputMgr = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
    inputMgr.toggleSoftInput(0, 0);
  }

  // toggle obstacle visibility
  else if (key == 'o') {
    showObjects = !showObjects;
  }

  // toggle sonar scan visibility
  else if (key == 's') {
    showSonar = !showSonar;
  }

  // toggle framerate onscreen
  else if (key == 'd') {
    showDebug = !showDebug;
  }

  // # keys reset obstacle list to that # of obs
  else if (key > 49 && key < 58) {
    numObstacles = int(key - 48);    // 49 = 1, so 49-48 = 1!
    obstacles.clear();
    for (int i=0; i<numObstacles; i++) {
      obstacles.add(new Obstacle(random(0, width), random(-height, 0)));
    }
  }
}

