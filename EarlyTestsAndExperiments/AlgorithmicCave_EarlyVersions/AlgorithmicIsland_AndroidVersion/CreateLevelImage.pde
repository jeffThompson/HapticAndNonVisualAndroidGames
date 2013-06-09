
PImage createLevelImage() {
  PImage temp = createImage(w, h, RGB);
  
  temp.loadPixels();
  for (int i=0; i<temp.pixels.length; i++) {
    switch (level[i/w][i%w]) {
    case SEA: 
      temp.pixels[i] = seaTile;
      break;
    case BEACH: 
      temp.pixels[i] = beachTile; 
      break;
    case GRASS: 
      temp.pixels[i] = grassTile; 
      break;
    case FOREST: 
      temp.pixels[i] = forestTile; 
      break;
    case MOUNTAIN: 
      temp.pixels[i] = mountainTile;
      break;
    case ROCKS:
      temp.pixels[i] = rockTile;
      break;
    }
  }
  
  temp.updatePixels();
  return temp;
}
