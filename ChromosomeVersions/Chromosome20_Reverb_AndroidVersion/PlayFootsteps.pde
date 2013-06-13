
void playFootsteps() {
  
    // change amount of reverb based on tile
    float c = level.pixels[playerY * level.width + playerX] >> 16 & 0xFF; 
    decayTime = int(map(c, 0, 255, minReverb, maxReverb));
    reverb.setDecayTime(decayTime);
    
    // play sound and vibration pattern
    if (beep.isPlaying()) {
      beep.seekTo(0);
    }
    else {
      beep.start();
    }
    //vibe.vibrate(footstepVibration, -1);
}
