import java.util.Collections;
import java.util.Comparator;

final int RECT_WIDTH = 100;
final int RECT_HEIGHT = 75;
final int BASE_WIDTH  = 400;
final int BASE_HEIGHT = 300;
 
final boolean SHOW_DEBUG = true;
final boolean SHOW_RECTS = true;

Rect baseRect;
Rect initialRect;
Rect finalRect;

Rect[] rectList;

void setup() {
  size(1040, 780);
  
  baseRect    = new Rect(320, 240, 0, BASE_WIDTH, BASE_HEIGHT,  color(100), "base");
  initialRect = new Rect(910, 30, 1,  RECT_WIDTH, RECT_HEIGHT,  color(50, 50, 100), "initial");
  finalRect   = new Rect(670, 400, 2, RECT_WIDTH, RECT_HEIGHT,  color(10, 10, 200), "final");
  
  rectList = new Rect[] {baseRect, initialRect, finalRect};
} //<>//


void draw() { //<>//
  background(255); //<>//
  
  baseRect.update();
  initialRect.update();
  finalRect.update();
  
  Collision entrance = findEntranceCheckForTunnelling(initialRect.x, initialRect.y, finalRect.x, finalRect.y, RECT_WIDTH, RECT_HEIGHT, baseRect.x, baseRect.y, BASE_WIDTH, BASE_HEIGHT);
  boolean collided = hasCollided(finalRect.x, finalRect.x+RECT_WIDTH, finalRect.y, finalRect.y+RECT_HEIGHT, baseRect.x, baseRect.x+BASE_WIDTH, baseRect.y, baseRect.y+BASE_HEIGHT);
  
  if (collided){
    fill(0);
    text("collided yes", 300, 200);
  }
  
  if (entrance != null) {
    fill(53, 123, 60);
    if (SHOW_RECTS) {
      rect(entrance.x, entrance.y, RECT_WIDTH, RECT_HEIGHT);
      
    } else {
      pushStyle();
      noStroke();
      circle(entrance.x, entrance.y, 5);
      popStyle();
    }
    
    if (SHOW_DEBUG) {
      fill(0);
      text("("+entrance.x+", "+entrance.y+"), "+entrance.side, entrance.x, entrance.y-3);
      line(entrance.x, entrance.y, initialRect.x, entrance.y);
      line(entrance.x, entrance.y, entrance.x, finalRect.y);
    }
  }
  
  if (SHOW_DEBUG) {
    fill(0);
    line(initialRect.x, initialRect.y, initialRect.x, finalRect.y);
    line(finalRect.x, finalRect.y, initialRect.x, finalRect.y);
    line(initialRect.x, initialRect.y, finalRect.x, finalRect.y);
    text("("+initialRect.x+", "+initialRect.y+")", initialRect.x, initialRect.y-3);
    text("("+finalRect.x  +", "+finalRect.y  +")", finalRect.x, finalRect.y-3);
  }
} //<>//
