
/*
CHROMOSOME #21: SONAR
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 TO DO:
 + maxDepth could be used to set difficulty level
 + move/look diagonally?
 + vibration too? when hit a wall? footstep?
 + face direction for sonar? could rotate with a button, move in that dir (but not move in space)
 
 */

String filename = "Chromosome21.txt";  // data file to read
int maxDepth = -1;                     // -1 means run entire file
int levelWidth = 5000;
int levelHeight = 5000;

color bgColor = color(20, 15, 10);
color openColor = color(60, 55, 50);
color traversedColor = color(255, 0, 0);   // temp color to know what pixels we've crossed (deleted later)

int visionDistance = 8;                   // # of tiles shown onscreen in each direction
boolean dimView = true;
int dimDistance = visionDistance-2;       // radius of tiles for dimming to background color (inc player)
boolean showLevel = true;  
boolean respawnOnWallHit = true;
boolean saveLevelImage = true;
PFont headlineFont, detailFont;

BufferedReader reader;
PImage level;
int x, y;
char dir = 'u';        // player direction (u, d, l , r)
float zoom, playerSize;
boolean startScreen = true;

void setup() {
  size(1200, 800);
  frame.setTitle("Chromosome #21: Sonar");

  createLevelImage(levelWidth/2, levelHeight/2);    // start x,y
  zoom = playerSize = max(width, height)/(visionDistance*2 + 1);
  if (saveLevelImage) level.save("LevelImages/Level_" + levelWidth + "x" + levelHeight + "_" + maxDepth + "depth.tiff");
  resetPlayerPosition();
  println("Starting position: " + x + ", " + y);

  headlineFont = loadFont("OstrichSans-Black-144.vlw");
  detailFont = loadFont("OstrichSans-Black-36.vlw");
}

void draw() {
  if (startScreen) {
    displayStartScreen();
  } 
  
  else {
    background(bgColor);
    
    if (showLevel) {
      displayLevel();
    }
  }
}

void mousePressed() {
  if (!startScreen) {
    switch (dir) {
    case 'u':
      dir = 'r';
      break;
    case 'r':
      dir = 'd';
      break;
    case 'd':
      dir = 'l';
      break;
    case 'l':
      dir = 'u';
      break;
    }
  }
}

