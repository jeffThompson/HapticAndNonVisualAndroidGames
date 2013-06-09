
void createLevel(int w, int h, int maxInsetMove, int edgeThresh) {
  
  // fill with default (air)
  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      level[y][x] = AIR;
    }
  }
  
  // grow inner stone tiles
  for (int i=0; i<numInnerStones; i++) {
    int tx = int(random(0, w));
    int ty = int(random(0, h));
    int numSteps = int(random(1, maxStoneSteps));
    for (int step=0; step<numSteps; step++) {
      level[ty][tx] = STONE;
      tx += int(random(-2, 2));
      tx = constrain(tx, 0, w-1);
      ty += int(random(-2, 2));
      ty = constrain(ty, 0, h-1);
    }
  }
  
  // fill with open tiles with random heights using Perlin noise
  float yOffset = 0.0;
  for (int y=0; y<h; y++) {
    yOffset += 0.01;
    float xOffset = 0.0;
    for (int x=0; x<w; x++) {
      xOffset += 0.01;
      if (level[y][x] != STONE) {
        level[y][x] = int(noise(xOffset, yOffset) * 255);
      }
    }
  }

  // create ocean: top
  int rx = 0;
  int ry = 0;
  while (rx < w) {
    for (int y=ry; y>=0; y--) {
      level[y][rx] = STONE;
    }
    rx += int(random(0, 2));
    rx = constrain(rx, 0, w);
    ry += int(random(-maxInsetMove, maxInsetMove));
    ry = constrain(ry, 0, edgeThresh);
  }

  // create ocean: bottom
  rx = 0;
  ry = h-1;
  while (rx < w) {
    for (int y=ry; y<h; y++) {
      level[y][rx] = STONE;
    }
    rx += int(random(0, 2));
    rx = constrain(rx, 0, w);
    ry += int(random(-maxInsetMove, maxInsetMove));
    ry = constrain(ry, h-edgeThresh, h-1);
  }

  // create ocean: left
  rx = 0;
  ry = 0;
  while (ry < h) {
    for (int x=rx; x>=0; x--) {
      level[ry][x] = STONE;
    }
    ry += int(random(0, 2));
    ry = constrain(ry, 0, h);
    rx += int(random(-maxInsetMove, maxInsetMove));
    rx = constrain(rx, 0, edgeThresh);
  }

  // create ocean: right
  rx = w-1;
  ry = 0;
  while (ry < h) {
    for (int x=rx; x<w; x++) {
      level[ry][x] = STONE;
    }
    ry += int(random(0, 2));
    ry = constrain(ry, 0, h);
    rx += int(random(-maxInsetMove, maxInsetMove));
    rx = constrain(rx, w-edgeThresh, w-1);
  }

  // done generating level!
}
