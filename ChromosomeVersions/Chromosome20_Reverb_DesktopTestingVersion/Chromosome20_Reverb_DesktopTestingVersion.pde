
/*
CHROMOSOME #20: REVERB
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 NOTES:
 + DNA is white, en mass
    http://answers.yahoo.com/question/index?qid=20110222173811AAZ2Xwk
 
 + It vibrates (approx 3x10^11 to 3x10^12 Hz - in the "terahertz" range)
    http://en.wikipedia.org/wiki/Low-frequency_collective_motion_in_proteins_and_DNA
    http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1143999/pdf/biochemj00324-0036.pdf
 
 Chromosome data via:
 http://www.gutenberg.org/ebooks/11794
 */


// LEVEL VARIABLES
int levelWidth = 2000;                 // level width in px
int levelHeight = 2000;                // ditto height
int maxDepth = MAX_INT;                // restrict the # of data points read (MAX_INT = read entire file)
boolean saveImage = true;              // save level as an image file

// COLOR VARIABLES
color bgColor = color(0);              // background color
color playerColor = color(255, 150, 0);
color startColor = color(30, 0,0);    // initial color for a traversed pixel
int colorInc = 5;                     // increment for previously traversed pixels

// DISPLAY VARIABLES
boolean loadFromDiskIfAvailable = false;  // load level from disk if similar file exists; will not reflect color changes
int visionDistance = 6;                  // radius of tiles shown onscreen
int dimDistance = 3;                     // radius of tiles for dimming to background color

// START SCREEN
boolean startScreen = true;

// OTHER VARIABLES
String filename = "Chromosome20.txt";  // data file to read
BufferedReader reader;
PImage level;
float zoom;
int playerX, playerY;
int playerSize;
PFont headlineFont, detailFont;


void setup() {

  size(1500, 900);
  frame.setTitle("Chromosome #20: Reverb");
  noSmooth();

  // load/create level image
  File levelFile = new File(sketchPath("") + "Levels/Level_" + maxDepth + "depth.tiff");
  if (loadFromDiskIfAvailable && levelFile.exists()) {
    println("Loading level from disk...");
    level = loadImage(levelFile.getAbsolutePath());
  } 
  else {
    println("Creating level (" + levelWidth + " x " + levelHeight + " px)");
    createLevelImage();
    if (saveImage) level.save("Levels/Level_" + maxDepth + "depth.tiff");
  }

  // zoom settings and player position
  zoom = playerSize = max(width, height)/(visionDistance*2 + 1);
  playerX = level.width/2;
  playerY = level.height/2;
  
  // laod fonts
  headlineFont = loadFont("OstrichSans-Black-144.vlw");
  detailFont = loadFont("OstrichSans-Black-36.vlw");
}


void draw() {

  if (startScreen) {
    smooth();
    displayStartScreen();
  }
  
  else {
    // draw level
    background(bgColor);
    translate(width/2-playerSize/2, height/2-playerSize/2);
    noSmooth();
    image(level, -playerX*zoom, -playerY*zoom, level.width*zoom, level.height*zoom);
    
    // dim
    for (float y=-playerSize*zoom; y<playerSize*zoom; y+=playerSize) {
      for (float x=-playerSize*zoom; x<playerSize*zoom; x+=playerSize) {
        float distFromPlayer = abs(dist(0,0, x,y));
        float dim = map(distFromPlayer, 0,dimDistance*zoom, 0,255);
        dim = constrain(dim, 0,255);
        fill(bgColor, dim);
        rect(x,y, playerSize, playerSize);
      }
    }
  
    // player
    fill(playerColor);
    noStroke();
    rect(0,0, playerSize, playerSize);
  }
}
