/* The Lighteffect class is the mediator of the entire code
 lighteffect.update is the only function that is CONSTANTLY running
 .update checks the tubes that are active, decides what light-effect they should show and exectues the corrosponding functions
 */

//import toxi.util.events.*;



class Tube {
  private int tubeNumber;
  private int tubeModulus;
  private int tripodNumber;

  ArrayList<Block> Blocks = new ArrayList<Block>();
  ArrayList<EffectBlock> EffectBlocks = new ArrayList<EffectBlock>();

  private boolean amIBroken0 = false;
  private boolean amIBroken1 = false;

  ArrayList<GlitterEffect> glitterEffects = new ArrayList<GlitterEffect>();
  ArrayList<ExplosionEffect> explosionEffects = new ArrayList<ExplosionEffect>();
  ArrayList<DBZ> DBZs = new ArrayList<DBZ>();
  ArrayList<Rainbow> Rainbows = new ArrayList<Rainbow>();

  ArrayList<Timer> timers = new ArrayList<Timer>();

  boolean effectSide0 = false;
  boolean effectSide1 = false;

  Tube(int tubeNumber) {
    this.tubeNumber = tubeNumber; //0 - numTubes
    this.tubeModulus = tubeNumber % 3; // 0, 1, 2
    this.tripodNumber = tubeNumber / 3; //0 - numTubes / 3
  }

  //Event when tube is touched


  void isTouched(int touchLocation) {

    if (touchLocation == 0) {

      boolean constrainTouched = false;

      for (int i = 0; i < EffectBlocks.size(); i++) {
        EffectBlock effectblock = EffectBlocks.get(i);

        if (effectblock.touchLocation == 0) {
          constrainTouched = true;
        }
      }


      timers.add(new Timer(tubeModulus, tripodNumber, touchLocation, constrainTouched));
    }

    if (touchLocation == 1) {

      boolean constrainTouched = false;

      for (int i = 0; i < EffectBlocks.size(); i++) {
        EffectBlock effectblock = EffectBlocks.get(i);

        if (effectblock.touchLocation == 1) {
          constrainTouched = true;
        }
      }

      timers.add(new Timer(tubeModulus, tripodNumber, touchLocation, constrainTouched));
    }

    if (experimentNumberFinal == 1) {
      for (int i = 0; i < EffectBlocks.size(); i++) {
        EffectBlock effectblocks = EffectBlocks.get(i);

        if (effectblocks.touchLocation == touchLocation) {
          int id = effectblocks.id;
          EffectBlocks.remove(i);

          summon("random");

          createEffectBlock(id);
        }
      }
    } else if (experimentNumberFinal == 2) {
      for (int i = 0; i < EffectBlocks.size(); i++) {
        EffectBlock effectblocks = EffectBlocks.get(i);

        if (effectblocks.touchLocation == touchLocation) {
          int id = effectblocks.id;
          println("id: " + id);

          EffectBlocks.remove(i);

          summon(EffectsAvailable[id-1]);

          createEffectBlock(id);
        }
      }
    }
  }

  //Event when tube is released

  void isUnTouched(int touchLocation) {
    for (int i = 0; i < timers.size(); i++) {
      Timer timer = timers.get(i);

      if (timer.sideTouch == touchLocation) {
        timer.logTime();

        timers.remove(i);
      }
    }
  }

  // Executed every frame, for updating continiously things
  void update() {
    shutOffTheBroken();

    for (int i = 0; i < EffectBlocks.size(); i++) {
      EffectBlock effectblock = EffectBlocks.get(i);

      effectblock.display();
    }

    for (int i = glitterEffects.size() - 1; i >= 0; i--) {
      GlitterEffect glitterEffect = glitterEffects.get(i);

      glitterEffect.update();

      if (!glitterEffect.timeFinished()) {
        glitterEffect.generate();
      }

      if (glitterEffect.animationFinished()) {
        glitterEffects.remove(i);
      }
    }

    for (int i = 0; i < DBZs.size(); i++) {
      DBZ dbzs = DBZs.get(i);

      dbzs.update();

      if (dbzs.finished()) {
        DBZs.remove(i);
      }
    }

    for (int i = 0; i < Rainbows.size(); i++) {
      Rainbow rainbows = Rainbows.get(i);

      rainbows.display();

      if (rainbows.finished()) {
        Rainbows.remove(i);
      }
    }


    //for (int i = explosionEffects.size() - 1; i >= 0; i--) {
    //  ExplosionEffect explosionEffect = explosionEffects.get(i);

    //  explosionEffect.update();

    //  if (!explosionEffect.timeFinished()) {
    //    explosionEffect.generate();
    //  }

    //  if (explosionEffect.animationFinished()) {
    //    explosionEffects.remove(i);
    //  }
    //}
  }

  void addGlitter() {
    glitterEffects.add(new GlitterEffect(this.tubeModulus, this.tripodNumber));
  }

  void addExplosion() {
    explosionEffects.add(new ExplosionEffect(this.tubeModulus, this.tripodNumber));
  }

  void shutOffTheBroken() {
    if (amIBroken0 == true || amIBroken1 == true) {
      pushMatrix();
      translate(tubeModulus * (numLEDsPerTube * rectWidth) + (tubeModulus * 20 + 20), tripodNumber * 21 + 21); 
      pushStyle();
      noStroke();
      fill(255, 0, 0);
      if (amIBroken0 == true) {
        rect((tubeLength/2)*0, 0, tubeLength/2, rectHeight);
      }
      if (amIBroken1 == true) {
        rect((tubeLength/2)*1, 0, tubeLength/2, rectHeight);
      }
      popStyle();
      popMatrix();
    }
  }

  void summon(String Effect) {

    int effectNumberRandom = -1;
    boolean randomEffectChosen = false;

    if (Effect.equals("random") == true) {
      effectNumberRandom = AULib.chooseOneWeighted(effectNumberArray, EffectsWeights);
      randomEffectChosen = true;

      println("random effect: " + EffectsAvailable[effectNumberRandom] + " chosen");
    }

    // The number of effectNumberRandom is the number of the position of the effect in the array effectsAvailable
    if ((effectNumberRandom == 0) || (!randomEffectChosen && Effect.equals("Glitter"))) {
      println("GlitterEffect summoned");
      glitterEffects.add(new GlitterEffect(this.tripodNumber, this.tubeModulus));

      //To indicate that something is running in tube, we don't want to effects overlying eachother, set to false when removing effect
      //effectSide0 = true;
      //effectSide1 = true;
    }

    if ((effectNumberRandom == 1) || (!randomEffectChosen && Effect.equals("DBZ"))) {
      println("DBZ summoned");
      DBZs.add(new DBZ(this.tubeModulus, this.tripodNumber));

      //To indicate that something is running in tube, we don't want to effects overlying eachother, set to false when removing effect
      //effectSide0 = true;
      //effectSide1 = true;
    }

    if ((effectNumberRandom == 2) || (!randomEffectChosen && Effect.equals("Rainbow"))) {
      println("Rainbow summoned");
      Rainbows.add(new Rainbow(this.tubeModulus, this.tripodNumber, 0));

      //To indicate that something is running in tube, we don't want to effects overlying eachother, set to false when removing effect
      //effectSide0 = true;
      //effectSide1 = true;
    }
  }
}