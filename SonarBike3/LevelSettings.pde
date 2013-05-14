
void checkLevel() {
  switch (obstaclesPassed) {
  case 0:  
    level = "instruction_walk"; 
    walkSettings(); 
    break;
  case 10:  
    level = "instruction_run"; 
    runSettings(); 
    break;
  case 20: 
    level = "instruction_bike"; 
    bikeSettings(); 
    break;
  case 50: 
    level = "instruction_motorcycle"; 
    motorcycleSettings(); 
    break;
  case 100: 
    level = "win!";
  }

  /*obstacles.clear();
  for (int i=0; i<numObstacles; i++) {
    obstacles.add(new Obstacle(random(0, width), random(-height, 0)));
  }*/
}

void walkSettings() {
  numObstacles = 10;
  levelSpeed = 0.0;
  remainingObstacles = 10;
}

void runSettings() {
  numObstacles = 20;
  levelSpeed = 1.0;
  remainingObstacles = 10;
}

void bikeSettings() {
  numObstacles = 10;
  levelSpeed = 3.0;
  remainingObstacles = 30;
}

void motorcycleSettings() {
  numObstacles = 20;
  levelSpeed = 5.0;
  remainingObstacles = 50;
}

