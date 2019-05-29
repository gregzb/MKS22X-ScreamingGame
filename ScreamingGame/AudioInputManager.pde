import processing.sound.*;

PApplet pThis = this;

public class AudioInputManager {
  AudioIn mic;
  Amplitude amp;
  FFT fft;
  Game g;
  int bands = 512;
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
    float totalFrequency = 0;
    for (int i = 0; i < bands; i++){
      totalFrequency += spectrum[i];
    }
    return (totalFrequency / bands) * 1000 - 2;
  }
  
  PVector getAcceleration(){
    float yValue = g.getWorld().getGravity().y;
    if (pitch() > 15){
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
