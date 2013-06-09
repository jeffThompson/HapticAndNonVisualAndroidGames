
import java.util.Collections;
import java.util.Comparator;
import java.util.Arrays;

/*
FINGER WALK
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 + Like an Ent walker!
 + Diff trees; images overlapping
 + Rabbits run by!
 + Diff elevation means slower move per finger stroke
 
 + two fingers rotate around one = world rotate, walk in that dir
 
 */

int numTrees = 800;
int numBlades = 1000;
float chanceForElevationChange = 0.2;    // chance that the elevation will change

float elevation = 1.0;
ArrayList<Tree> trees = new ArrayList<Tree>();
ArrayList<Grass> grass = new ArrayList<Grass>();
Rabbit rabbit;
PImage grassTexture;

void setup() {
  orientation(PORTRAIT);
  println(width + ", " + height);
  smooth();
  
  grassTexture = loadImage("grass.png");
  for (int i=0; i<numBlades; i++) {
    grass.add(new Grass("on"));
  }

  rabbit = new Rabbit();    // no args, all random

  for (int i=0; i<numTrees; i++) {
    trees.add(new Tree("on"));    // create onscreen
  }
}

void draw() {
  background(50, 160, 0);
  // image(grassTexture, 0,0, width,height);
  
  for (Grass g : grass) {
    g.update();
    g.display();
  }
  

  if (rabbit.running == false && random(1) < 0.5) {
    rabbit.respawn();
  }
  else {
    rabbit.update();
    rabbit.display();
  }

  for (Tree t : trees) {
    t.update();
    t.display();
  }
}

void mouseDragged() {

  if (random(1) < chanceForElevationChange) {
    elevation += random(-0.5, 0.5);
    if (elevation < 0.1) {
      elevation = 0.1;
    }
    if (elevation > 3) {
      elevation = 3;
    }
  }

  float xDiff = (mouseX-pmouseX) * elevation;
  float yDiff = (mouseY-pmouseY) * elevation;

  for (int i=grass.size()-1; i >= 0; i--) {
    Grass g = grass.get(i);
    g.x += xDiff;
    g.y += yDiff;
    if (g.isDead() == true) {
      grass.remove(g);
      grass.add(new Grass("off"));
    }
  }

  rabbit.x += xDiff;
  rabbit.y += yDiff;

  for (int i = trees.size()-1; i >= 0; i--) {
    Tree t = trees.get(i);
    t.x += xDiff;
    t.y += yDiff;
    if (t.isDead() == true) {
      trees.remove(t);
      trees.add(new Tree("off"));
    }
  }

  // sort by distance from center - makes drawing more realistic (ie: not
  // overlapping in weird ways)
  Collections.sort(trees, new Comparator<Tree>() {
    public int compare(Tree t1, Tree t2) {
      return (int)t1.getDistFromCenter() - t2.getDistFromCenter();
    }
  }
  );  
  Collections.reverse(trees);
}

