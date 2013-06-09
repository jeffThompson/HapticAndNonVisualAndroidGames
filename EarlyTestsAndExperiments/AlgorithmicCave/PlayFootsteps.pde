
// test wav file from:
// http://www.soundjay.com/footsteps-1.html

// gravel.mp3 (edited to gravel-2step.wav)
// http://www.freesfx.co.uk/soundeffects/footsteps

// grittyConcrete.mp3
// http://www.freesfx.co.uk/soundeffects/footsteps/?p=6

void playFootstep() {
    
    // change amount of reverb based on tile
    decayTime = int(map(level[playerY][playerX], 0, 255, minReverb, maxReverb));
    reverb.setDecayTime(decayTime);
    
    // play sound and vibration pattern
    if (footsteps.isPlaying()) {
      footsteps.seekTo(0);
    }
    else {
      footsteps.start();
    }
    vibe.vibrate(footstepVibration, -1);
}
