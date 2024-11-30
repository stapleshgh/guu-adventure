class Platform extends FBox {
  PImage[] idle;
  int frame = 0;
  
  int wid;
  int hei;

  Platform(int x, int y, int w, int h) {
    super(w, h);
    setPosition(x, y);
    setStatic(true);
    setFriction(18);
    setGrabbable(false);
    wid = w;
    hei = h;

    idle = new PImage[2];
    idle[0] = loadImage("platform1.png");
    idle[1] = loadImage("platform2.png");
  }

  void drawPlatform() {
    if (frameCount % 8 == 0) {
      frame = (frame + 1) % idle.length;
    }

    idle[frame].resize(wid, hei);
    attachImage(idle[frame]);
  }
}
