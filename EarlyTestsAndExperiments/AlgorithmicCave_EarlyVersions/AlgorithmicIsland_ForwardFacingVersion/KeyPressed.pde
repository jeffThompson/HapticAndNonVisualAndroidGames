
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (direction == 'n' && level[playerY-1][playerX] != SEA) {
        playerY -= 1;
      } 
      else if (direction == 'e' && level[playerY][playerX+1] != SEA) {
        playerX += 1;
      }
      else if (direction == 's' && level[playerY+1][playerX] != SEA) {
        playerY += 1;
      }
      else if (direction == 'w' && level[playerY][playerX-1] != SEA) {
        playerX -= 1;
      }
    }
    else if (keyCode == RIGHT) {  // ugly (well, sort of) - clean up
      switch (direction) {
      case 'n': 
        direction = 'e'; 
        break;
      case 'e': 
        direction = 's'; 
        break;
      case 's': 
        direction = 'w'; 
        break;
      case 'w': 
        direction = 'n'; 
        break;
      }
    }
    else if (keyCode == LEFT) {
      switch (direction) {
      case 'n': 
        direction = 'w'; 
        break;
      case 'e': 
        direction = 'n'; 
        break;
      case 's': 
        direction = 'e'; 
        break;
      case 'w': 
        direction = 's'; 
        break;
      }
    }
  }

  // cheat code to display map and direction
  if (key == 'm') {
    displayMap = !displayMap;
  }
  else if (key == 'd') {
    displayDirection = !displayDirection;
  }
}
