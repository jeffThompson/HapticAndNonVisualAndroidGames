
void sonarScan() {
  
  char[] scan = new char[4];
  color upColor, rightColor, downColor, leftColor;
  
  if (y-1 < 0) {
    upColor = level.pixels[(level.height-1)*level.width + x];
  }
  else {
    upColor = level.pixels[(y-1)*level.width + x];
  }
  if (upColor == bgColor) {
    scan[0] = '–';
  }
  else {
    scan[0] = '.';
  }
  
  if (x+1 > level.width-1) {
    rightColor = level.pixels[y*level.width];
  }
  else {
    rightColor = level.pixels[y*level.width + x+1];
  }
  if (rightColor == bgColor) {
    scan[1] = '|';
  }
  else {
    scan[1] = '.';
  }
   
  if (y+1 > level.height-1) {
    downColor = level.pixels[x];
  }
  else {
    downColor = level.pixels[(y+1)*level.width + x];
  }
  if (downColor == bgColor) {
    scan[2] = '–';
  }
  else {
    scan[2] = '.';
  }
  
  if (x-1 < 0) {
    leftColor = level.pixels[y*level.width + level.width-1];
  }
  else {
    leftColor = level.pixels[y*level.width + x-1];
  }
  if (leftColor == bgColor) {
    scan[3] = '|';
  }
  else {
    scan[3] = '.';
  }
  
  println("  " + scan[0] + "  ");
  println(scan[3] + "   " + scan[1]);
  println("  " + scan[2] + "  ");
  println();
  
  /*for (boolean d : scan) {
    if (d == true) {
      print("*");
    }
    else {
      print("-");
    }
  }
  println();*/
}
