
void createLevelImage(int startX, int startY) {
  
  level = createImage(levelWidth,levelHeight, RGB);
  level.loadPixels();
  for (int i=0; i<level.pixels.length; i++) {
    level.pixels[i] = bgColor;
  }
  x = startX;
  y = startY;
  
  // read data into level image
  try {
    reader = createReader(filename);
    String line;
    int index = 0;
    
    while ((line = reader.readLine()) != null) {
      if (maxDepth != -1 && index > maxDepth) {
        break;
      }
      
      line = line.toLowerCase();
      for (int i=0; i<line.length(); i++) {
        index++;
        switch(line.charAt(i)) {
          case 'a':                          // north/up
            y -= 1;
            if (y < 0) y = level.height-1;
            break;
          case 'c':                          // east/right
            x += 1;
            if (x > level.width-1) x = 0;
            break;
          case 'g':                          // south/down
            y += 1;
            if (y > level.height-1) y = 0;
            break;
          case 't':                          // west/left
            x -= 1;
            if (x < 0) x = level.width-1;
            break;
          default: continue;                 // skip any other characters
        }
        
        if (level.pixels[y*level.width + x] == traversedColor) {    // if traversed already, set to open
          level.pixels[y*level.width + x] = openColor;
        }
        else if (level.pixels[y*level.width + x] == bgColor) {      // if not traversed, set from bg
          level.pixels[y*level.width + x] = traversedColor;
        }
        
      }
    }
    
    // remove traversed but not double+
    for (int i=0; i<level.pixels.length; i++) {
      if (level.pixels[i] == traversedColor) level.pixels[i] = bgColor;
    }
    level.updatePixels();
    
    // how many data points?
    println("# of data points read: " + nfc(index));
  }
  
  // errors?
  catch (IOException ioe) {
    println("Error reading data file...");
    exit();
  }
}
