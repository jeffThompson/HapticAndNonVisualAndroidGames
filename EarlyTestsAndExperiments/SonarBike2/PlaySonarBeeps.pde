
void playSonarBeeps() {

  if (millis() > prevNoteTime + noteDuration) {
    
    /*
    float freq = map(beeps[whichNote], 0,255, nothingPitch,obstaclePitch);
    sine.setFreq(freq);
    sine.setAmp(1);
    
    float pan = map(whichNote, 0, beeps.length-1, -1, 1);
    sine.setPan(pan);

    if (whichNote == beeps.length-1) {
      sine.setAmp(0);    // turn off
      playing = false;
    }
    else {
      whichNote += 1;
    }
    */

    prevNoteTime = millis();
  }
}

