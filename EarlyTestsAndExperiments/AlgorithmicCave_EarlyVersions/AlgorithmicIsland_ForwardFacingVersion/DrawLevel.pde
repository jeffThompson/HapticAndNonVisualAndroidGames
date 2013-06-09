
void drawLevel(int vertTop, int perspInsetX, int perspInsetY) {

  int l, ul, u, ur, r;
  switch (direction) {
  case 'n':                               // N
    l = level[playerY][playerX-1];
    ul = level[playerY-1][playerX-1];
    u = level[playerY-1][playerX];
    ur = level[playerY-1][playerX+1];
    r = level[playerY][playerX+1];
    break;
  case 'e':                               // E
    l = level[playerY-1][playerX];
    ul = level[playerY-1][playerX+1];
    u = level[playerY][playerX+1];
    ur = level[playerY+1][playerX+1];
    r = level[playerY+1][playerX];
    break; 
  case 's':                               // S 
    l = level[playerY][playerX+1];
    ul = level[playerY+1][playerX+1];
    u = level[playerY+1][playerX];
    ur = level[playerY+1][playerX-1];
    r = level[playerY][playerX-1];
    break;
  default:                                // W 
    l = level[playerY+1][playerX];
    ul = level[playerY+1][playerX-1];
    u = level[playerY][playerX-1];
    ur = level[playerY-1][playerX-1];
    r = level[playerY-1][playerX];
    break;
  }

  noStroke();

  // display current tile (-1 on y removes lines between tiles)
  fill(getTile(level[playerY][playerX]));
  beginShape();
  vertex(0, vertTop+perspInsetY-1);
  vertex(perspInsetX, vertTop-1);
  vertex(width-perspInsetX, vertTop-1);
  vertex(width, vertTop+perspInsetY-1);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  // U (-1/+1 on x removes lines between tiles)
  fill(getTile(u));
  beginShape();
  vertex(perspInsetX-1, vertTop);
  vertex(perspInsetX*2-1, vertTop-perspInsetY);
  vertex(width-perspInsetX*2+1, vertTop-perspInsetY);
  vertex(width-perspInsetX+1, vertTop);
  endShape(CLOSE);

  // UR
  fill(getTile(ur));
  beginShape();
  vertex(width-perspInsetX, vertTop);
  vertex(width-perspInsetX*2, vertTop-perspInsetY);
  vertex(width, vertTop-perspInsetY);
  vertex(width, vertTop);
  endShape(CLOSE);

  // R
  fill(getTile(r));
  beginShape();
  vertex(width-perspInsetX, vertTop);
  vertex(width, vertTop);
  vertex(width, vertTop+perspInsetY);
  endShape(CLOSE);

  // UL
  fill(getTile(ul));
  beginShape();
  vertex(0, vertTop);
  vertex(0, vertTop-perspInsetY);
  vertex(perspInsetX*2, vertTop-perspInsetY);
  vertex(perspInsetX, vertTop);
  endShape(CLOSE);

  // L
  fill(getTile(l));
  beginShape();
  vertex(0, vertTop);
  vertex(perspInsetX, vertTop);
  vertex(0, vertTop+perspInsetY);
  endShape(CLOSE);

  // former version:
  /*
  // look forward X tiles
   int visionDistance = 3;
   int nextTileHeight = 30;
   for (int i=0; i<=visionDistance; i++) {
   try {
   switch (direction) {
   case 'n':    // aka UP
   fill(getTile(level[playerY-i][playerX]));
   break;
   case 'e':    // aka RIGHT
   fill(getTile(level[playerY][playerX+i]));
   break;
   case 's':    // aka DOWN
   fill(getTile(level[playerY+i][playerX]));
   break;
   case 'w':    // aka LEFT
   fill(getTile(level[playerY][playerX-i]));
   break;
   }
   }
   catch (ArrayIndexOutOfBoundsException aioobe) {    // looking off the map?
   fill(getTile(SEA));
   }
   rect(0, vertTop - (i*nextTileHeight), width, -nextTileHeight);
   
   // dim (get darker as distance increases)
   fill(0, neighborTransparency + (i*30));
   //rect(0, vertTop - (i*nextTileHeight), width, -nextTileHeight);
   }
   
   // display current tile (height varies by type)
   noStroke();
   fill(getTile(level[playerY][playerX]));
   rect(0, vertTop, width, vertTop);
   
   // optional dimming at night
   if (showNight) {
   if (hour() < 12) {
   fill(0, map(hour(), 0, 12, maxDim, 0));
   }
   else {
   fill(0, map(hour(), 12, 23, 0, maxDim));
   }
   noStroke();
   rect(0, 0, width, height);
   }
   */
}

