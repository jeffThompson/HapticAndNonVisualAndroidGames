
PImage createHeightmapImage() {
  PImage temp = createImage(w,h, RGB);
  temp.loadPixels();
  for (int i=0; i<temp.pixels.length; i++) {
    temp.pixels[i] = color(heightmap[i/w][i%w]);
  }
  temp.updatePixels();
  return temp;
}
