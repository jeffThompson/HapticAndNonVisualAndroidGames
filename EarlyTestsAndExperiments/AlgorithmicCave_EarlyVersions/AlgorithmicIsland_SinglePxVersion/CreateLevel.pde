
void createLevel(int w, int h, int maxInsetMove, int edgeThresh) {

  // fill with default (grass)
  for (int y=1; y<h-1; y++) {
    for (int x=1; x<w-1; x++) {
      level[y][x] = GRASS;
    }
  }

  // grow some mountain ranges (doing this first seems to make more realistic chains of mountains)
  for (int mountain=0; mountain<numRanges; mountain++) {
    int tx = int(random(0, w));
    int ty = int(random(0, h));
    int numSteps = int(random(1, 60));
    for (int step=0; step<numSteps; step++) {
      level[ty][tx] = MOUNTAIN;
      tx += int(random(-2, 2));
      tx = constrain(tx, 0, w-1);
      ty += int(random(-2, 2));
      ty = constrain(ty, 0, h-1);
    }
  }

  // grow rock fields
  for (int rock=0; rock<numRocks; rock++) {
    int tx = int(random(0, w));
    int ty = int(random(0, h));
    int numSteps = int(random(1, 60));
    for (int step=0; step<numSteps; step++) {
      level[ty][tx] = ROCKS;
      tx += int(random(-2, 2));
      tx = constrain(tx, 0, w-1);
      ty += int(random(-2, 2));
      ty = constrain(ty, 0, h-1);
    }
  }

  // grow some forests too!
  for (int forest=0; forest<numForests; forest++) {
    int tx = int(random(0, w));
    int ty = int(random(0, h));
    int numSteps = int(random(10, 1500));
    for (int step=0; step<numSteps; step++) {
      level[ty][tx] = FOREST;
      tx += int(random(-2, 2));
      tx = constrain(tx, 0, w-1);
      ty += int(random(-2, 2));
      ty = constrain(ty, 0, h-1);
    }
  }
  
  // grow some ponds
  for (int pond=0; pond<numPonds; pond++) {
    int tx = int(random(0, w));
    int ty = int(random(0, h));
    int numSteps = int(random(10, 100));
    for (int step=0; step<numSteps; step++) {
      level[ty][tx] = SEA;
      tx += int(random(-2, 2));
      tx = constrain(tx, 0, w-1);
      ty += int(random(-2, 2));
      ty = constrain(ty, 0, h-1);
    }
  }

  // finally, grow some fields to fill in
  for (int field=0; field<numFields; field++) {
    int tx = int(random(0, w));
    int ty = int(random(0, h));
    int numSteps = int(random(10, 1500));
    for (int step=0; step<numSteps; step++) {
      level[ty][tx] = GRASS;
      tx += int(random(-2, 2));
      tx = constrain(tx, 0, w-1);
      ty += int(random(-2, 2));
      ty = constrain(ty, 0, h-1);
    }
  }

  // rocks around all mountains
  for (int y=1; y<h-1; y++) {
    for (int x=1; x<w-1; x++) {
      if (level[y][x] == MOUNTAIN) {
        if (level[y-1][x] != MOUNTAIN) {
          level[y-1][x] = ROCKS;
        }
        if (level[y+1][x] != MOUNTAIN) {
          level[y+1][x] = ROCKS;
        }
        if (level[y][x-1] != MOUNTAIN) {
          level[y][x-1] = ROCKS;
        }
        if (level[y][x+1] != MOUNTAIN) {
          level[y][x+1] = ROCKS;
        }
      }
    }
  }

  // create ocean: top
  int rx = 0;
  int ry = 0;
  while (rx < w) {
    for (int y=ry; y>=0; y--) {
      level[y][rx] = SEA;
    }
    level[ry+1][rx] = BEACH;

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
      level[y][rx] = SEA;
    }
    level[ry-1][rx] = BEACH;

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
      level[ry][x] = SEA;
    }
    level[ry][rx+1] = BEACH;

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
      level[ry][x] = SEA;
    }
    level[ry][rx-1] = BEACH;

    ry += int(random(0, 2));
    ry = constrain(ry, 0, h);
    rx += int(random(-maxInsetMove, maxInsetMove));
    rx = constrain(rx, w-edgeThresh, w-1);
  }    

  // add beach along coastline
  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      if (level[y][x] == SEA) {
        if (y-1 >= 0 && level[y-1][x] != SEA) {
          level[y-1][x] = BEACH;
        }
        if (y+1 < h && level[y+1][x] != SEA) {
          level[y+1][x] = BEACH;
        }
        if (x-1 >= 0 && level[y][x-1] != SEA) {
          level[y][x-1] = BEACH;
        }
        if (x+1 < w && level[y][x+1] != SEA) {
          level[y][x+1] = BEACH;
        }
      }
    }
  }
}
