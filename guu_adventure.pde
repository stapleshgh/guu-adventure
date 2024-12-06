import fisica.*; //<>//
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

//create enemies list ------------------------
ArrayList<Nink> ninks;

//create platforms list --------------------------
ArrayList<Platform> platforms;

//create walls list
ArrayList<Wall> walls;

//create collectibles list -----------------------
ArrayList<Star> stars;

//killbox for void
KillBox kb;

//winbox for world
WinBox wb;


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
  walls = new ArrayList<Wall>();
  ninks = new ArrayList<Nink>();
  stars = new ArrayList<Star>();

  //load bad end assets
  badEnd = loadImage("badEnd.jpg");
  badEnd.resize(500, 500);
  badEndMusic = new SoundFile(this, "badEndMusic.mp3");

  //load good end assets
  goodEnd = loadImage("guudend.png");
  goodEndMusic = new SoundFile(this, "guudend.mp3");

  //fisica initialization --------------------------------
  Fisica.init(this);



  //load world: initialize world properties --------------------------------------------
  world = new FWorld(-20000, -20000, 20000, 20000);
  world.setGravity(0, 900);
  //world.setEdges();
  //world.setEdgesFriction(20);
  world.remove(world.top);
  world.remove(world.right);

  //create platforms
  platforms.add(new Platform(-300, 400, 200, 50));
  platforms.add(new Platform(-100, 400, 200, 50));
  platforms.add(new Platform(100, 400, 200, 50));
  platforms.add(new Platform(300, 400, 200, 50));
  platforms.add(new Platform(500, 400, 200, 50));
  platforms.add(new Platform(700, 400, 200, 50));
  platforms.add(new Platform(900, 400, 200, 50));
  platforms.add(new Platform(1100, 400, 200, 50));
  platforms.add(new Platform(1300, 400, 200, 50));
  platforms.add(new Platform(1500, 200, 200, 50));
  platforms.add(new Platform(1700, 0, 200, 50));
  platforms.add(new Platform(1900, 200, 200, 50));
  platforms.add(new Platform(2100, 200, 200, 50));
  platforms.add(new Platform(2300, 200, 200, 50));
  platforms.add(new Platform(2500, 200, 200, 50));
  platforms.add(new Platform(2200, 0, 200, 50));
  platforms.add(new Platform(2700, 0, 200, 50));
  platforms.add(new Platform(2900, 500, 200, 50));
  platforms.add(new Platform(3100, 600, 200, 200));
  platforms.add(new Platform(3300, 700, 200, 200));
  platforms.add(new Platform(3500, 800, 200, 200));
  platforms.add(new Platform(3700, 800, 200, 200));
  platforms.add(new Platform(3900, 800, 200, 200));
  platforms.add(new Platform(4100, 800, 200, 200));

  //create walls

  walls.add(new Wall(-400, 300, 50, 500));
  walls.add(new Wall(-400, -200, 50, 500));
  walls.add(new Wall(1400, 300, 50, 250));
  walls.add(new Wall(1600, 100, 50, 250));
  walls.add(new Wall(1800, 100, 50, 250));
  walls.add(new Wall(2600, 100, 50, 250));
  walls.add(new Wall(2800, 250, 50, 550));
  walls.add(new Wall(4175, 575, 50, 250));
  walls.add(new Wall(4175, 325, 50, 250));
  walls.add(new Wall(4175, 75, 50, 250));

  //init void killbox
  kb = new KillBox(-1200, 1000, 24000, 50);

  //init winbox
  wb = new WinBox(4000, 800, 500, 500);

  //create player----------------------------------------------
  player = new Player(this);

  //create ninks
  ninks.add(new Nink(this, 900, 200, true));
  ninks.add(new Nink(this, 2200, -50, false));
  ninks.add(new Nink(this, 1400, -50, false));


  //create stars ---------------------------------------
  stars.add(new Star(this, 100, 350));
  stars.add(new Star(this, 300, 350));
  stars.add(new Star(this, 1480, 130));
  stars.add(new Star(this, 1700, -70));
  stars.add(new Star(this, 2200, -70));
  stars.add(new Star(this, 2900, 430));
  stars.add(new Star(this, 3700, 655));

  //music
  gameMusic = new SoundFile(this, "levelMusic.mp3");

  //add to world
  world.add(player);
  world.add(kb);
  world.add(wb);

  //add all platforms to world
  for (Platform p : platforms) {
    world.add(p);
  }

  //add all walls to world
  for (Wall w : walls) {
    world.add(w);
  }

  //add all ninks to world
  for (Nink n : ninks) {
    world.add(n);
  }

  //add all stars to world
  for (Star s : stars) {
    world.add(s);
  }
}


void draw() {
  background(255);

  println(player.getX(), player.getY());
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


    //draw all platforms
    for (Platform p : platforms) {
      p.drawPlatform();
    }

    //draw all walls
    for (Wall w : walls) {
      w.drawWall();
    }

    //draw and update all ninks
    for (int i = 0; i < ninks.size(); i++) {
      Nink n = ninks.get(i);
      n.drawNink();
      n.updateNink();

      if (!n.alive) {
        ninks.remove(n);
        world.remove(n);
      }
    }

    //draw and update all stars
    for (int i = 0; i < stars.size(); i++) {
      Star s = stars.get(i);

      if (!s.alive) {
        stars.remove(i);
        world.remove(s);
      } else {
        s.drawStar();
        s.updateStar();
      }
    }

    //music
    if (!gameMusic.isPlaying()) {
      gameMusic.loop();
    }

    //draw and update player
    player.drawPlayer();
    player.updatePlayer();

    //check ifplayer has won

    if (player.win) {
      gameState = 2;
      player.walk.pause();
      gameMusic.pause();
    }

    //draw score counter
    fill(0);
    textSize(20);
    text("Score: " + str(player.score), 400, 20);
  }


  //you win! screen
  if (gameState == 2) {
    if (!goodEndMusic.isPlaying()) {
      goodEndMusic.play();
    }
    imageMode(CENTER);
    goodEnd.resize(500, 500);
    image(goodEnd, 250, 250);
  }

  //you lose! screen
  if (gameState == 3) {


    if (gameMusic.isPlaying()) {
      gameMusic.pause();
    }

    imageMode(CENTER);
    badEnd.resize(500, 500);
    image(badEnd, 250, 250);
    if (!badEndMusic.isPlaying()) {
      badEndMusic.loop();
    }

    if (mousePressed) {
      badEndMusic.pause();
      gameState = 0;
      player.lives = 3;
      player.setPosition(100, 0);
      player.setVelocity(0, 0);
      imageMode(CORNER);
    }
  }
}

void checkGameOver() {
  if (player.lives <= 0) {
    gameState = 3;
  }
}
