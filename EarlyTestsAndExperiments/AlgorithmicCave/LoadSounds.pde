
void loadSounds() {
  
    // footsteps
    try {
    footsteps = new MediaPlayer();
    AssetManager assets = this.getAssets();
    AssetFileDescriptor fd = assets.openFd("gravel-2step_veryShort.wav");
    footsteps.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    
    // add reverb settings
    reverb = new EnvironmentalReverb(0, 0);
    reverb.setDecayTime(decayTime);
    reverb.setDensity(density);
    reverb.setDiffusion(diffusion);
    reverb.setReverbLevel(reverbLevel);
    reverb.setRoomLevel(roomLevel);
    reverb.setReflectionsDelay(reflectionsDelay);
    reverb.setReflectionsLevel(reflectionsLevel);
    reverb.setReverbDelay(reverbDelay);
    reverb.setEnabled(true);
    
    footsteps.attachAuxEffect(reverb.getId());
    footsteps.setAuxEffectSendLevel(1.0f);
    footsteps.prepare();
  }
  catch (IOException ioe) {
    println("Error (probably could not find or load the audio file - is it in the sketch's data folder?)");
  }
  
  // drip
    try {
    drip = new MediaPlayer();
    AssetManager assets = this.getAssets();
    AssetFileDescriptor fd = assets.openFd("drip.wav");
    drip.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
    
    // add reverb settings
    reverb = new EnvironmentalReverb(0, 0);
    reverb.setDecayTime(decayTime);
    reverb.setDensity(density);
    reverb.setDiffusion(diffusion);
    reverb.setReverbLevel(reverbLevel);
    reverb.setRoomLevel(roomLevel);
    reverb.setReflectionsDelay(reflectionsDelay);
    reverb.setReflectionsLevel(reflectionsLevel);
    reverb.setReverbDelay(reverbDelay);
    reverb.setEnabled(true);
    
    drip.attachAuxEffect(reverb.getId());
    drip.setAuxEffectSendLevel(1.0f);
    drip.prepare();
  }
  catch (IOException ioe) {
    println("Error (probably could not find or load the audio file - is it in the sketch's data folder?)");
  }
  
}
