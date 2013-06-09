
void playDrip() {
  
  // random distance from player
  int dripDist = int(random(0, w));
  
  // map reverb amount to distance (closest = current reverb, further = more than current)
  decayTime = int(map(dripDist, 0, w, decayTime, maxReverb));
  reverb.setDecayTime(decayTime);
  
  // map volume sent to reverb too: further = quieter
  float dripVol = map(dripDist, 0, w, maxDripVol, 0.0f);
  drip.setVolume(dripVol, dripVol);     // volume of dry sound
  drip.setAuxEffectSendLevel(dripVol);  // and volume sent to reverb
  
  // play drip
  drip.start();
}
