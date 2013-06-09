
void drawMapAndPlayer() {
  background(0);
  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      if (x == playerX && y == playerY) {
        fill(255,150,0);
      }
      else {
        fill(level[y][x]);
      }
      rect(x*mapGridSize, y*mapGridSize, mapGridSize, mapGridSize);
    }
  }
}
