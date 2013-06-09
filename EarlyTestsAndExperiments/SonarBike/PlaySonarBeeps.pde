void playSonarBeeps() {
  /*
  int interval = 100;
  
  long start = millis();
  long end = 0;
  
  do {
    end = millis();
  }
  while (start + interval >= end);
  
  sine.setAmp(0);
  playing = false;
  */
  
  if (millis() > prevNoteTime + noteDuration) {

    if (level[level.length-2][whichNote] == 1) {    // -2 since we want to read the line above the last line
      sine.setFreq(obstaclePitch);
      sine.setAmp(1);
    }
    else {
      sine.setFreq(nothingPitch);
      sine.setAmp(0.1);
    }
    float pan = map(whichNote, 0, levelWidth, -1, 1);
    sine.setPan(pan);

    if (whichNote == levelWidth-1) {
      sine.setAmp(0);    // turn off
      playing = false;
    }
    else {
      whichNote += 1;
    }

    prevNoteTime = millis();
  }
}

