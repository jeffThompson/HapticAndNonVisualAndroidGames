import ddf.minim.*;
import ddf.minim.signals.*;    // for synthesis
import java.util.Arrays;

/*
SONAR BIKE
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Walk before you can run, run before you can bike!
 
 Based on Daniel Kish, who can do this for real:
 http://www.youtube.com/watch?v=vpxEmD0gu0Q
 
 Crash sound via:
 http://www.sounddogs.com/results.asp?CategoryID=1015&SubcategoryID=31&Type=1
 
 */

float sonarThresh = 0.;
int visionDist = 6;            // how many grid units can you see?
float chanceObstacle = 0.1;    // chance of obstacle being generated in a spot


int levelWidth = 10;
int levelHeight = 10;
int gridSize = 50;
int outsidePadding = 50;
int spacing = 10;

int noteDuration = 100;      // in ms
int nothingPitch = 220;
int obstaclePitch = 440;

Minim minim;
AudioInput audioIn;
AudioOutput audioOut;
SineWave sine;
AudioSnippet crash;
int playerX;
int[][] level = new int[levelHeight][levelWidth];
Obstacle[][] obstacles = new Obstacle[0][0];
boolean playing = true;
long prevNoteTime = 0;
int whichNote = 0;
int toggleDist = visionDist;
int timesHit = 0;

void setup() {
  minim = new Minim(this);
  audioIn = minim.getLineIn(Minim.STEREO, 512);
  audioOut = minim.getLineOut(Minim.STEREO);
  sine = new SineWave(330, 0.5, audioOut.sampleRate());
  audioOut.addSignal(sine);
  crash = minim.loadSnippet("crash.mp3");

  size((gridSize+spacing)*(levelWidth) + outsidePadding*2, outsidePadding*2 + (gridSize+spacing)*(levelHeight));
  noStroke();
  rectMode(CENTER);

  for (int y=0; y<level.length; y++) { 
    for (int x=0; x<level[0].length; x++) {
      if (random(1) < chanceObstacle) {
        level[y][x] = 1;
        obstacles = (Obstacle[]) append(obstacles, new Obstacle(x,y));
      }
      else {
        level[y][x] = 0;
      }
    }
  }
  Arrays.sort(obstacles);    // sort by angle clockwise from L
  
  playerX = level[0].length / 2;
}

void draw() {

  if (crash.isPlaying()) {
    background(255,0,0);
  }
  else {
    background(0);
  }

  float averageSample = 0.0;
  for (int i=0; i<audioIn.bufferSize(); i++) {
    averageSample += abs(audioIn.left.get(i));
  }
  averageSample /= audioIn.bufferSize();

  for (int y=0; y<level.length; y++) { 
    for (int x=0; x<level[0].length; x++) {
      if (level[y][x] == 1) {
        float dist = dist(playerX, level.length-1, x, y);
        fill(map(dist, 0, visionDist, 255, 0), map(dist, 0, visionDist, 150, 0), 0);
        ellipse(outsidePadding + x*(gridSize+spacing), outsidePadding + y*(gridSize+spacing), gridSize, gridSize);
      }
    }
  }

  // player
  fill(255);
  rect(outsidePadding + playerX*(gridSize+spacing), outsidePadding + (level.length-1)*(gridSize+spacing), gridSize, gridSize);

  // score
  fill(255, 0, 0);
  text("CRASHES: " + timesHit, outsidePadding, height-outsidePadding/2);

  // click and feedback
  if (averageSample > sonarThresh && !playing) {
    println("  bleep");
    playing = true;
    sine.setAmp(1);
    whichNote = 0;
  }
  if (playing) {
    playSonarBeeps();
  }
}

void keyPressed() {
  if (key == 32) {
    if (visionDist == 0) {
      visionDist = toggleDist;
    }
    else {
      visionDist = 0;
    }
  }
  
  if (key == CODED) {
    if (keyCode == LEFT) {
      if (playerX-1 >= 0 && level[level.length-1][playerX-1] != 1) {
        playerX -= 1;
      }
    }
    else if (keyCode == RIGHT) {
      if (playerX+1 <= level[0].length-1 && level[level.length-1][playerX+1] != 1) {
        playerX += 1;
      }
    }

    // update level
    if (keyCode == UP) {
      for (int y=level.length-1; y>0; y--) {      // move down array
        for (int x=0; x<level[0].length; x++) {
          level[y][x] = level[y-1][x];
        }
      }
      for (int x=0; x<level[0].length; x++) {    // build new line
        if (random(1) < chanceObstacle) {
          level[0][x] = 1;
        }
        else {
          level[0][x] = 0;
        }
      }
      

      // did we hit something
      if (level[level.length-1][playerX] == 1) {
        println("CRASH!");
        level[level.length-1][playerX] = 0;   // remove obstacle (no overlap with player)
        crash.play(0);                        // 0 = play from beginning each time (same as also calling rewind())
        timesHit++;
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

