
void createLevelImage() {
  
  // create image and set to background
  level = createImage(levelWidth,levelHeight, RGB);
  level.loadPixels();
  for (int i=0; i<level.pixels.length; i++) {
    level.pixels[i] = bgColor;
  }
  int px = level.width/2;
  int py = level.height/2;
  
  // read data into level image
  try {
    reader = createReader(filename);
    String line;
    int index = 0;
    
    while ((line = reader.readLine()) != null && index < maxDepth) {
      line = line.toLowerCase();
      for (int i=0; i<line.length(); i++) {
        index++;
        switch(line.charAt(i)) {
          case 'a':                          // north/up
            py -= 1;
            if (py < 0) py = level.height-1;
            break;
          case 'c':                          // east/right
            px += 1;
            if (px > level.width-1) px = 0;
            break;
          case 'g':                          // south/down
            py += 1;
            if (py > level.height-1) py = 0;
            break;
          case 't':                          // west/left
            px -= 1;
            if (px < 0) px = level.width-1;
            break;
          default: continue;                 // skip any other characters
        }
        
        // if previously traversed, update color
        if (level.pixels[py*level.width + px] != bgColor) {
          float currentRed = level.pixels[py*level.width + px] >> 16 & 0xFF;
          currentRed = constrain(currentRed, 0, 255);
          level.pixels[py*level.width + px] = color(currentRed + colorInc, startColor >> 8 & 0xFF, startColor & 0xFF);
        }
        else {
          level.pixels[py*level.width + px] = startColor;
        }
      }
    }
    
    // done!
    level.updatePixels();
  }
  
  // errors?
  catch (IOException ioe) {
    println("Error reading data file...");
  }
}
