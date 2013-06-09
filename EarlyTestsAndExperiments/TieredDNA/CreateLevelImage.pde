
void createLevelImage() {
  
  float inc = 1;
  float x = 0;
  float y = 0;
  float z = 0;
  int maxDepth = 60000;
  
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
            y -= inc;
            break;
          case 'c':                          // east/right
            x += inc;
            break;
          case 'g':                          // south/down
            y += inc;
            break;
          case 't':                          // west/left
            x -= inc;
            break;
          default: continue;                 // skip any other characters
        }
        
        for (Point p : pts) {
          if (p.x == x && p.y == y) {
            z += inc;
            continue;
          }
        }
        pts = (Point[])append(pts, new Point(x, y, z));
        
      }
    }
  }
  
  // errors?
  catch (IOException ioe) {
    println("Error reading data file...");
  }
}
