
void collision(float ox) {    // pass obstacle x position for panning

  // vibration for N ms
  vibe.vibrate(hitVibeIntensity);

  // pan depending on side that is hit (softly with a little in the other channel)
  if (ox < player.x) hitSound.setVolume(0.8, 0.3);
  else hitSound.setVolume(0.3, 0.8);
  hitSound.seekTo(0);
}

