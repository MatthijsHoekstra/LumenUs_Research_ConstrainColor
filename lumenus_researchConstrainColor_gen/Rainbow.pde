//Standard setup for a class

class Rainbow {

  int tubeModulus;
  int tripodNumber;
  int touchLocation;

  int startTime, livingTime;
  int randomTime;
  float c;


  Rainbow(int tubeModulus, int tripodNumber, int touchLocation) {

    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;
    this.touchLocation = touchLocation;

    startTime = millis();
    livingTime = 3000;
    randomTime = 300;
    int currentTime = 5;
  }

  void display() {

    pushMatrix();

    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21);

    pushStyle();

    fill(255);

    if (this.touchLocation == 0) {

      if (millis() < startTime + livingTime) {

        float currentTime = map(millis(), startTime, startTime + randomTime, 0, 1);
        float interValue = AULib.ease(AULib.EASE_IN_OUT_CUBIC, currentTime);
        float growth = map(interValue, 0, 1, 0, 500);

        if (c >= 255) c=0;  
        else  c=c+5;

        colorMode(HSB);
        fill(c, 255, 255);
        rect(0, 0, growth, rectHeight);
      }
    }
    // rect(0, 0, tubeLength/2, rectHeight);

    if (this.touchLocation == 1) {
      rect(tubeLength/2, 0, tubeLength/2, rectHeight);
    }

    popStyle();
    popMatrix();
  }

  boolean finished() {
    if (millis() > startTime + livingTime) {
      return true;
    } else {
      return false;
    }
  }
}