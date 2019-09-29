/**
 * Data class for storing data about collisions
 * 
 * @param ×     x coordinate of left of collision point
 * @param y     y coordinate of right of collision point
 * @param s     the side that the collision took place on
 */
final public class CollisionOld {
  float x, y;
  String side;
  
  public CollisionOld(Float x, Float y, String s) {
    this.x = x;
    this.y = y;
    this.side = s;
  }
}




/**
 * Finds the entrance point of a rect-rect collision using ray-casting. All coordinates are from bottom left.
 * 
 * @param ix   x coordinate of rectangle in previous frame
 * @param iy   y coordinate of rectangle in previous frame
 * @param fx   x coordinate of rectangle in current frame
 * @param fy   y coordinate of rectangle in current frame
 * @param w    width of rectangle
 * @param h    height of rectangle
 * @param bx   x coordinate of other rectangle
 * @param by   y coordinate of other rectangle
 * @param bw   width of other rectangle
 * @param bh   height of other rectangle
 *  //<>//
 * @return Collision: Collision class containing data about the collision
 */
public Collision findEntranceCheckForTunnellingOld(float ix, float iy, float fx, float fy, float w, float h, float bx, float by, float bw, float bh) {
  //--------SET UP VARS--------------
  //bl means base left
  float bl = bx;
  float br = bx + bw;
  float bt = by;
  float bb = by + bh;
  
  //An array of the entrance and exit of the ray
  ArrayList<float[]> contacts = new ArrayList<float[]>();
  
  //result vars
  Float resultX = null;
  Float resultY = null;
  String resultSide = null;
  
  
  
  //---------ADD CONTACT POINTS TO THE ARRAY-------------
  float lContactX = bl-w; //<>//
  Float lContactY = computePointOld(ix, fx, lContactX, iy, fy, false);
  if (lContactY != null && lContactY+h > bt && lContactY < bb) {
    contacts.add(new float[] {lContactX, lContactY});
    resultSide = "left";
  }
  
  float rContactX = br;
  Float rContactY = computePointOld(ix, fx, rContactX, iy, fy, true);
  if (rContactY != null && rContactY+h > bt && rContactY < bb) {
    contacts.add(new float[] {rContactX, rContactY});
    resultSide = "right";
  }
  
  float tContactY = bt-h;
  Float tContactX = computePointOld(iy, fy, tContactY, ix, fx, false);
  if (tContactX != null && tContactX+w > bl && tContactX < br) {
    contacts.add(new float[] {tContactX, tContactY});
    resultSide = "top";
  }
  
  float bContactY = bb;
  Float bContactX = computePointOld(iy, fy, bContactY, ix, fx, true);
  if (bContactX != null && bContactX+w > bl && bContactX < br) {
    contacts.add(new float[] {bContactX, bContactY});
    resultSide = "bottom";
  }
  
  
  
  
  //---------POSSIBLE SHORTCUTS------------
  //ensure that there is at least 1 contact point
  if (contacts.size() == 0) return null;
  
  //if only one contact point there's no need for comparison
  //else if (contacts.size() == 1) return contacts.get(0);
  
  
  
  
  
  ////-----------RETURN THE ENTRANCE POINT FROM THE CONTACTS ARRAY--------------
  assert (contacts.size() == 1);
  resultX = contacts.get(0)[0];
  resultY = contacts.get(0)[1];
  
  //I'm pretty sure the code below isn't needed but I'll keep it here in case it is:
  
  //float diff = fx - ix;
  
  //if (diff > 0) { // looking for largest x
  //  if (contacts.get(1)[0] > contacts.get(0)[0]) return contacts.get(1);
  //  else return contacts.get(0);
  //}
  
  //else if (diff < 0) { // looking for smallest x
  //  if (contacts.get(1)[0] < contacts.get(0)[0]) return contacts.get(1);
  //  else return contacts.get(0);
  //}
  
  //else {
  //  diff = fy - iy;
    
  //  if (diff > 0) { // looking for largest y
  //    if (contacts.get(1)[1] > contacts.get(0)[1]) return contacts.get(1);
  //    else return contacts.get(0);
  //  }
    
  //  else if (diff < 0) { // looking for smallest y
  //    if (contacts.get(1)[1] < contacts.get(0)[1]) return contacts.get(1);
  //    else return contacts.get(0);
  //  }
    
  //  else return null;
  //}
  
  
  //return Collision obj
  return new Collision(resultX, resultY, resultSide);
}



final static private Float computePointOld(float ix, float fx, float cx, float iy, float fy, boolean distShouldBePositive) {
  float xDist = ix - fx; // the distance between ix and fx
  
  //perform checks in case of no collision
  if (xDist == 0) return null;
  if (distShouldBePositive) {
    if (xDist < 0) return null;
  } else {
    if (xDist > 0) return null;
  }
  
  //calculation
  float xFrac = (ix-cx) / xDist; // the fraction ix to cx, out of the whole x distance
  if (xFrac >= 1 || xFrac <= 0) return null; // if xFrac > 1, that means contactRect is not between initialRect and finalRect, so there is no collision
  
  float yDist = (fy-iy) * xFrac; // times the distance fy to iy by the same fraction to get the y distance from iy to cy
  
  float cy = iy + yDist; // Add that distance to iy to get cy
  
  return cy;
}
