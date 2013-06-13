
void drawNeighboringTiles() {

  int w = levelWidth;
  int h = levelHeight;
  rectMode(CENTER);
  noStroke();

  for (int y=0; y<=visionDistance*2; y++) {    
    for (int x=0; x<=visionDistance*2; x++) {

      // get color for tile
      int px = playerX - visionDistance + x;      
      int py = playerY - visionDistance + y;

      if (px < 0) {
        px += w;
      }
      else if (px >= w) {
        px = px % w;
      }
      if (py < 0) {
        py += h;
      }
      else if (py >= h) {
        py = py % h;
      }
      fill(level.pixels[py * level.width + px]);

      // draw grid tile
      int xPos = width/2 - (visionDistance * playerSize) + (x * playerSize);
      int yPos = height/2 - (visionDistance * playerSize) + (y * playerSize);
      rect(xPos, yPos, playerSize, playerSize);    // hack to remove lines b/w tiles

      // draw player
      if (px == playerX && py == playerY) {
        fill(playerColor);
        ellipse(xPos, yPos, playerSize/2, playerSize/2);
      }

      // overlay darkness
      /*float dist = abs(dist(px, py, playerX, playerY));
      float dim = map(dist, 0, visionDistance-1, 0, 255);
      fill(0, dim);
      rect(xPos, yPos, playerSize, playerSize);*/
    }
  }

  rectMode(CORNER);
}

