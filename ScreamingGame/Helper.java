import processing.core.*;

public class Helper {
  public static PImage[] loadImages(PApplet p, String preName, String postName, int startNum, int lPad, int numImages) {
    PImage[] temp = new PImage[numImages];
    for (int i = 0; i < numImages; i++) {
      String lPadStr = "";
      for (int j = 0; j < lPad; j++) {
        lPadStr += "0";
      }
      String lPaddedNum = lPadStr.concat(String.valueOf(i + startNum));
      lPaddedNum = lPaddedNum.substring(lPaddedNum.length() - lPadStr.length());

      temp[i] = p.loadImage(preName + lPaddedNum + postName);
    }
    return temp;
  }
  
  //Taken from https://stackoverflow.com/questions/10119037/image-interpolation-nearest-neighbor-processing
  public static PImage scaleImage(PApplet p, PImage original, float newScale) {
    int scaledWidth = (int)(newScale*original.width);
    int scaledHeight = (int)(newScale*original.height);
    PImage out = p.createImage(scaledWidth, scaledHeight, p.ARGB);
    original.loadPixels();
    out.loadPixels();
    for (int i = 0; i < scaledHeight; i++) {
      for (int j = 0; j < scaledWidth; j++) {
        int y = Math.min( p.round(i / newScale), original.height - 1 ) * original.width;
        int x = Math.min( p.round(j / newScale), original.width - 1 );
        out.pixels[(int)((scaledWidth * i) + j)] = original.pixels[(y + x)];
      }
    }
    return out;
  }
}