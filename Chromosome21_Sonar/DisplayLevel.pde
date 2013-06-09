
void displayLevel() {
  
  translate(width/2-playerSize/2, height/2-playerSize/2);
  noSmooth();
  image(level, -x*zoom, -y*zoom, level.width*zoom, level.height*zoom);

  if (dimView) {
    for (float y=-playerSize*zoom; y<playerSize*zoom; y+=playerSize) {
      for (float x=-playerSize*zoom; x<playerSize*zoom; x+=playerSize) {
        float distFromPlayer = abs(dist(0, 0, x, y));
        float dim = map(distFromPlayer, 0, dimDistance*zoom, 0, 255);
        dim = constrain(dim, 0, 255);
        fill(bgColor, dim);
        rect(x, y, playerSize, playerSize);
      }
    }
  }

  fill(255, 150, 0);
  noStroke();
  smooth();
  /*switch (dir) {
   case 'u':
   triangle(playerSize/2,0, playerSize,playerSize, 0,playerSize);
   break;
   case 'r':
   triangle(0,0, playerSize,playerSize/2, 0,playerSize);
   break;
   case 'd':
   triangle(0,0, playerSize,0, playerSize/2,playerSize);
   break;
   case 'l':
   triangle(playerSize,0, playerSize,playerSize, 0,playerSize/2);
   break;
   }*/
  rect(0, 0, playerSize, playerSize);
}
