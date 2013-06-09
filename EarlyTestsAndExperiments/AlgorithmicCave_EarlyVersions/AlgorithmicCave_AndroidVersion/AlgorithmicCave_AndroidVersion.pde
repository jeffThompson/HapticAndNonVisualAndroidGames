
import android.view.MotionEvent;                      // required import for fancy touch access

import android.media.*;                               // imports required for audio playback
import android.content.res.*;
import android.media.AudioTrack;
import android.media.audiofx.EnvironmentalReverb;

import android.view.inputmethod.InputMethodManager;   // for keyboard
import android.content.Context;

/*
ALGORITHMIC CAVE - FORWARD-FACING VERSION
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Ideas and To Do:
 + spoken text as you wander
 
 Required permission:
 MODIFY_AUDIO_SETTINGS
 
 
 */

// basic setup variables
int w = 200;                           // level dimensions in px
int h = 100;
int multiplier = max(w/200, h/100);    // multiplier for various level sizes (based on a default of 200x100)
char direction = 'n';                  // which way is the player looking (n, e, s, w) 

// terrain variables
int maxInsetMove = 4;                  // amount the beach can move inward per step (up to edgeThresh) - 1 = very little inset, 4 = lots
int edgeThresh = min(w/2, h/2);        // furthest beach can erode in (here 1/2 the shortest window dimension)
int numInnerStones =140*multiplier;    // # of times building inner stone areas
int maxStoneSteps = 100;               // max # of steps for each stone generation (1-max)

// colors for each tile
color airTile = color(175,177,185);
color stoneTile = color(32,33,40);

// reverb effect settings
int decayTime = 200000;             // 10 to 20k
short density = 1000;               // 0 to 1k
short diffusion = 0;                // 0 to 1k
short roomLevel = 0;                // -9k to 0
short reverbLevel = 2000;           // -9k to 2k
short reflectionsDelay = 0;         // 0 to 300
short reflectionsLevel = 1000;      // -9k to 1k
short reverbDelay = 0;              // 0 to 100

// display variables
boolean displayMap = true;          // toggled with 'm' key
boolean displayDirection = true;    // toggled with 'd' key

// sound effects
MediaPlayer footsteps;
EnvironmentalReverb reverb;

// other variables
int[][] level = new int[h][w];
int playerX = int(random(0, w));    // start in random spot
int playerY = int(random(0, h));
int playerSize;
final int AIR = 0;      // tile codes
final int STONE = 1;
PImage levelImage, heightmapImage;
PFont font;


void setup() {
  orientation(LANDSCAPE);
  playerSize = min(width/w, height/h) * 4;

  // fonts
  font = createFont("SansSerif", height/40);
  textFont(font, height/30);
  textAlign(CENTER, CENTER);

  // build level, save if specified
  createLevel(w, h, maxInsetMove, edgeThresh);
  levelImage = createLevelImage();

  // place player (not in the ocean or on isolated rafts of sand)
  while (level[playerY][playerX] == STONE 
    || level[playerY-1][playerX] == STONE 
    && level[playerY][playerX+1] == STONE
    && level[playerY+1][playerX] == STONE
    && level[playerY][playerX-1] == STONE) {
    playerX = int(random(0, w));
    playerY = int(random(0, h));
  }

  // load sound effects for playback
  try {
    footsteps = new MediaPlayer();
    AssetManager assets = this.getAssets();
    AssetFileDescriptor fd = assets.openFd("footsteps.wav");
    footsteps.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    
    // add reverb settings
    reverb = new EnvironmentalReverb(0, 0);
    reverb.setDecayTime(decayTime);
    reverb.setDensity(density);
    reverb.setDiffusion(diffusion);
    reverb.setReverbLevel(reverbLevel);
    reverb.setRoomLevel(roomLevel);
    reverb.setReflectionsDelay(reflectionsDelay);
    reverb.setReflectionsLevel(reflectionsLevel);
    reverb.setReverbDelay(reverbDelay);
    reverb.setEnabled(true);
    
    footsteps.attachAuxEffect(reverb.getId());
    footsteps.prepare();
  }
  catch (IOException ioe) {
    println("Error (probably could not find or load the audio file - is it in the sketch's data folder?)");
  }
}

void draw() { 

  background(0);
  drawLevel(height/4, 400, 250);    // arguments: top edge of current tile, inset x, inset y  

  // if on, show map and player location
  if (displayMap) {
    drawMapAndPlayer(true);    // true = fullscreen map, false = 200x100px map
  }

  // show direction
  if (displayDirection) {
    drawDirection();
  }
}
