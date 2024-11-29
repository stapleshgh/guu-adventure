class Nink extends FBox{
  PImage ninkWalk[];
  PImage ninkDie[];
  boolean isWalking;
  int frame;
  PVector position;
  int direction = 1;
  
  Nink() {
    super(50, 50);
    frame = 0;
    imageMode(CENTER);
    ninkWalk = new PImage[8];
    setPosition(200, 200);
    
    for (int i = 0; i < ninkWalk.length; i++) {
      ninkWalk[i] = loadImage("ninkWalk (" + (i + 1) + ").png");
    }
    
    
  }
  
  void drawNink() {
    if (frameCount % 8 == 0) {
      frame = (frame + 1) % ninkWalk.length;
    }
    
    ninkWalk[frame].resize(50, 50);
    attachImage(ninkWalk[frame]);
  }
  
}
