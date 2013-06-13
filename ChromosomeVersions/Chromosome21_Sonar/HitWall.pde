
void hitWall(char dirMove) {
  
  // if specified, respawn in a new spot
  if (respawnOnWallHit) {
    resetPlayerPosition();
  }
  
  // otherwise, use dirMove to set back (not on wall but on previous tile)
  else {
    switch (dirMove) {
    case 'u':
      y += 1;
      if (y > level.height-1) y = 0;
      break;
    case 'r':
      x -= 1;
      if (x < 0) x = level.width-1;
      break;
    case 'd':
      y -= 1;
      if (y < 0) y = level.height-1;
      break;
    case 'l':
      x += 1;
      if (x > level.width-1) x = 0;
      break;
    }
  }

}

