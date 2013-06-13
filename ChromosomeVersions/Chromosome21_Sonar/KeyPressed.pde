
void keyPressed() {
  
  // if on start screen, any key will exit to level
  if (startScreen) {
    startScreen = false;
  }
  
  // R = reset level (and new player position)
  else if (key == 'r') {
    resetPlayerPosition();
    startScreen = true;
  }
  
  // D = toggle level visibility
  else if (key == 'd') {
    showLevel = !showLevel;
  }
  
  // S = scan
  else if (key == 's') {
    sonarScan();
  }
  
  // arrow keys = move player
  else if (key == CODED) {
    movePlayer();
  }
}
