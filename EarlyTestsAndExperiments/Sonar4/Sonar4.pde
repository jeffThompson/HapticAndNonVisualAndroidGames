
import android.os.Vibrator;
import android.view.MotionEvent;                      // required import for fancy touch access
import android.view.inputmethod.InputMethodManager;   // for keyboard
import android.content.Context;
import android.hardware.Sensor;               // required imports for sensor data
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.content.Context;                       // imports required for vibration
import android.os.Vibrator;
import android.media.*;                               // imports required for audio playback
import android.content.res.*;
import android.media.AudioTrack;
import java.util.*;            // for sorting ArrayLists

/*
SONAR
Jeff Thompson | 2013 | www.jeffreythompson.org

Required permissions:
+ VIBRATE
*/

int numObstacles = 5;      // at a time
boolean showObjects = false;
boolean showSonar = true;
float levelSpeed = 10.0;
String sonarPitchFilename = "lowPitch.wav";

Player player;
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
Sonar sonar;
SensorManager sensorManager;       // keep track of sensor
SensorListener sensorListener;     // special class for noting sensor changes
Sensor accelerometer;              // Sensor object for accelerometer
float[] accelData;                 // x,y,z sensor data
Vibrator vibe;
MediaPlayer pitch;
PFont headlineFont, detailsFont;
int arrowPos;
float arrowTrans;

void setup() {

  orientation(LANDSCAPE);

  // create player, sonar, and obstacles
  player = new Player(width/2, height-80);
  sonar = new Sonar();
  for (int i=0; i<numObstacles; i++) {
    obstacles.add(new Obstacle(random(0, width), random(-height, 0)));
  }

  // initialize vibration
  vibe = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);

  // sounds
  try {
    pitch = new MediaPlayer();
    AssetManager assets = this.getAssets();
    AssetFileDescriptor fd = assets.openFd(sonarPitchFilename);
    pitch.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    pitch.prepare();
  }
  catch (IOException ioe) {
    println("Error (probably could not find or load the audio file - is it in the sketch's data folder?)");
    println(ioe);
  }
  
  // fonts
  headlineFont = createFont("Sans-Serif", height/6);
  detailsFont = createFont("Sans-Serif", height/24);
  textAlign(CENTER, BASELINE);
  arrowPos = -20;
  arrowTrans = 255.0;
}

void draw() {
  playLevel();
}

