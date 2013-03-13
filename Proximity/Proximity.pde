
import android.content.Context;    // both imports required for vibration
import android.os.Vibrator;

/*
Required permissions:
 VIBRATION
 */

int targetDia = 50;
int thresh = 10;

float tx, ty;
Vibrator vibe;


void setup() {
  smooth();
  noStroke();
  vibe = (Vibrator)getSystemService(Context.VIBRATOR_SERVICE);

  tx = random(targetDia, width-targetDia);
  ty = random(targetDia, height-targetDia);
}

void draw() {
  background(75, 25, 0);

  fill(255, 150, 0);
  ellipse(tx, ty, targetDia, targetDia);

  fill(255);
  ellipse(mouseX, mouseY, 60, 60);
}

void mouseDragged() {
  vibe.cancel();
  
  int mouseDist = int(dist(mouseX, mouseY, tx, ty));
  long dur = int(map(mouseDist, 0, width*height, 100, 1000));
  println(dist + " = " + dur);
  long[] vibeList = { 
    0, dur, dur
  };
  vibe.vibrate(vibeList, -1);
}

