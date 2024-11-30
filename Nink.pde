class Nink extends FBox{
  PImage ninkWalk[];
  PImage ninkDie[];
  boolean isWalking;
  int frame;
  PVector position;
  int direction = 1;
  
  Nink() {
    super(50, 90);
    frame = 0;
    imageMode(CORNER);
    ninkWalk = new PImage[8];
    setPosition(200, 200);
    setRotatable(false);
    setGrabbable(false);
    setName("Nink");
    
    
    for (int i = 0; i < ninkWalk.length; i++) {
      ninkWalk[i] = loadImage("ninkWalk (" + (i + 1) + ").png");
    }
    
    
  }
  
  void drawNink() {
    if (frameCount % 8 == 0) {
      frame = (frame + 1) % ninkWalk.length;
    }
    
    ninkWalk[frame].resize(100, 100);
    attachImage(ninkWalk[frame]);
  }
  
}
