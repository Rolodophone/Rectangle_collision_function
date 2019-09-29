class Rect {
  float x, y, z, w, h, left, right, top, bottom;
  color c;
  String name;
  
  boolean beingDragged = false;
  
  Rect(float x, float y, float z, float w, float h, color c, String name) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.c = c;
    this.name = name;
  }
  
  void update() {
    if (beingDragged) {
      x += mouseX - pmouseX;
      y += mouseY - pmouseY;
    }
    
    display();
    
    left    = x;
    right   = x+w;
    top     = y;
    bottom  = y+h;
  }
  
  void display() {
    fill(c);
    if (SHOW_RECTS) {
      rect(x, y, w, h);
      
    } else {
      pushStyle();
      if (name == "base") {
        noFill();
        rect(x, y, w, h);
        
      } else {
        noStroke();
        circle(x, y, 5);
      }
      popStyle();
    }
    
    if (SHOW_DEBUG) {
      fill(0);
      text(name, x+3, y+12);
    }
  }
  
  boolean mouseIsOver() {
    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
      return true;
    } else {
      return false;
    }
  }
}



//custom comparator for finding rect with largest z value
public class RectZComparator implements Comparator<Rect> {
  @Override
  public int compare(Rect o1, Rect o2) {
    return int(o1.z - o2.z);
  }
}
