import processing.sound.*;
import java.util.Arrays;

PApplet pThis = this;

public class AudioInputManager {
  AudioIn mic;
  Amplitude amp;
  FFT fft;
  Game g;
  int bands = 128;
  float[] spectrum = new float[bands];
  
  
  public AudioInputManager(Game g) {
    this.g = g;
    mic = new AudioIn(pThis, 0);
    amp = new Amplitude(pThis);
    fft = new FFT(pThis, bands);
    mic.start();
    amp.input(mic);
    fft.input(mic);
  }

  void showAmplitude(){
    println(amp.analyze() * 10);
  }
  
  void updatePitch(){
    fft.analyze(spectrum);
  }
  
  //private int calculateBackgroundFrequency(){
  // int totalFrequency = 0;
  // for (int i = 0; i < bands; i++){
  //   totalFrequency += spectrum[i];
  // }
  // return totalFrequency / bands;
  //}
  
  void showPitch(){
    //println(fft.analyze(spectrum));
    println(pitch());
  }
  
  float pitch(){
    updatePitch();

    int maxIndex = 0;
    float maxFreq = spectrum[0];
    for (int i = 1; i < 128; i++){
      if (spectrum[i] > maxFreq){
        maxIndex = i;
        maxFreq = spectrum[i];
      }
    }
    float totalFreqs = 0;
    if (maxIndex > 5){
      for (int i = maxIndex - 5; i < maxIndex + 5; i++){
        totalFreqs += spectrum[i];
      }
    }else{
      for (int i = maxIndex; i < maxIndex + 11; i++){
        totalFreqs += spectrum[i];
      }
    }
    return totalFreqs / 11 * 100;
    /**
    int[] maxIndices = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    float[] maxFreqs = new float[10];
    for (int i = 0; i < 10; i++){
      maxFreqs[i] = spectrum[i];
    }
    for (int i = 10; i < 128; i++){
      float currentMin = min(maxFreqs);
      if (spectrum[i] > currentMin){
        int replacingIndex = find(currentMin, maxFreqs);
        maxIndices[replacingIndex] = i;
        maxFreqs[replacingIndex] = spectrum[i];
      }
    }
    int indexSum = 0;
    for (int index:maxIndices){
      indexSum+= index;
    }
    **/
    /**
    float[] maxFreqs = new float[10];
    for (int i = 0; i < 10; i++){
      maxFreqs[i] = spectrum[i];
    }
    for (int i = 10; i < 128; i++){
      float currentMin = min(maxFreqs);
      if (spectrum[i] > currentMin){
        int replacingIndex = find(currentMin, maxFreqs);
        maxFreqs[replacingIndex] = spectrum[i];
      }
    }
    float totalFreqs = 0;
    for (int i = 0; i < 10; i++){
      totalFreqs += maxFreqs[i];
    }
    return totalFreqs * 1000;
    **/
    
    //return spectrum[indexSum / 10] * 1000;
      
  }
  
  int find(float num, float[] maxFreqs){
    for (int i = 0; i < maxFreqs.length; i++){
      if (maxFreqs[i] == num)
        return i;
    }
    return -1;
  }
  
  PVector getAcceleration(){
    float yValue = g.getWorld().getGravity().y;
    if (pitch() > 30){
      println(true);
      if (g.getWorld().getPlayer().isOnGround()) {
      yValue = -25;
      }
    }
    float xValue = amp.analyze() * 10;
    if (xValue < 1){
      xValue = 0;
    }
    return new PVector(xValue, yValue);
    
  }
  
  
  
  //public int getAmplitude(){
    
  //}
  
  //mic.getLevel() returns the amplitude of the sound
}
