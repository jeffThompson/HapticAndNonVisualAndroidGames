
import ddf.minim.*;
import ddf.minim.signals.*;    // for synthesis
import java.util.*;

/*
SONAR BIKE 2
 or
 WALK, RUN, BIKE (SONAR EDITION)
 
 */

String level = "walk";    // walk, run, bike

float sonarThresh = 0.2;
int noteDuration = 10;      // in ms
int nothingPitch = 220;
int obstaclePitch = 440;

int numObstacles = 5;
float visionDist = 500;
float speed = 4;
float playerSpeed = 20;
int playerSize = 30;
boolean blind = false;
float angleOffset = PI;

int playerX, playerY;
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
int collisionCount = 0;

Minim minim;
AudioInput audioIn;
AudioOutput audioOut;
SineWave sine;
AudioSnippet crash;
float[] beeps;
boolean playing = false;
long prevNoteTime = 0;
int whichNote = 0;

void setup() {

  size(800, 800);
  playerX = width/2;
  playerY = height;
  if (level.equals("walk")) {
    speed = 20;
  }
  else if (level.equals("run")) {
    speed = 40;
  }
  else if (level.equals("bike")) {
    speed = 4;
  }

  for (int i=0; i<numObstacles; i++) {
    obstacles.add(new Obstacle(random(0, width), random(0, height), speed));
    Obstacle o = obstacles.get(i);
    o.updateSonar();
  }

  minim = new Minim(this);
  audioIn = minim.getLineIn(Minim.STEREO, 512);
  audioOut = minim.getLineOut(Minim.STEREO);
  sine = new SineWave(330, 0.0, audioOut.sampleRate());
  audioOut.addSignal(sine);
  crash = minim.loadSnippet("crash.mp3");
}

void draw() {

  if (crash.isPlaying()) {
    background(255, 0, 0);
  }
  else {
    background(0);
  }

  // sonar
  float averageSample = 0.0;
  for (int i=0; i<audioIn.bufferSize(); i++) {
    averageSample += abs(audioIn.left.get(i));
  }
  averageSample /= audioIn.bufferSize();

  // click and feedback
  if (averageSample > sonarThresh && !playing) {
    println("  bleep");
    playing = true;
    whichNote = 0;
  }
  if (playing) {
    playSonarBeeps();
  }

  runSonarScan();

  // draw player
  noStroke();
  fill(255);
  ellipse(playerX, playerY, 30, 30);

  // draw obstacles
  updateOrder();
  for (int i=obstacles.size()-1; i>=0; i-=1) {
    Obstacle o = obstacles.get(i);
    if (level.equals("bike")) {
      o.updateY();
      o.updateSonar();
    }
    o.testCollision();
    if (!blind) {
      o.display(i);
    }
  }

  // any obstacles offscreen? if so, remove and respawn
  for (int i=obstacles.size()-1; i>=0; i-=1) {
    Obstacle o = obstacles.get(i);
    if (o.y > height+o.diameter) {
      obstacles.remove(i);
      obstacles.add(new Obstacle(random(0, width), random(-height, 0), speed));
    }
  }

  // score
  fill(255, 0, 0);
  textAlign(LEFT, CENTER);
  text("COLLISIONS: " + collisionCount, 30, 30);
}

void keyPressed() {

  // toggle blindness!
  if (key == 32) {
    blind = !blind;
  }

  // move with the arrow keys L/R
  if (key == CODED) {
    if (keyCode == RIGHT) {
      playerX += playerSpeed;
      if (playerX+playerSize/2 > width) {
        playerX = width-playerSize/2;
      }
      if (level.equals("walk") || level.equals("run")) {
        for (Obstacle o : obstacles) {
          o.updateSonar();
        }
      }
    }
    else if (keyCode == LEFT) {
      playerX -= playerSpeed;
      if (playerX-playerSize/2 < 0) {
        playerX = playerSize/2;
      }
      if (level.equals("walk") || level.equals("run")) {
        for (Obstacle o : obstacles) {
          o.updateSonar();
        }
      }
    }

    else if (keyCode == UP) {
      if (level.equals("walk") || level.equals("run")) {
        for (Obstacle o : obstacles) {
          o.updateY();
          o.updateSonar();
        }
      }
    }
  }
}

void stop() {
  audioIn.close();
  audioOut.close();
  crash.close();
  minim.stop();
  super.stop();
}

