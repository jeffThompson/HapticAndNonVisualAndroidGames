
void movePlayer(char dir) {

  if (dir == 'u') {
    if (playerY-1 < 0 && level.pixels[(level.height-1) * level.width + playerX] != bgColor) {
      playerY = level.height-1;
      playFootsteps();
    }
    else if (level.pixels[(playerY-1) * level.width + playerX] != bgColor) {
      playerY -= 1;
      playFootsteps();
    }
  }

  else if (dir == 'd') {
    if (playerY+1 > level.height-1 && level.pixels[playerX] != bgColor) {
      playerY = 0;
      playFootsteps();
    }
    else if (level.pixels[(playerY+1) * level.width + playerX] != bgColor) {
      playerY += 1;
      playFootsteps();
    }
  }

  else if (dir == 'r') {
    if (playerX+1 > level.width-1 && level.pixels[playerY * level.width] != bgColor) {
      playerX = 0;
      playFootsteps();
    }
    else if (level.pixels[playerY * level.width + playerX+1] != bgColor) {
      playerX += 1;
      playFootsteps();
    }
  }

  else if (dir == 'l') {
    if (playerX-1 < 0 && level.pixels[playerY * level.width + level.width-1] != bgColor) {
      playerX = level.width-1;
      playFootsteps();
    }
    else if (level.pixels[playerY * level.width + playerX-1] != bgColor) {
      playerX -= 1;
      playFootsteps();
    }
  }
}

