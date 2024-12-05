class Wall extends FBox {
  PImage[] idle;
  int frame = 0;
  
  int wid;
  int hei;

  Wall(int x, int y, int w, int h) {
    super(w, h);
    setPosition(x, y);
    setStatic(true);
    setFriction(18);
    setGrabbable(false);
    setName("Wall");
    wid = w;
    hei = h;

    idle = new PImage[2];
    idle[0] = loadImage("wall1.png");
    idle[1] = loadImage("wall2.png");
  }

  void drawWall() {
    if (frameCount % 8 == 0) {
      frame = (frame + 1) % idle.length;
    }

    idle[frame].resize(wid, hei);
    attachImage(idle[frame]);
  }
}
