
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
  
  // alternative to clean up extraneous beach - works ok but misses some spots
  // via: https://forum.processing.org/topic/find-unreachable-parts-of-an-image#25080000002138073
  /*PImage eroded = temp.get();
  int erodeLevel = 5;
  for (int i=0; i<erodeLevel; i++) {
    eroded.filter(ERODE);
  }
  for (int i=0; i<temp.pixels.length; i++) {
    if (eroded.pixels[i] == seaTile) {
      temp.pixels[i] = seaTile;
    }
  }*/
  
  temp.updatePixels();
  return temp;
}
