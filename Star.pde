class Star extends FBox{ 
  PImage idle[];
  int frame = 0;
  
  
  Star(int x, int y) {
    
    super(100, 100);
    setPosition(x, y);
    imageMode(CORNER);
    
    //load animation frames
    idle = new PImage[2];
    idle[0] = loadImage("star1.png");
    idle[1] = loadImage("star2.png");
    
    //set FBox properties
    setName("Star");
    setGrabbable(false);
    setStatic(true);
    
  }
  
  void drawStar() {
    if (frameCount % 8 == 0) {
      frame = (frame + 1) % idle.length;
    }

    idle[frame].resize(100, 80);
    attachImage(idle[frame]);
  }
}
