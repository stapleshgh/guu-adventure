import fisica.*;
import processing.sound.*;

//variable declaration --------------------------------------------
int gameState = 0;
FWorld world;
PImage menu;
PImage badEnd;
PImage goodEnd;

//music -------------------------
SoundFile menuMusic;
SoundFile badEndMusic;
SoundFile goodEndMusic;
SoundFile gameMusic;

//create player object ------------------------
Player player;

//create enemies ------------------------
ArrayList<Nink> ninks;
Nink nink;

//create platforms --------------------------
ArrayList<Platform> platforms;
Platform platform;

//killbox for void
KillBox kb;

//create stars
Star star;

void setup() {
  size(500, 500);
  imageMode(CORNER);
  rectMode(CENTER);

  //load menu assets
  menu = loadImage("menuScreen.png");
  menuMusic = new SoundFile(this, "menuMusic.wav");
  menuMusic.amp(0.5);
  
  //initialize entity arrays
  platforms = new ArrayList<Platform>();

  //load bad end assets
  badEnd = loadImage("badEnd.jpg");
  badEnd.resize(500, 500);
  badEndMusic = new SoundFile(this, "badEndMusic.mp3");

  //fisica initialization --------------------------------
  Fisica.init(this);

  

  //load world: initialize world properties --------------------------------------------
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  //world.setEdges();
  //world.setEdgesFriction(20);
  world.remove(world.top);
  world.remove(world.right);

  //create platforms
  platform = new Platform(400, 300, 200, 50);
  platforms.add(new Platform(-200, 400, 200, 50));
  platforms.add(new Platform(100, 400, 200, 50));
  platforms.add(new Platform(300, 400, 200, 50));
  platforms.add(new Platform(500, 400, 200, 50));
  platforms.add(new Platform(700, 400, 200, 50));
  platforms.add(new Platform(900, 400, 200, 50));
  platforms.add(new Platform(1100, 400, 200, 50));
  platforms.add(new Platform(1300, 400, 200, 50));
  platforms.add(new Platform(1600, 200, 200, 50));
  
  //init void killbox
  kb = new KillBox(-1200, 1000, 24000, 50);
  

  //init test nink ----------------------------------------------
  nink = new Nink(this);
  
  //create player----------------------------------------------
  player = new Player(this);
  
  //create stars ---------------------------------------
  star = new Star(900, 350);

  //music
  gameMusic = new SoundFile(this, "levelMusic.mp3");

  //add to world
  world.add(nink);
  world.add(player);
  world.add(star);
  world.add(kb);
  
  for (Platform p : platforms) {
    world.add(p);
  }
}


void draw() {
  background(255);
  println(player.position);

  //menu screen
  if (gameState == 0) {
    imageMode(CENTER);
    menu.resize(500, 500);
    image(menu, 250, 250);
    if (!menuMusic.isPlaying()) {
      menuMusic.loop();
    }

    if (keyPressed) {
      //unload music
      menuMusic.pause();
      menuMusic.removeFromCache();
      gameState = 1;
      imageMode(CORNER);
    }
  }

  //game loop
  if (gameState == 1) {
    //check for game over
    checkGameOver();
    
    //draw world
    pushMatrix();
    translate(-player.getX() + width / 2, -player.getY() + height / 2);
    world.step();
    world.draw();

    popMatrix();

    //draw world entities
    nink.drawNink();
    player.drawPlayer();
    player.updatePlayer();
    star.drawStar();
    
    for (Platform p : platforms) {
      p.drawPlatform();
    }

    
    //music
    if (!gameMusic.isPlaying()) {
      gameMusic.loop();
    }
  }


  //you win! screen
  if (gameState == 2) {
    println("win");
  }

  //you lose! screen
  if (gameState == 3) {
    gameMusic.pause();
    imageMode(CENTER);
    badEnd.resize(500,  500);
    image(badEnd, 250, 250);
    if (!badEndMusic.isPlaying()) {
      badEndMusic.loop();
    }

    if (keyPressed) {
      badEndMusic.pause();
      gameState = 0;
      player.lives = 3;
      player.setPosition(0, 0);
      imageMode(CORNER);
    }
  }
}

void checkGameOver() {
  if (player.lives <= 0) {
    gameState = 3;
  }
}
