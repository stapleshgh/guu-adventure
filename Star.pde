class Star extends FBox{ 
  PImage idle[];
  int frame = 0;
  boolean alive = true;
  
  
  Star(PApplet p, int x, int y) {
    
    super(100, 100);
    imageMode(CORNER);
    
    //set FBox properties
    setName("Star");
    setGrabbable(false);
    setStatic(true);
    setPosition(x, y);
    setSensor(true);
    
    
    //load animation frames
    idle = new PImage[2];
    idle[0] = loadImage("star1.png");
    idle[1] = loadImage("star2.png");
    
    
  }
  
  void drawStar() {
    if (frameCount % 8 == 0) {
      frame = (frame + 1) % idle.length;
    }
    
    
    idle[frame].resize(100, 80);
    
    if (alive){
      attachImage(idle[frame]);
    }
  }
  
  void updateStar() {
    checkContacts();
    
  }
  
  void checkContacts() {
    ArrayList<FContact> contactList = getContacts();
    
    for (FContact contact: contactList) {
      if (contact.contains("Player")) {
        alive = false;
      }
    }
  }
}
