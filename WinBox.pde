class WinBox extends FBox {
  
  WinBox(int x, int y, int w, int h) {
    super(w, h);
    
    setPosition(x, y);
    setGrabbable(false);
    setRotatable(false);
    setSensor(true);
    setStatic(true);
    setName("winbox");
  }
}
