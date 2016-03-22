  
/**
 *  This class modelizes the ball. It has attributes to keep track of its movement variables 
 *  and it's characteristics (dimentions, color, sounds, ...)
 *  
 *  @r            The radius of the ball, used to draw it each time. It's a float.
 *  @location     A PVector that stores the current position of the ball in the space, relative to the center of the plane.
 *  @velocity     A PVector that stores the current velocity of the ball
 */
class Ball {

//_______________________________________________________________
//Attributes  
  AudioSample boing;
  float normalForce;
  float mu;  
  float frictionMagnitude;
  PVector friction;
  float r;
  PVector location;
  PVector velocity;
  PVector gravity;

//_______________________________________________________________
//Functions
  Ball(float r) {
    this.location = new PVector(0, 0, 0);
    this.r = r;
    velocity = new PVector(0, 0, 0);
    gravity = new PVector(0, 0, 0);
    mu = 0.6;
    normalForce = 1;
    boing = minim.loadSample("LaserBlasts.mp3");
  }

  void update() {
    gravity.x = sin(plane.angleZ) * environment.g;
    gravity.z = -sin(plane.angleX) * environment.g;

    frictionMagnitude = normalForce * mu;
    friction = velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(frictionMagnitude);

    velocity.add(gravity);
    velocity.add(friction);
    location.add(velocity);

    if (location.x > plane.boardEdge/2) {
      location.x = plane.boardEdge/2;
      velocity.x *= -1; 
      boing.trigger();
    } else if (location.x < -plane.boardEdge/2) {
      location.x = -plane.boardEdge/2;
      velocity.x *= -1; 
      boing.trigger();
    }
    if (location.z > plane.boardEdge/2) {
      location.z = plane.boardEdge/2;
      velocity.z *= -1; 
      boing.trigger();
    } else if (location.z < -plane.boardEdge/2) {
      location.z = -plane.boardEdge/2;
      velocity.z *= -1; 
      boing.trigger();
    }
  
  }

  void display() {
    pushMatrix();
    rotateX(plane.angleX);
    rotateZ(plane.angleZ);
    translate(location.x, -r - (plane.boardThick/2), location.z);
    fill(255, 102, 102);
    sphere(r);
    popMatrix();
  }
}