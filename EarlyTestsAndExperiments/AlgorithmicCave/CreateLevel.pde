
void createLevel() {
  
  // set new blank level
  level = new int[h][w];
  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      level[y][x] = 0;
    }
  }

  // random walk to carve passages
  int px = playerX;                    // spawn from previous player location (allows reset of level during play)
  int py = playerY;
  for (int i=0; i<numSteps; i++) {
    level[py][px] = 255;
    if (random(1) < 0.5) {             // randomly move in x or y dir - ensures we can get to every tile w/o diagonal movement
      px += int(random(-2, 2));
      // px = constrain(px, 1, w-2);
      if (px < 0) {
        px = w-1;
      } else if (px >= w) {
        px = 0;
      }
    } else {
      py += int(random(-2, 2));
      // py = constrain(py, 1, h-2);
      if (py < 0) {
        py = h-1;
      } else if (py >= h) {
        py = h-1;
      }
    }
  }

  // remove stray bits of stone
  for (int y=1; y<h-1; y++) {
    for (int x=1; x<w-1; x++) {
      if (level[y][x] == 0 &&
        level[y-1][x] == 255 &&
        level[y][x+1] == 255 && 
        level[y+1][x] == 255 && 
        level[y][x-1] == 255) {
        level[y][x] = 255;
      }
    }
  }

  // fill open spaces with Perlin noise for heights
  float yOffset = 0.0;
  for (int y=0; y<h; y++) {
    float xOffset = 0.0;
    yOffset += noiseInc;
    for (int x=0; x<w; x++) {
      xOffset += noiseInc;
      if (level[y][x] == 255) {
        int newTile = int(noise(xOffset, yOffset)*255);
        newTile = constrain(newTile, 1, 255);              // new tile should not be solid stone (0)
        level[y][x] = newTile;
      }
    }
  }
}
