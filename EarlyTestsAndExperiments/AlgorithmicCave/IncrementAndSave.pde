
void incrementAndSave(String folder, String name, int leadingZeroes) {
  String separator = "_";
  String extension = "png";  

  int maxFileNumber = 0;
  try {
    File dir = new File(folder);
    File[] files = dir.listFiles(); 
    for (File f : files) {   
      String[] findFileNumber = match(f.getName(), ".*?" + separator + "([0-9].*?)\\." + extension);
      if (findFileNumber != null) {
        int number = Integer.parseInt(findFileNumber[1]);
        if (number > maxFileNumber) {
          maxFileNumber = number;
        }
      }
    }
  }
  catch (NullPointerException npe) {      // if folder doesn't exist, make it!
    File newDir = new File(folder);
    newDir.mkdir();
  }
  String nextNumber = nf((maxFileNumber+1), leadingZeroes);
  String outputFilename = name + separator + nextNumber + "." + extension;
  save(folder + "/" + outputFilename);
}
