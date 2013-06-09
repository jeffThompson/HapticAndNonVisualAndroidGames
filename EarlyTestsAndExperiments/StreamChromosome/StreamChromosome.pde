
import android.view.inputmethod.InputMethodManager;   // for keyboard
import android.content.Context;
import android.media.*;                               // imports required for audio playback
import android.content.res.*;
import android.media.AudioTrack;
import android.media.audiofx.EnvironmentalReverb;
import android.content.Context;                       // imports required for vibration
import android.os.Vibrator;
import android.view.MotionEvent;                      // required import for fancy touch access
import android.media.MediaRecorder;                   // for mic input

/*
CHROMOSOME #22: SONAR
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Required permissions:
 + Vibrate
 + Record Audio
 + Modify Audio Settings
 */

String data = "gatccagaggtggaagaggaaggaagcttggaaccctatagagttgctgaGATCCAGAggtggaagaggaaggaagcttggaaccctatagagttgctgagtgccaggaccagatcctggccctaaacaggtggtaaggaaggagagagtgaaggaactgccaggtgacacactcccaccatggacctctgggatcctagctttaagagatcccatcacccacatgaacgtttgaattgacagggggagctgcctggagagtaggcagatgcagagctcaagcctgtgcagagcccaggttttgtgagtgggacagttgcagcaaaacacaaccataggtgcccatccaccaaggcaggctctccatcttgctcagagtggctctagcccttgctgactgctgggcagggagagagcagagctaacttcctcatgggacctgggtgtgtctgatctgtgcacaccactatccaaccgatcccgaggctccaccctggccactcttgtgtgcacacagcacagcctcTACTGCTAcacctgagtactttgccagtggcctggaagcactttgtcccccctggcacaaatggtgctggaccacgaggggccagagaacaaagccttgggcgtggtcccaactcccaaatgtttgaacacacaagttggaatattgggctgagatctgtggccAGGGCCTGAGTAGGGGAGAAGCTCCCACTCTCAGAACACTGAGAAAAGTGAGGCATGGGTTTCTGGGCTGGTACAGGAGCTCGATGTGCTTCTCTCTACAAGACTGGTGAGGGAAAGGTGTAACCTGTTTGTCAGCCACAACATCTTCCTAAGGGAGCCTTGTGTCCGGGAAAAACTGACAGACCAGTGATCTGGGTGCAGAAGGCTTGAGACAAAACTAGCTGGTTGGGCCAGCTATGGGGCAAATGCTGGAAAGAAACCTGGTCAGGGAGCCTGAGCTGAGTGGTCCCCACAGTCATCTGCTTGGCAAGAAACCCTaggtcgcaggtgctagaccagctgcacacccacagcaacactgccatgcccaggatcctctgcccttgatcctgaatcaacagaccacttgcagatatacttcacagcccacgctgactctgccaagcacagacaaccactgggccccaggggagctgcaggtctcctggTCACCTAATCtttttttttttt";
int visionDist = 2;
color bgColor = color(0);
int moveThresh = 20;                              // # px to be considered a swipe for moving (otherwise considered a tap)

long[] footstepVibration = { 30, 10, 100, 10 };   // first value if off (tuned for delay in audio clip starting)
long[] hitVibration = { 0, 40 };

int gridSize;
int pos  = 0;
char next;
PFont font;
MediaPlayer C, F, G, A, hitSound, lowSonar, highSonar;
EnvironmentalReverb reverb;
Vibrator vibe;
boolean startScreen = false;
boolean readMic = true;
int startMouseX, startMouseY;
PolygonButton upButton, rightButton, downButton, leftButton;
CenterButton centerButton;
int nextDirection;    // next in file (u,d,l,r)
int spikeThresh = 2000;


void setup() {

  // basic setup
  orientation(LANDSCAPE);
  gridSize = height/(visionDist+3);
  // noSmooth();
  noStroke();
  rectMode(CENTER);

  // clean up data
  data = data.toLowerCase();

  // create necessary font
  font = createFont("Sans-Serif", gridSize/2);
  textFont(font, gridSize/2);
  textAlign(CENTER, BASELINE);

  // audio setup and load sounds
  loadSounds();
  vibe = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);

  // create button instances
  createButtons();
}

void draw() {

  /*boolean spike = detectAudioSpike();
   if (spike == true) {
   println("SPIKE!");
   }*/

  background(bgColor);
  // drawNextTiles();

  // buttons
  upButton.display();
  rightButton.display();
  downButton.display();
  leftButton.display();

  // player
  centerButton.display();
}

