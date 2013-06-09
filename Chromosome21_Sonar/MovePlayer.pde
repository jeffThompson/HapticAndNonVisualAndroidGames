
void movePlayer() {
  
  char dirMove = 'u';

  // UP/NORTH    
  if (keyCode == UP) {
    dirMove = 'u';
    if (y-1 < 0) {
      y = level.height-1;
    }
    else {
      y -= 1;
    }
  }
  
  // RIGHT/EAST
  else if (keyCode == RIGHT) {
   dirMove = 'r';
   if (x+1 > level.width-1) {
      x = 0;
    }
    else {
      x += 1;
    }
  }
  
  // DOWN/SOUTH
  else if (keyCode == DOWN) {
    dirMove = 'd';
    if (y+1 > level.height-1) {
      y = 0;
    }
    else {
      y += 1;
    }
  }
  
  // LEFT/WEST
  else if (keyCode == LEFT) {
   dirMove = 'l';
   if (x-1 < 0) {
      x = level.width-1;
    }
    else {
      x -= 1;
    }
  }
  
  // if we're now on a wall, run hit() code
  if (level.pixels[y*level.width + x] == bgColor) {
    hitWall(dirMove);
  }
}
