public PImage[] loadImages(String preName, String postName, int startNum, int lPad, int numImages) {
  PImage[] temp = new PImage[numImages];
  for (int i = 0; i < numImages; i++) {
    String lPaddedNum = leftPad(lPad, String.valueOf(i + startNum));
    temp[i] = loadImage(preName + lPaddedNum + postName);
  }
  return temp;
}

public String leftPad(int lPad, String str) {
  String lPadStr = "";
    for (int j = 0; j < lPad; j++) {
      lPadStr += "0";
    }
    String temp = lPadStr.concat(str);
    temp = temp.substring(temp.length() - lPadStr.length());
    return temp;
}

//Taken from https://stackoverflow.com/questions/10119037/image-interpolation-nearest-neighbor-processing
public PImage scaleImage(PImage original, float newScale) {
  int scaledWidth = (int)(newScale*original.width);
  int scaledHeight = (int)(newScale*original.height);
  PImage out = createImage(scaledWidth, scaledHeight, ARGB);
  original.loadPixels();
  out.loadPixels();
  for (int i = 0; i < scaledHeight; i++) {
    for (int j = 0; j < scaledWidth; j++) {
      int y = Math.min( floor(i / newScale), original.height - 1 ) * original.width;
      int x = Math.min( floor(j / newScale), original.width - 1 );
      out.pixels[(int)((scaledWidth * i) + j)] = original.pixels[(y + x)];
    }
  }
  return out;
}
