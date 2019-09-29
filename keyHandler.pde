//set mousePressed to true if rect is pressed
void mousePressed() {
  //find rects which the mouse is over and add their z values to dict
  ArrayList<Rect> mouseOverRects = new ArrayList<Rect>();
  for (Rect rect : rectList) {
    if (rect.mouseIsOver()) {
      mouseOverRects.add(rect);
    }
  }
  
  if (!mouseOverRects.isEmpty()) {
    //find rect with largest z value
    Collections.max(mouseOverRects, new RectZComparator())
    //enable dragging
    .beingDragged = true;
  }
}


void mouseReleased() {
  for (Rect rect : rectList) {
    rect.beingDragged = false;
  }
}
