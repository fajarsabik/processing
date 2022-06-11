float k=0;
int cube_size=20;
int rotate_speed=10;
int dist=85;
int gray_value=110;
void setup () {
  size(540, 360, P3D);
}
void draw() {
  background(0);
  translate(width/2, height/2, 0);
  scale(2);
  stroke(255);
  fill(210);
  line(-40-dist,0,0,40-dist,0,0);
  line(0,-40,0,0,40,0);
  line(dist,0,-40,dist,0,40);
  draw_cube(-1*dist,0);
  draw_cube(0,1);
  draw_cube(dist,2);
  k=k+(0.01*rotate_speed);
}
void draw_cube(float beg_x, int rotate_xyz) {
  fill(gray_value);
  pushMatrix();
  if(rotate_xyz==0) {translate(beg_x,0,0); rotateX(k);}
  if(rotate_xyz==1) {translate(beg_x,0,0);rotateX(-0.2); rotateY(k);}
  if(rotate_xyz==2) {translate(beg_x,0,0); rotateZ(k);}
  box(cube_size);
  popMatrix();
}
