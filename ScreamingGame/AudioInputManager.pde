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
  float lastAmplitude = 0;

  ArrayList<ArrayList<Float>> spectrumHistory = new ArrayList<ArrayList<Float>>();

  public AudioInputManager(Game g) {
    this.g = g;
    mic = new AudioIn(pThis, 0);
    amp = new Amplitude(pThis);
    fft = new FFT(pThis, bands);
    mic.start();
    amp.input(mic);
    fft.input(mic);
  }

  void update() {
    lastAmplitude = amp.analyze();
    float[] tempSpectrum = fft.analyze();

    ArrayList<Float> temp = new ArrayList();
    for (float val : tempSpectrum) {
      temp.add(val);
    }

    spectrumHistory.add(temp);

    if (spectrumHistory.size() > 4) {
      spectrumHistory.remove(0);
    }

    for (int i = 0; i < spectrum.length; i++) {
      float val = 0;
      for (ArrayList<Float> timeVal : spectrumHistory) {
        val += timeVal.get(i);
      }
      val /= spectrumHistory.size();
      spectrum[i] = val;
    }
  }

  float getAmplitude() {
    return lastAmplitude * 10;
  }

  float getPitch() {    
    float sumProducts = 0;
    float sumVals = 0;

    for (int i = 0; i < spectrum.length; i++) {
      float val = spectrum[i];
      sumProducts += i * val;
      sumVals += val;
    }

    return sumProducts/sumVals;
  }

  PVector getAcceleration() {
    float yValue = g.getWorld().getGravity().y;
    float xValue = getAmplitude();

    if (xValue < .3) {
      xValue = 0;
    } else {

      if (getPitch() > 25) {
        println(true);
        if (g.getWorld().getPlayer().isOnGround()) {
          yValue = -25;
        }
      }
      
    }
    return new PVector(xValue, yValue);
  }
}
