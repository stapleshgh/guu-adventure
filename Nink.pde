class Nink extends FBox {
  PImage ninkWalkLeft[];
  PImage ninkDieLeft[];
  PImage ninkWalkRight[];
  PImage ninkDieRight[];
  boolean isWalking;
  int frame;
  
  //how the nink knows which sprites to display and which direction to go
  boolean direction = false;
  
  //how the system knows to delete ninks
  boolean alive = true;
  
  //cooldown variables for wall collisions
  boolean invincible = false;
  int time = 100;
  int timer = 0;

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
    if (direction) {
      if (frameCount % 8 == 0) {
        frame = (frame + 1) % ninkWalkLeft.length;
      }
      ninkWalkLeft[frame].resize(100, 100);
      attachImage(ninkWalkLeft[frame]);
    }

  //if moving right, display walk right animation
    if (!direction) {
      if (frameCount % 8 == 0) {
        frame = (frame + 1) % ninkWalkRight.length;
      }


      ninkWalkRight[frame].resize(100, 100);
      attachImage(ninkWalkRight[frame]);
    }
  }
  void updateNink() {
    println(timer, time);
    //figuring out direction to move
    if (direction) {
      setVelocity(-100, getVelocityY());
    } else {
      setVelocity(100, getVelocityY());
    }
    
    
    //check for contacts
    checkContacts();
    
    if (invincible & time >= timer) {
      timer += 1;
    } else if (time < timer) {
      timer = 0;
      invincible = false;
    }
    
  }
  
  void checkContacts() {
    ArrayList<FContact> contactList = getContacts();
    
    for (FContact contact: contactList) {
      if (contact.contains("Wall") && !invincible) {
        direction = !direction;
        invincible = true;
        
      }
      if (contact.contains("killbox")) {
        world.remove(this);
      }
      
      
      if (contact.contains("Player") && contact.getY() < getY()) {
        world.remove(this);
      }
    }
    
    
     
  }
}
