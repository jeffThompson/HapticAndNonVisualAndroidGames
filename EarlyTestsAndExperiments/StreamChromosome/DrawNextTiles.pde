
void drawNextTiles() {

  // starting coords
  int tx = width/2;
  int ty = height/2;

  pushMatrix();
  translate(tx, ty);
  for (int i=1; i<visionDist; i++) {
    if (pos+i > data.length()-1) continue;    // skip overflow

    // translate to next position (keeping track of screen coords with tx/ty)
    char c = data.charAt(pos+i);
    switch (c) {
    case 'a':
      translate(0, -gridSize);
      ty -= gridSize;
      break;
    case 'c':
      translate(gridSize, 0);
      tx += gridSize;
      break;
    case 'g':
      translate(0, gridSize);
      ty += gridSize;
      break;
    case 't':
      translate(-gridSize, 0);
      tx -= gridSize;
      break;
    }

    // check if there's already a tile there
    // if there is, don't draw on top
    // loadPixels();
    // if (pixels[ty * width + tx] == bgColor) {
    // updatePixels();
    fill(map(i, 1, visionDist, 150, 10));
    rect(0, 0, gridSize, gridSize);

    // draw a dot on the next tile to step to
    if (i == 1) {
      fill(255);
      rect(0, 0, 3, 3);
    }

    // display value for the tile (ATCG)
    // fill(0);
    // text(i, 0,0);
    // text(Character.toUpperCase(data.charAt(pos+i)), 0,10);
    // }
  }
  popMatrix();
}

