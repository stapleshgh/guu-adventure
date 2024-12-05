//controller booleans

boolean right;
boolean left;
boolean jump;

class Player extends FBox {
  //sound effects
  SoundFile fart;
  SoundFile walk;
  SoundFile die;

  //animaton arrays / sprites
  PImage guuWalkRight[];
  PImage guuWalkLeft[];
  PImage guuDieRight;
  PImage guuDieLeft;
  PImage guuIdle;
  PImage jumpRight;
  PImage jumpLeft;
  PImage lifeCounter;

  //player variables
  int lives = 3;
  int score = 0;
  boolean invincible = false;
  int timer = 0;
  int time = 100;

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
    die = new SoundFile(p, "guuDie.mp3");

    //creating animation arrays
    guuWalkRight = new PImage[7];
    guuWalkLeft = new PImage[7];
    frame = 0;

    //setting parameters for player
    setPosition(300, 200);
    setRotatable(false);
    setGrabbable(false);
    setAllowSleeping(false);
    setName("Player");

    //load animations
    for (int i = 0; i < guuWalkRight.length; i++) {
      guuWalkRight[i] = loadImage("guuWalk" + (i + 2) + ".png");
    }

    for (int i = 0; i < guuWalkLeft.length; i++) {
      guuWalkLeft[i] = loadImage("guuWalk" + (i + 11) + ".png");
    }

    //load idle sprites
    guuIdle = loadImage("guuWalk1.png");
    guuDieRight = loadImage("guuWalk10.png");
    guuDieLeft = loadImage("guuWalk20.png");
    jumpRight = loadImage("guuWalk9.png");
    jumpLeft = loadImage("guuWalk19.png");
    lifeCounter = loadImage("life-token.png");
    lifeCounter.resize(50, 50);
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
    } else {
      //attaches idle sprite to FBox
      attachImage(guuIdle);
      guuIdle.resize(100, 100);
    }
    
    for (int i = 0; i < lives; i ++) {
      image(lifeCounter, 0 + (i * 50), 0);
    }

    
  }

  //update function
  void updatePlayer() {
    checkContacts();

    //jump code. check if player is touching ground
    if (jump && getVelocityY() == 0) {
      addImpulse(0, -9000);
      fart.play();
    }
    
    //reset invincibility
    if (invincible && timer < time) {
      timer += 1;
    } else if (invincible && timer >= time) {
      invincible = false;
      timer = 0;
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
    
    //play bongo loop if moving
    if ((right || left)&& !walk.isPlaying()) {
      walk.loop();
    }
    if ((!right && !left)&& walk.isPlaying()) {
      walk.pause();
    }
    
  }
  
  void checkContacts() {
    ArrayList<FContact> contactList = getContacts();
    
    for (FContact contact: contactList) {
      if (contact.contains("Nink") && !invincible) {
        if (!die.isPlaying()) {
          die.play();
        }
        lives -=1;
        addImpulse(0, -11000);
        invincible = true;
      }
      if (contact.contains("killbox") && !invincible) {
        if (!die.isPlaying()) {
          die.play();
        }
        invincible = true;
        setPosition(0, 0);
        lives -=1;

      }
      if (contact.contains("Star")) {
        score += 1;
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
