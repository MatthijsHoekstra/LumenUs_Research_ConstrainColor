color[] colorsEffectBlock = {#ff0000, #0000ff, #00ff00, #ff5000, #ff00ae};

class EffectBlock {

  int tubeModulus;
  int tripodNumber;
  int touchLocation;
  int experimentNumber;

  private int timeCreated;
  private int livingTime;
  private int fadeInOutTime;

  private int opacity = 0;

  private boolean effectFinished = false;

  boolean fadeOutImmediate = false;
  
  int id;
  
  color colorBlock;


  EffectBlock(int tripodNumber, int tubeModulus, int expirementNumber, int touchLocation, boolean delay, int id) {
    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;

    this.touchLocation = touchLocation;

    this.experimentNumber = expirementNumber;
    
    this.id = id;
    
    colorBlock = colorsEffectBlock[id-1];

    timeCreated = millis();

    fadeInOutTime = 1000;

    livingTime = 2000;

    println("EffectBlock created, position: " + this.tripodNumber + " , " + this.tubeModulus + " , experimentNumber:" + experimentNumberFinal);

    if (delay) {
      timeCreated += random(3500);
    }
  }

  void display() {
    pushMatrix();
    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21);

    // ----- Fade in out automatically for experiment setting 2

    //if (experimentNumber == 2) {

    //  if (millis() < timeCreated + fadeInOutTime) {
    //    float currentTime = map(millis(), timeCreated, timeCreated + fadeInOutTime, 0, 1);
    //    float interValue = AULib.ease(AULib.EASE_IN_OUT_CUBIC, currentTime);
    //    opacity = int(map(interValue, 0, 1, 0, 255));
    //  } else if (millis() >= timeCreated + fadeInOutTime && millis() <= timeCreated + fadeInOutTime + livingTime) {
    //    opacity = 255;
    //  } else if (millis() <= timeCreated + fadeInOutTime*2 + livingTime) {
    //    float currentTime = map(millis(), timeCreated+fadeInOutTime+livingTime, timeCreated+fadeInOutTime*2+livingTime, 0, 1);
    //    float interValue = AULib.ease(AULib.EASE_IN_OUT_CUBIC, currentTime);
    //    opacity = int(map(interValue, 0, 1, 255, 0));

    //    if (opacity == 0) {
    //      effectFinished = true;
    //    }
    //  }
    //}

    //// ------

    //if (experimentNumber == 3) {
      if (millis() < timeCreated + fadeInOutTime) {
        float currentTime = map(millis(), timeCreated, timeCreated + fadeInOutTime, 0, 1);
        float interValue = AULib.ease(AULib.EASE_IN_OUT_CUBIC, currentTime);
        opacity = int(map(interValue, 0, 1, 0, 255));
      } else if (millis() >= timeCreated + fadeInOutTime) {
        opacity = 255;
      }
    //}

    pushStyle();


    if (this.touchLocation == 0) {
      fill(colorBlock, opacity);
      rect(0, 0, tubeLength/2, rectHeight);
    }

    if (this.touchLocation == 1) {
      fill(colorBlock, opacity);
      rect(tubeLength/2, 0, tubeLength/2, rectHeight);
    }

    //print(opacity + ",");
    popStyle();
    popMatrix();
  }

  boolean finished() {
    if (effectFinished) {
      println("EffectBlock removed");
      return true;
    } else {
      return false;
    }
  }
}