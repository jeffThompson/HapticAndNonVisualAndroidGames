
PImage createLevelImage() {
  PImage temp = createImage(w, h, RGB);
  
  temp.loadPixels();
  for (int i=0; i<temp.pixels.length; i++) {
    switch (level[i/w][i%w]) {
    //case AIR: 
    //  temp.pixels[i] = airTile;
    //  break;
    case STONE: 
      temp.pixels[i] = stoneTile; 
      break;
    default:
      temp.pixels[i] = color(level[i/w][i%w]);
    }
  }
  
  temp.updatePixels();
  return temp;
}
