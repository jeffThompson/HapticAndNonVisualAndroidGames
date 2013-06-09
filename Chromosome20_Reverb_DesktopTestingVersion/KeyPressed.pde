
void keyPressed() {
  
  if (startScreen) {
    startScreen = false;
  }
  else if (key == 'r') {
    playerX = level.width/2;
    playerY = level.height/2;
    startScreen = true;
  }
  
  else if (key == CODED) {

    // UP/NORTH    
    if (keyCode == UP) {
      if (playerY-1 < 0 && level.pixels[(level.height-1) * level.width + playerX] != bgColor) {
        playerY = level.height-1;
      }
      else if (level.pixels[(playerY-1) * level.width + playerX] != bgColor) {
        playerY -= 1;
      }
    }
    
    // RIGHT/EAST
    else if (keyCode == RIGHT) {
     if (playerX+1 > level.width-1 && level.pixels[playerY * level.width] != bgColor) {
        playerX = 0;
      }
      else if (level.pixels[playerY * level.width + playerX+1] != bgColor) {
        playerX += 1;
      }
    }
    
    // DOWN/SOUTH
    else if (keyCode == DOWN) {
      if (playerY+1 > level.height-1 && level.pixels[playerX] != bgColor) {
        playerY = 0;
      }
      else if (level.pixels[(playerY+1) * level.width + playerX] != bgColor) {
        playerY += 1;
      }
    }
    
    // LEFT/WEST
    else if (keyCode == LEFT) {
     if (playerX-1 < 0 && level.pixels[playerY * level.width + level.width-1] != bgColor) {
        playerX = level.width-1;
      }
      else if (level.pixels[playerY * level.width + playerX-1] != bgColor) {
        playerX -= 1;
      }
    }
  }
}
