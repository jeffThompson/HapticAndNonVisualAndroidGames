
void createLevelImage() {
  // create image of level to display onscreen
  levelImage = createImage(w, h, RGB);
  levelImage.loadPixels();
  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      levelImage.pixels[y*w+x] = color(level[y][x]);
    }
  }
  levelImage.updatePixels();

  // save if specified
  if (saveIt) {
    noSmooth();
    image(levelImage, 0, 0, width, height);
    fill(255, 150, 0);
    rect(playerX * tileSizeX, playerY * tileSizeY, tileSizeX, tileSizeY);
    incrementAndSave(sketchPath("") + "/maps", "map", 3);
  }
}
