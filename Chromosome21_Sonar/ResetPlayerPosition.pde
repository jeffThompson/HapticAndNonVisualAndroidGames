
void resetPlayerPosition() {
  
  level.loadPixels();
  x = int(random(1,level.width-1));
  y = int(random(1,level.height-1));
  
  while (level.pixels[y*level.width + x] != openColor || (level.pixels[(y-1)*level.width + x] == bgColor && level.pixels[y*level.width + x+1] == bgColor && level.pixels[(y+1)*level.width + x] == bgColor && level.pixels[y*level.width + x-1] == bgColor)) {
    x = int(random(1,level.width-1));
    y = int(random(1,level.height-1));
  }
  
  level.updatePixels();
}
