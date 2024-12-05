class Nink extends FBox {
  PImage ninkWalkLeft[];
  PImage ninkDieLeft[];
  PImage ninkWalkRight[];
  PImage ninkDieRight[];
  boolean isWalking;
  int frame;
  PVector position;
  int direction = 2;

  Nink(PApplet p, int x, int y) {
    super(50, 90);
    frame = 0;
    imageMode(CORNER);
    ninkWalkRight = new PImage[8];
    ninkDieRight = new PImage[8];
    ninkWalkLeft = new PImage[8];
    ninkDieLeft = new PImage[8];
    setPosition(x, y);
    setRotatable(false);
    setGrabbable(false);
    setName("Nink");


    //load walkLeft array
    for (int i = 0; i < ninkWalkLeft.length; i++) {
      ninkWalkLeft[i] = loadImage("ninkWalk (" + (i + 1) + ").png");
    }

    //load dieLeft array (
    for (int i = 0; i < ninkDieLeft.length; i++) {
      ninkDieLeft[i] = loadImage("ninkWalk (" + (i + 8) + ").png");
    }
    
    //load walkRight array (
    for (int i = 0; i < ninkWalkRight.length; i++) {
      ninkWalkRight[i] = loadImage("ninkWalk (" + (i + 17) + ").png");
    }
    
    //load dieRight array (
    for (int i = 0; i < ninkDieRight.length; i++) {
      ninkDieRight[i] = loadImage("ninkWalk (" + (i + 8) + ").png");
    }
    
  }

  void drawNink() {


    //if moving left, display walk left animation
    if (direction == 1) {
      if (frameCount % 8 == 0) {
        frame = (frame + 1) % ninkWalkLeft.length;
      }
      ninkWalkLeft[frame].resize(100, 100);
      attachImage(ninkWalkLeft[frame]);
    }

  //if moving right, display walk right animation
    if (direction == 2) {
      if (frameCount % 8 == 0) {
        frame = (frame + 1) % ninkWalkRight.length;
      }


      ninkWalkRight[frame].resize(100, 100);
      attachImage(ninkWalkRight[frame]);
    }
  }
  void updateNink() {
  }
}
