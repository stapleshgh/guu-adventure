//controller booleans

boolean right;
boolean left;
boolean jump;

class Player extends FBox {
  //sound effects
  SoundFile fart;
  SoundFile walk;
  
  //animaton arrays / sprites
  PImage guuWalkRight[];
  PImage guuWalkLeft[];
  PImage guuDie[];
  PImage guuIdle;
  PImage jumpRight;
  PImage jumpLeft;
  
  //player variables
  int lives = 3;
  
  boolean isWalking;
  int frame;
  PVector position;

  Player(PApplet p) {
    //invoke parent constructor
    super(50, 100);
    imageMode(CORNER);
    
    //sound effects init
    fart = new SoundFile(p, "fart.mp3");
    walk = new SoundFile(p, "walkSound.mp3");

    //creating animation arrays
    guuWalkRight = new PImage[7];
    guuWalkLeft = new PImage[7];
    frame = 0;

    //setting parameters for player
    setPosition(300, 200);
    setRotatable(false);
    setGrabbable(false);
    setAllowSleeping(false);

    //load animations
    for (int i = 0; i < guuWalkRight.length; i++) {
      guuWalkRight[i] = loadImage("guuWalk" + (i + 2) + ".png");
    }

    for (int i = 0; i < guuWalkLeft.length; i++) {
      guuWalkLeft[i] = loadImage("guuWalk" + (i + 11) + ".png");
    }
    
    //load idle sprites
    guuIdle = loadImage("guuWalk1.png");
    jumpRight = loadImage("guuWalk9.png");
    jumpLeft = loadImage("guuWalk19.png");
  }


//draw function
  void drawPlayer() {
    
    //movement + animation code
    if (right && getVelocityY() == 0) {
      //animation loop. changes frame every 4 frames
      if (frameCount % 4 == 0) {
        frame = (frame + 1) % guuWalkRight.length;
      }
      //resizes frame and attaches frame to FBox
      guuWalkRight[frame].resize(100, 100);
      attachImage(guuWalkRight[frame]);
      
    } else if (left && getVelocityY() == 0) {
      //animation loop. changes frame every 4 frames
      if (frameCount % 4 == 0) {
        frame = (frame + 1) % guuWalkLeft.length;
      }
       //resizes frame and attaches frame to FBox
      guuWalkLeft[frame].resize(100, 100);
      attachImage(guuWalkLeft[frame]);
      
    } else if (getVelocityY() > 100 || getVelocityY() < -100 ) {
      //jumping frame
      jumpRight.resize(100, 100);
      attachImage(jumpRight);
    }else {
      //attaches idle sprite to FBox
      attachImage(guuIdle);
      guuIdle.resize(100, 100);
    }
    
    
    if ((right || left)&& !walk.isPlaying()) {
      walk.loop();
    }
    if (!right && !left) {
      walk.pause();
    }
  }

  //update function
  void updatePlayer() {

    //jump code. check if player is touching ground
    if (jump && getVelocityY() == 0) {
      addImpulse(0, -9000);
      fart.play();
    }

    //move right if key pressed
    if (right && getVelocityX() <= 500) {
      setVelocity(getVelocityX() + 50, getVelocityY());
    } else if (left && getVelocityX() >= -500) {
      setVelocity(getVelocityX() - 50, getVelocityY());
    } else {
      //apply air friction if neither key is being pressed and velocity isnt zero
      if (getVelocityX() >= 0) {
        setVelocity(getVelocityX() - 1, getVelocityY());
      }
      if (getVelocityX() <= 0) {
        setVelocity(getVelocityX() + 1, getVelocityY());
      }
    }
    
    
  }
  
  

}

void keyPressed() {
  if (key == ' ') {
    jump = true;
  }
  if (key == 'a') {
    left = true;
    right = false;
  }
  if (key == 'd') {
    left = false;
    right = true;
  }
}

void keyReleased() {
  if (key == ' ') {
    jump = false;
  }
  if (key == 'a') {
    left = false;
  }
  if (key == 'd') {
    right = false;
  }
}
