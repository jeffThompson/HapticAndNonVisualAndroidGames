
void drawLevel() {
  // background(level[playerY][playerX]);

  background(0);
  rectMode(CENTER);
  
  for (int y=0; y<=visionDist*2; y++) {    
    for (int x=0; x<=visionDist*2; x++) {
      
      // get color for tile
      int px = playerX - visionDist + x;      
      int py = playerY - visionDist + y;
      //if (px < 0 || px > w-1 || py < 0 || py > h-1) {
      //  fill(0);
      //}
      //else {
      //  fill(level[py][px]);
      //}
      
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
      fill(level[py][px]);
      
      // draw grid tile
      int xPos = width/2 - (visionDist * gridSize) + (x * gridSize);
      int yPos = height/2 - (visionDist * gridSize) + (y * gridSize);
      rect(xPos, yPos, gridSize,gridSize);    // hack to remove lines b/w tiles
      
      // draw player
      if (px == playerX && py == playerY) {
        fill(255, 150, 0);
        ellipse(xPos,yPos, gridSize/2,gridSize/2); 
      }
      
      // overlay darkness
      float dist = abs(dist(px,py, playerX,playerY));
      float dim = map(dist, 0,visionDist-1, 0,255);
      fill(0, dim);
      rect(xPos,yPos, gridSize,gridSize);
    }
  }
  
  rectMode(CORNER);
}
