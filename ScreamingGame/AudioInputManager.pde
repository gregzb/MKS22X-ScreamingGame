import processing.sound.*;

PApplet pThis = this;

public class AudioInputManager {
  AudioIn mic;
  Amplitude amp;
  FFT fft;
  Game g;
  
  
  public AudioInputManager(Game g) {
    this.g = g;
    mic = new AudioIn(pThis, 0);
    amp = new Amplitude(pThis);
    mic.start();
    amp.input(mic);
    fft.input(mic);
  }

  void showAmplitude(){
    println(amp.analyze());
  }
  
  void showPitch(){
    println(fft.analyze());
  }
  
  PVector getAcceleration(){
    return new PVector(amp.analyze() * 10, g.getWorld().getGravity().y);
  }
  
  
  
  //public int getAmplitude(){
    
  //}
  
  //mic.getLevel() returns the amplitude of the sound
}
