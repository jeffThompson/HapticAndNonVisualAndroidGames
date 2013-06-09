
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
ALGORITHMIC CAVE
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 TO DO:
 + better dripping (multiple sounds incl drip on bare stone, small puddle, large puddle)
 + lakes and water feet
 + list of test and cheat keys
 
 Required permissions:
 MODIFY_AUDIO_SETTINGS
 VIBRATE
 
 */

// map generation variables
final int w = 100;            // map size (# of tiles) wide
final int h = 50;             // ditto high
final int numSteps = 10000;   // # of iterations for map generation
final float noiseInc = 0.3;   // increment for Perlin noise >> heightmap
int visionDist = 5;           // # of tiles player can see in any direction

// display flags
boolean titleScreen = true;
boolean displayMap = false;
boolean displaySmallMap = false;
boolean displayDirection = true;
boolean saveIt = false;

// vibration settings
long wallVibration = 100;                        // hit wall
long[] footstepVibration = { 
  100, 30, 178, 20
};  // first value if off (tuned for delay in audio clip starting)

// reverb effect settings
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

// drip variables
float maxDripVol = 0.4;
float chanceOfDrip = 0.7;    // 1.0 = always, 0 = never

// other variables
int[][] level;               // 2d array for level
PImage levelImage;           // image of map
int playerX = w/2;           // start player in center
int playerY = h/2;
char direction = 'n';        // which way is the player looking (n, e, s, w)
PFont directionFont, titleFont;                     // font for direction
int tileSizeX, tileSizeY, gridSize, mapGridSize;    // tile dimensions

// sound effects and vibration objects
MediaPlayer footsteps;
MediaPlayer drip;
EnvironmentalReverb reverb;
Vibrator vibe;


void setup() {

  // basic setup stuff
  orientation(LANDSCAPE);

  // create level
  gridSize = min(width/(visionDist*2), height/(visionDist*2));
  mapGridSize = min(width/w, height/h);
  tileSizeX = width/w;
  tileSizeY = height/h;
  createLevel();
  createLevelImage();  

  // fonts
  directionFont = createFont("SansSerif", height/40);
  titleFont = createFont("SansSerif", height/2.5);
  textAlign(CENTER, CENTER);

  // load sound effects for playback
  loadSounds();

  // initialize vibration
  vibe = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
}

void draw() {

  // title screen
  if (titleScreen) {
    drawTitleScreen();
  }

  // regular gameplay 
  else {
    
    // show large map
    if (displayMap) {
      drawMapAndPlayer();
    }
    
    // or, draw level
    else {
      drawLevel();
      if (displaySmallMap) {
        drawSmallMap();
      }
    }
    
    // randomly drip
    if (random(1) > chanceOfDrip && !drip.isPlaying()) {
      playDrip();
    }

    // show direction
    if (displayDirection) {
      drawDirection();
    }
  }
}
