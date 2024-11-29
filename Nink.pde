class Nink {
  PImage ninkWalk[];
  PImage ninkDie[];
  boolean isWalking;
  int frame;
  PVector position;
  int direction = 1;
  
  Nink() {
    frame = 0;
    imageMode(CENTER);
    ninkWalk = new PImage[8];
    
    for (int i = 0; i < ninkWalk.length; i++) {
      ninkWalk[i] = loadImage("ninkWalk (" + (i + 1) + ").png");
    }
    
    
  }
  
  void drawNink() {
    if (frameCount % 8 == 0) {
      frame = (frame + 1) % ninkWalk.length;
    }
    
    image(ninkWalk[frame], 200, 100);
  }
  
}
