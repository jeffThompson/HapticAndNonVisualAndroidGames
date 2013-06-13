
import android.view.inputmethod.InputMethodManager;   // for keyboard
import android.content.Context;
import android.media.*;                               // imports required for audio playback
import android.content.res.*;
import android.media.AudioTrack;
import android.media.audiofx.EnvironmentalReverb;
import android.content.Context;                       // imports required for vibration
import android.os.Vibrator;
import android.view.MotionEvent;                      // required import for fancy touch access

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
String levelFile = "Level_2147483647depth.png";   // level file to load (must be in 'data' folder)
int levelWidth = 500;                            // level width in px
int levelHeight = 500;                           // ditto height

// COLOR VARIABLES
color bgColor = color(0);                  // background color
color playerColor = color(255, 150, 0);
color startColor = color(60, 60, 60);      // initial color for a traversed pixel
int colorInc = 20;                         // increment for previously traversed pixels

// DISPLAY VARIABLES
int visionDistance = 6;                  // radius of tiles shown onscreen
int dimDistance = 3;                     // radius of tiles for dimming to background color

// START SCREEN
boolean startScreen = true;

// REVERB EFFECT SETTINGS
int minReverb = 10;                 // min amount of reverb (smallest space)
int maxReverb = 3000;
int decayTime = 200000;             // 10 to 20k
short density = 1000;               // 0 to 1k
short diffusion = 0;                // 0 to 1k
short roomLevel = 0;                // -9k to 0
short reverbLevel = 2000;           // -9k to 2k
short reflectionsDelay = 0;         // 0 to 300
short reflectionsLevel = 1000;      // -9k to 1k
short reverbDelay = 0;              // 0 to 100

// OTHER VARIABLES
PImage level;
float zoom;
int playerX, playerY;
int playerSize;
PFont headlineFont, detailFont;

// SOUND EFFECT AND VIBRATION OBJECTS
MediaPlayer beep;
EnvironmentalReverb reverb;
Vibrator vibe;


void setup() {
  // basic setup stuff
  orientation(LANDSCAPE);
  noSmooth();

  // load level image
  println("Loading level from disk...");
  level = loadImage(levelFile);
  level.loadPixels();            // load for access to array (throws an error in Android if you don't)

  // zoom settings and player position
  zoom = playerSize = max(width, height)/(visionDistance*2 + 1);
  playerX = level.width/2;
  playerY = level.height/2;

  // load fonts
  println("Loading fonts...");
  headlineFont = createFont("Sans-Serif", height/6);
  detailFont = createFont("Sans-Serif", 32);

  // load sound effects and initialize vibration
  println("Loading sounds...");
  loadSounds();
  vibe = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
}

void draw() {

  // start screen
  if (startScreen) {
    smooth();
    displayStartScreen();
  }

  // draw level
  else {
    background(bgColor);

    // draw neighbroing pixels, player and dim
    drawNeighboringTiles();

    /*for (float y=-playerSize*zoom; y<playerSize*zoom; y+=playerSize) {
     for (float x=-playerSize*zoom; x<playerSize*zoom; x+=playerSize) {
     float distFromPlayer = abs(dist(0, 0, x, y));
     float dim = map(distFromPlayer, 0, dimDistance*zoom, 0, 255);
     dim = constrain(dim, 0, 255);
     fill(bgColor, dim);
     rect(x, y, playerSize, playerSize);
     }
     }*/

    // player
    //fill(playerColor);
    //rect(width/2-playerSize/2, height/2-playerSize/2, playerSize, playerSize);
  }
}

