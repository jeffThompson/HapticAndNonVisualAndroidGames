
import android.os.Vibrator;
import android.view.MotionEvent;                      // required import for fancy touch access
import android.view.inputmethod.InputMethodManager;   // for keyboard
import android.content.Context;
import android.hardware.Sensor;                       // required imports for sensor data
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.content.Context;                       // imports required for vibration
import android.os.Vibrator;
import android.media.*;                               // imports required for audio playback
import android.content.res.*;
import android.media.AudioTrack;
import java.util.*;                                   // for sorting ArrayLists

/*
SONAR
Jeff Thompson | 2013 | www.jeffreythompson.org

Created with generous support from Harvestworks' Cultural Innovation Fund program.

TO DO:
+ slowing seems to have to do with hitting repeatedly every frame - try triggering when once hit, then off when not
+ modes (randomly chosen at startup? after a certain # of interactions?):
    where the more you hit the more obs, they go faster but get smaller
    where the more that you don't hit and reach the end means more and faster
    the more you hit the larger they get
    the stiller you are the faster they go
+ sound when you hit the sides (dink!) so you could play totally blind and makes a sense of physical boundary (not just screen)
    hard pan L/R
+ sound when the ball rolls back and forth? gravelly marble sound? pan L/R?
+ figure out intro (title screen? spoken? nothing? sound of engine with doppler effect?)

Required permissions:
+ VIBRATE

*/

int numObstacles = 10;              // at a time
float levelSpeed = 13.0;            // vertical movement

boolean showObjects = true;         // 'o' to toggle
boolean showSonar = true;           // 's' to toggle
boolean showDebug = true;           // 'd' to show debug info (framerate, # obs, etc)

String sonarSweepFilename = "440-400-360.wav";           // sonar sweep sound
String hitSoundFilename = "noise-295sine-330sine.wav";   // sound when hitting an obstacle
String centerClickFilename = "centerClick.wav";          // click at top of sonar sweep (if specified)
String sideSoundFilename = "sideSound.wav";              // sound when hitting side of screen
int hitVibeIntensity = 5;                                // 0 = none, 100 = a lot (really is duration in ms)

Player player;
SonarObj sonar;
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
boolean introScreen = true;        // show intro screen? touch to release and play

SensorManager sensorManager;       // keep track of sensor
SensorListener sensorListener;     // special class for noting sensor changes
Sensor accelerometer;              // Sensor object for accelerometer
float[] accelData;                 // x,y,z sensor data

Vibrator vibe;                                             // vibration motor
MediaPlayer sonarSweep, centerClick, hitSound, sideSound;  // sound files

PFont headlineFont, detailsFont;    // fonts


void setup() {

  orientation(LANDSCAPE);
  frameRate(24);

  // create player, sonar, and obstacles
  player = new Player(width/2);            // starting x position (y set in class - just above bottom)
  sonar = new SonarObj();
  for (int i=0; i<numObstacles; i++) {
    obstacles.add(new Obstacle(random(0, width), random(-height, 0)));
  }

  // initialize vibration and sounds
  vibe = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
  loadSounds();
  
  // fonts
  headlineFont = createFont("Sans-Serif", height/6);
  detailsFont = createFont("Sans-Serif", height/24);
  textAlign(CENTER, BASELINE);
}

void draw() {
  if (introScreen) displayIntro();
  else playLevel();
}

// when leaving the app...
void onPause() {
  sensorManager.unregisterListener(sensorListener);    // turn off sensor listener
  sonarSweep.pause();                                  // stop sound files
  hitSound.pause(); 
  super.onPause();                                     // pass along to main function
}

