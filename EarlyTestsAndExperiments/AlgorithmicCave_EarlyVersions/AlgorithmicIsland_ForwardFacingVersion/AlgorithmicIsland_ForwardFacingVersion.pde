
/*
ALGORITHMIC ISLAND - FORWARD-FACING VERSION
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Ideas and To Do:
 + diagonal beach option?
 + Run forest fire simulation to set terrain
 + sounds for each terrain?
 + diff terrains diff heights (forest is tall so you can't see in front of you, mountains, etc)
 + spoken text as you wander
 
 */

// basic setup variables
int w = 60;                          // level dimensions in px
int h = 40;
int multiplier = max(w/200, h/100);    // multiplier for various level sizes (based on a default of 200x100)
boolean saveIt = true;                 // save to file?
char direction = 'n';                  // which way is the player looking (n, e, s, w) 

// terrain variables
int maxInsetMove = 3;                  // amount the beach can move inward per step (up to edgeThresh)
int edgeThresh = min(w/2, h/2);        // furthest beach can erode in (here 1/2 the shortest window dimension)
int numRanges = 80 * multiplier;
int numRocks = 120 * multiplier;
int numFields = 10 * multiplier;
int numForests = 80 * multiplier;
int numPonds = 20 * multiplier;

// colors for each tile
color seaTile = color(75, 93, 147);  // or 48,56,80
color grassTile = color(75, 95, 40);
color beachTile = color(245, 210, 125);
color forestTile = color(7, 72, 10);
color mountainTile = color(95, 100, 105);
color rockTile = color(180);

// day/night
boolean showNight = false;
int maxDim = 180;            // max amount to dim at night (255 = total blackness)
String month = "January";    // for fancier changes over year

// display variables
int neighborTileHeight = 60;   // when displaying neighboring tiles, how large should they be?
int neighborTransparency = 30;  // dim the upcoming tile? (0 = no dimming, 255 = black)
boolean displayMap = false;    // toggled with 'm' key
boolean displayDirection = false;    // toggled with 'd' key

// other variables
int[][] level = new int[h][w];
int[][] heightmap = new int[h][w];
int playerX = int(random(0, w));    // start in random spot
int playerY = int(random(0, h));
final int GRASS = 0;      // tile codes
final int SEA = 1;
final int BEACH = 2;
final int FOREST = 3;
final int MOUNTAIN = 4;
final int ROCKS = 5;
PImage levelImage, heightmapImage;
PFont font;
ArrayList<PVector> testTiles = new ArrayList<PVector>();  // for removing stray beach that is unreachable by the player
boolean hitLand;


void setup() {
  size(800, 400);
  // size(displayWidth, displayHeight);
  frame.setTitle("Algorithmic Island");
  noCursor();

  // fonts
  font = loadFont("CenturyGothic-24.vlw");
  textFont(font, 24);
  textAlign(CENTER, CENTER);

  // build level, save if specified
  createLevel(w, h, maxInsetMove, edgeThresh, multiplier);
  levelImage = createLevelImage();
  createHeightmap();
  heightmapImage = createHeightmapImage();

  if (saveIt) {
    incrementAndSave(sketchPath("") + "/islands", "island", 3, levelImage);
    incrementAndSave(sketchPath("") + "/heightmaps", "heightmap", 3, heightmapImage);
  }

  // place player (not in the ocean or on isolated rafts of sand)
  while (level[playerY][playerX] == SEA 
    || level[playerY-1][playerX] == SEA 
    && level[playerY][playerX+1] == SEA
    && level[playerY+1][playerX] == SEA
    && level[playerY][playerX-1] == SEA) {
    playerX = int(random(0, w));
    playerY = int(random(0, h));
  }
}

void draw() { 

  drawSky();
  drawLevel(height/4, 100, 50);    // arguments: top edge of current tile, inset x, inset y  

  // if on, darken based on current time of day
  if (showNight) {
    if (hour() < 12) {
      fill(0, map(hour(), 0, 12, 0, 200));
    }
    else {
      fill(0, map(hour(), 0, 12, 200, 0));
    }
    rect(0, 0, width, height);
  }  

  // if on, show map and player location
  if (displayMap) {
    drawMapAndPlayer(true);    // true = fullscreen map, false = 200x100px map
  }

  // show direction
  if (displayDirection) {
    drawDirection();
  }
}

