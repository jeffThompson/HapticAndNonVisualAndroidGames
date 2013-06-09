
// create heightmap from finished level
void createHeightmap() {

  // create 2d Perlin noise as a baseline for the image
  float yOffset = 0.0;
  for (int y=0; y<h; y++) {
     yOffset += 0.01;
     float xOffset = 0.0;
 
    for (int x=0; x<w; x++) {
      xOffset += 0.01;
      heightmap[y][x] = int(noise(xOffset, yOffset) * 255);
    }
  }
  
  // adjust based on which tile it falls on
  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      if (level[y][x] == SEA) {                  // ocean is at 0 (sea level!)
        heightmap[y][x] = 0;
      }
      else if (level[y][x] == MOUNTAIN) {        // mountains should be higher
        heightmap[y][x] += int(random(0,100));
        heightmap[y][x] = constrain(heightmap[y][x], 0,255);
      }
    }
  }
  
  // run kernal on image to smooth
  int[][] smoothedHeightmap = new int[h][w];
  for (int y=1; y<h-1; y++) {
    for (int x=1; x<w-1; x++) {
      // c, u, ur, r, lr, d, ll, l, ul
      int sum = heightmap[y][x] + heightmap[y-1][x] + heightmap[y-1][x+1] + heightmap[y][x+1] + heightmap[y+1][x+1] + heightmap[y+1][x] + heightmap[y-1][x-1] + heightmap[y][x-1] + heightmap[y+1][x-1];
      int average = sum/9;
      smoothedHeightmap[y][x] = average;
    }
  }   
  for (int y=1; y<h-1; y++) {    // copy into original array
    for (int x=1; x<w-1; x++) {
      heightmap[y][x] = smoothedHeightmap[y][x];
    }
  }
  
  // one more time, make ocean 0
    // adjust based on which tile it falls on
  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      if (level[y][x] == SEA) {                  // ocean is at 0 (sea level!)
        heightmap[y][x] = 0;
      }
    }
  }
  
  // done!
}

