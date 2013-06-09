
/*
PERLIN NOISE ARRAY FOR HAPTIC VIBRATION
Jeff Thompson | 2013 | www.jeffreythompson.org

*/

int numSteps = 10;
float stepSize = 0.5;
int[] waveform = new int[numSteps];
float offset = 0.0;

print("{ ");
for (int i=0; i<numSteps; i++) {
  if (i == 0) {
    waveform[i] = 0;
  }
  else {
    waveform[i] = int(map(noise(offset), 0.0, 1.0, 0, 100));
  }
  print(waveform[i]);
  if (i != numSteps-1) {
    print(", ");
  }
  offset += stepSize;
}
println(" };");
exit();

