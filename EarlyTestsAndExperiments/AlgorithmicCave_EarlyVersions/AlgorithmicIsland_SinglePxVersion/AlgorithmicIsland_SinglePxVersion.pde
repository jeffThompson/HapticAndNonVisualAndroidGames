
/*
SMELL GAME LEVEL TESTS
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Ideas and To Do:
 + diagonal beach option?
 + Run forest fire simulation to set terrain
 + remove isolated islands that can't be reached
 
 */

// basic setup variables
int w = 200;                      // level dimensions in px
int h = 100;
int maxInsetMove = 3;             // amount the beach can move inward per step (up to edgeThresh)
int edgeThresh = min(w/2, h/2);   // furthest beach can erode in (here 1/2 the shortest window dimension)
boolean saveIt = true;            // save to file?

// # of each terrain to grow (vary to change makeup of island)
int numRanges = 80;
int numRocks = 120;
int numFields = 10;
int numForests = 80;
int numPonds = 20;

// colors for each tile
color seaTile = color(70, 150, 220);
color grassTile = color(75, 95, 40);
color beachTile = color(245, 210, 125);
color forestTile = color(7, 72, 10);
color mountainTile = color(95, 100, 105);
color rockTile = color(180);

// day/night
boolean showNight = true;
int maxDim = 180;            // max amount to dim at night (255 = total blackness)
String month = "January";    // for fancier changes over year

// display variables
int neighborTileHeight = 60;   // when displaying neighboring tiles, how large should they be?
int neighborTransparency = 180;
boolean displayMap = false;    // toggled with 'm' key

// other variables
int[][] level = new int[h][w];
int playerX = 1;    // start at 1 so we can check all neighbors
int playerY = 1;
final int GRASS = 0;
final int SEA = 1;
final int BEACH = 2;
final int FOREST = 3;
final int MOUNTAIN = 4;
final int ROCKS = 5;
PImage levelImage;


void setup() {
  size(displayWidth, displayHeight);
  frame.setTitle("Algorithmic Island");
  noCursor();
  
  // build level, save if specified
  createLevel(w, h, maxInsetMove, edgeThresh);
  levelImage = createLevelImage();
  if (saveIt) {
    incrementAndSave(sketchPath("") + "/output", 3);
  }
  
  // place player (not in the ocean or on isolated rafts of sand)
  while (level[playerY][playerX] == SEA 
         || level[playerY-1][playerX] == SEA 
         && level[playerY][playerX+1] == SEA
         && level[playerY+1][playerX] == SEA
         && level[playerY][playerX-1] == SEA) {
    playerX = int(random(1, w-1));
    playerY = int(random(1, h-1));
  }
}

void draw() {
  
  // display current tile
  noStroke();
  fill(getTile(level[playerY][playerX]));
  rect(0,0, width,height);
  
  // display neighbors
  stroke(255,100);
  fill(getTile(level[playerY-1][playerX]), neighborTransparency);      // U
  rect(neighborTileHeight,0, width-neighborTileHeight*2,neighborTileHeight);
  // quad(0,0, width,0, width-neighborTileHeight,neighborTileHeight, neighborTileHeight,neighborTileHeight);
  
  fill(getTile(level[playerY-1][playerX+1]), neighborTransparency);    // UR
  rect(width,0, -neighborTileHeight,neighborTileHeight);
  
  fill(getTile(level[playerY][playerX+1]), neighborTransparency);      // R
  rect(width,neighborTileHeight, -neighborTileHeight,height-neighborTileHeight*2);
  // quad(width,0, width,height, width-neighborTileHeight,height-neighborTileHeight, width-neighborTileHeight,neighborTileHeight);
  
  fill(getTile(level[playerY+1][playerX+1]), neighborTransparency);    // DR
  rect(width,height, -neighborTileHeight,-neighborTileHeight);
  
  fill(getTile(level[playerY+1][playerX]), neighborTransparency);      // D
  rect(neighborTileHeight,height, width-neighborTileHeight*2,-neighborTileHeight);
  // quad(0,height, width,height, width-neighborTileHeight,height-neighborTileHeight, neighborTileHeight,height-neighborTileHeight);
  
  fill(getTile(level[playerY+1][playerX-1]), neighborTransparency);    // DL
  rect(0,height, neighborTileHeight,-neighborTileHeight);
  
  fill(getTile(level[playerY][playerX-1]), neighborTransparency);      // L
  rect(0,neighborTileHeight, neighborTileHeight,height-neighborTileHeight*2);
  // quad(0,0, 0,height, neighborTileHeight,height-neighborTileHeight, neighborTileHeight,neighborTileHeight);

  fill(getTile(level[playerY-1][playerX-1]), neighborTransparency);    // UL
  rect(0,0, neighborTileHeight,neighborTileHeight);

  // optional dimming at night
  if (showNight) {
    if (hour() < 12) {
      fill(0, map(hour(), 0,12, maxDim,0));
    }
    else {
      fill(0, map(hour(), 12,23, 0,maxDim));
    }
    noStroke();
    rect(0,0, width,height);
  }    
    
  // if on, show map and player location
  if (displayMap) {
    image(levelImage, 0,0);
    noStroke();
    fill(255);
    ellipse(playerX,playerY, 8,8);
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && level[playerY-1][playerX] != SEA) {
      playerY -= 1;
    }
    else if (keyCode == RIGHT && level[playerY][playerX+1] != SEA) {
      playerX += 1;
    }
    else if (keyCode == DOWN && level[playerY+1][playerX] != SEA) {
      playerY += 1;
    }
    else if (keyCode == LEFT && level[playerY][playerX-1] != SEA) {
      playerX -= 1;
    }
  }

  // cheat code to display map!
  if (key == 'm') {
    displayMap = !displayMap;
  }
}
