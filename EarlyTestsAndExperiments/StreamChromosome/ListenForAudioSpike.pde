
// via: http://stackoverflow.com/a/6186977
boolean detectAudioSpike() {
  boolean recorder=true;
  int minSize = AudioRecord.getMinBufferSize(8000, AudioFormat.CHANNEL_CONFIGURATION_MONO, AudioFormat.ENCODING_PCM_16BIT);
  AudioRecord ar = new AudioRecord(MediaRecorder.AudioSource.MIC, 8000, AudioFormat.CHANNEL_CONFIGURATION_MONO, AudioFormat.ENCODING_PCM_16BIT, minSize);
  short[] buffer = new short[minSize];
  ar.startRecording();

  /*
  // better detection but fucks up play
   while (recorder) {
   ar.read(buffer, 0, minSize);
   int average = 0;              // int since short might rollover
   for (short s : buffer) {
   average += abs(s);
   }
   average /= buffer.length;
   
   if (average > spikeThresh) {
   println("  Spike: " + average);
   ar.stop();
   recorder = false;
   return true;
   }
   }
   return false;
   */

  // lets user play, but is VERY sensitive
  while (recorder) {
    ar.read(buffer, 0, minSize);
    for (short s : buffer) {
      if (Math.abs(s) > spikeThresh) {
        int vol = Math.abs(s);
        System.out.println("Blow Value: " + vol);
        ar.stop();
        recorder = false;
        return true;
      }
    }
  }
  return false;
}
