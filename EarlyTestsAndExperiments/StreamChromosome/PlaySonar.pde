
void playSonar() {
  println("Next tile: " + nextDirection);

  if (nextDirection == UP) {
    highSonar.seekTo(0);
    delay(500);
    highSonar.stop();
  }
  else {
    lowSonar.seekTo(0);
    delay(500);
    lowSonar.stop();
  }

  if (nextDirection == RIGHT) {
    highSonar.seekTo(0);
    delay(500);
    highSonar.stop();
  }
  else {
    lowSonar.seekTo(0);
    delay(500);
    lowSonar.stop();
  }

  if (nextDirection == DOWN) {
    highSonar.seekTo(0);
    delay(500);
    highSonar.stop();
  }
  else {
    lowSonar.seekTo(0);
    delay(500);
    lowSonar.stop();
  }

  if (nextDirection == LEFT) {
    highSonar.seekTo(0);
    delay(500);
    highSonar.stop();
  }
  else {
    lowSonar.seekTo(0);
    delay(500);
    lowSonar.stop();
  }
}

