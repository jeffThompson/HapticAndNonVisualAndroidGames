
import android.view.MotionEvent;                      // required import for fancy touch access

import android.media.*;                               // imports required for audio playback
import android.content.res.*;
import android.media.AudioTrack;
import android.media.audiofx.EnvironmentalReverb;

import android.view.inputmethod.InputMethodManager;   // for keyboard
import android.content.Context;

/*
ALGORITHMIC ISLAND - FORWARD-FACING VERSION
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Ideas and To Do:
 + change sunrise/set to use color variables for easier tweaking
 + fancy darkening based on month of year
 + diagonal beach option?
 + Run forest fire simulation to set terrain
 + sounds for each terrain?
 + diff terrains diff heights (forest is tall so you can't see in front of you, mountains, etc)
 + spoken text as you wander
 
 */

// basic setup variables
int w = 200;                           // level dimensions in px
int h = 100;
int multiplier = max(w/200, h/100);    // multiplier for various level sizes (based on a default of 200x100)
char direction = 'n';                  // which way is the player looking (n, e, s, w) 

// terrain variables
int maxInsetMove = 4;                  // amount the beach can move inward per step (up to edgeThresh) - 1 = very little inset, 4 = lots
int edgeThresh = min(w/2, h/2);        // furthest beach can erode in (here 1/2 the shortest window dimension)
int numRanges = 80 * multiplier;
int numRocks = 120 * multiplier;
int numFields = 10 * multiplier;
int numForests = 80 * multiplier;
int numPonds = 20 * multiplier;

// colors for each tile
color seaTile = color(75, 93, 147);    // or 48,56,80
color grassTile = color(75, 95, 40);
color beachTile = color(245, 210, 125);
color forestTile = color(7, 72, 10);
color mountainTile = color(95, 100, 105);
color rockTile = color(180);

// reverb effect settings
int decayTime = 200000;            // 10 to 20k
short density = 1000;              // 0 to 1k
short diffusion = 0;               // 0 to 1k
short roomLevel = 0;               // -9k to 0
short reverbLevel = 2000;          // -9k to 2k
short reflectionsDelay = 0;        // 0 to 300
short reflectionsLevel = 1000;     // -9k to 1k
short reverbDelay = 0;             // 0 to 100

// day/night
boolean displayNight = false;
int sunrise = 7;      // 7 am
int sunset = 12+8;    // 8 pm
int maxDim = 200;            // max amount to dim at night (255 = total blackness)
color day = color(134, 153, 255);
color riseSet = color(188, 153, 27);
color night = color(6, 15, 64);
String month = "January";    // for fancier changes over year

// display variables
int neighborTransparency = 30;       // dim the upcoming tile? (0 = no dimming, 255 = black)
boolean displayMap = false;          // toggled with 'm' key
boolean displayDirection = true;     // toggled with 'd' key

// sound effects
MediaPlayer footsteps;
EnvironmentalReverb reverb;

// other variables
int[][] level = new int[h][w];
int[][] heightmap = new int[h][w];
int playerX = int(random(0, w));    // start in random spot
int playerY = int(random(0, h));
int playerSize;
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
  orientation(LANDSCAPE);
  playerSize = min(width/w, height/h) * 4;

  // fonts
  font = createFont("SansSerif", height/40);
  textFont(font, height/30);
  textAlign(CENTER, CENTER);

  // build level, save if specified
  createLevel(w, h, maxInsetMove, edgeThresh, multiplier);
  levelImage = createLevelImage();

  // place player (not in the ocean or on isolated rafts of sand)
  while (level[playerY][playerX] == SEA 
    || level[playerY-1][playerX] == SEA 
    && level[playerY][playerX+1] == SEA
    && level[playerY+1][playerX] == SEA
    && level[playerY][playerX-1] == SEA) {
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

  drawSky();
  drawLevel(height/4, 400, 250);    // arguments: top edge of current tile, inset x, inset y  

  // if on, darken based on current time of day
  if (displayNight) {
    if (hour() < sunrise || hour() > sunset) {
      fill(0, maxDim);
    }
    else if (hour() == sunrise) {
      fill(0, map(minute(), 0, 59, maxDim, 0));
    }
    else if (hour() > sunrise && hour() < sunset) {
      fill(0, 0);
    }
    else if (hour() == sunset) {
      fill(0, map(minute(), 0, 59, 0, maxDim));
    }
    noStroke();
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
