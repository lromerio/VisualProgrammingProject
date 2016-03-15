void settings() {
  fullScreen(P3D);
}
void setup() {
  noStroke();
}

//Variables
  float angleX = 0;
  float angleZ = 0;
  float speed = 1;
//Mouse coordinates
  float previousY = mouseY;
  float previousX = mouseX;

void draw() {
background(96, 96, 96);
  directionalLight(229, 255, 204, 0, 1, -1);
  ambientLight(102,102,102);
  translate(width/2, height/2, 0);
  rotateX(angleX);
  rotateZ(angleZ);
  fill(0, 255, 0);
  box(450, 20, 450);
}

void mouseDragged() 
{
  if (previousX > mouseX && angleZ >= -PI/3) {
    angleZ -= max((PI/60)*speed, -PI/3);
  } else if (previousX < mouseX && angleZ <= PI/3) {
    angleZ += min((PI/60)*speed, PI/3);
  }
  previousX = mouseX;

  if (previousY < mouseY && angleX >= -PI/3) {
    angleX -= max((PI/60)*speed, -PI/3);
  } else if (previousY > mouseY && angleX <= PI/3) {
    angleX += min((PI/60)*speed, PI/3);
  }
  previousY = mouseY;
}

float bound(float val){
  if(val<0.2){
    return 0.2;
  } else if(val>1.5){
    return 1.5;
  } else return val;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  speed = (e>0)? bound(speed+0.1) : bound(speed-0.1);
}