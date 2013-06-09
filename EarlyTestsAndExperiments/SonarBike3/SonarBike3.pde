
import ddf.minim.*;            // general audio
import ddf.minim.signals.*;    // for synthesis
import java.util.*;            // for sorting ArrayLists


String level = "start";
int numObstacles = 5;      // at a time
int numLives = 2;

Player player;
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
Sonar sonar;
Minim minim;
AudioInput audioIn;
AudioOutput audioOut;
SineWave sine;
AudioSnippet centerClick;
AudioSnippet crash;
boolean blind = false;
PFont titleFont, detailsFont;
int obstaclesPassed = 0;
int remainingObstacles = 0;
float levelSpeed = 0;


void setup() {

  size(800, 800);
  titleFont = loadFont("OstrichSans-Light-72.vlw");
  detailsFont = loadFont("Times-Roman-20.vlw");
  textAlign(CENTER, CENTER);

  // start audio objects
  minim = new Minim(this);
  audioIn = minim.getLineIn(Minim.STEREO, 512);
  audioOut = minim.getLineOut(Minim.STEREO);
  sine = new SineWave(0, 0.0, audioOut.sampleRate());
  centerClick = minim.loadSnippet("click.wav");
  crash = minim.loadSnippet("crash.wav");
  audioOut.addSignal(sine);

  // create player, sonar, and obstacles
  player = new Player(width/2, height-30);
  sonar = new Sonar();
  for (int i=0; i<numObstacles; i++) {
    obstacles.add(new Obstacle(random(0, width), random(-height, 0)));
  }
}

void draw() {

  // start screen
  if (level.equals("start")) {
    startScreen();
  }
  
  // instruction screens
  else if (level.equals("instruction_walk")) {
    instruction_walk();
  }
  else if (level.equals("instruction_run")) {
    instruction_run();
  }
  else if (level.equals("instruction_bike")) {
    instruction_bike();
  }
  else if (level.equals("instruction_motorcycle")) {
    instruction_motorcycle();
  }
  
  // win screen
  else if (level.equals("win")) {
    winScreen();
  }
  // death screen
  else if (level.equals("dead")) {
    deadScreen();
  }

  // all other levels
  else {
    playLevel();
  }
}

// stop all audio processes when done
void stop() {
  audioIn.close();
  audioOut.close();
  // crash.close();
  minim.stop();
  super.stop();
}
