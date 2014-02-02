import oscP5.*;
import netP5.*;

OscP5 oscP5;
TriangleSystem ts;
CircleSystem cs;
LineSystem ls;
boolean refresh = true;

//picture stuff (should be made into objects later)
PImage one, two, three, four;
float pointillize = 80;
float grainOne, grainTwo, grainThree, grainFour;


NetAddress myBroadcastLocation;

float backgroundColor = 255;

void setup(){
  size(displayWidth, displayHeight);
  background(backgroundColor);
  smooth();
  noCursor();
  
  //FOCUS ATTENTION HERE
  one = loadImage("mountain.jpg");
  one.resize(displayWidth, displayHeight);
  two = loadImage("snowymountain.jpg");
  two.resize(displayWidth, displayHeight);
  three = loadImage("field.jpg");
  three.resize(displayWidth, displayHeight);
  four = loadImage("meadow.jpg");
  four.resize(displayWidth, displayHeight);
  
  
  ts = new TriangleSystem();
  ls = new LineSystem();
  cs = new CircleSystem();
  
  //creating an instance of oscP5, listening at port 12000.
  oscP5 = new OscP5(this,12000);
  
  //creating a netaddress that can be used to send OSC.
  myBroadcastLocation = new NetAddress("127.0.0.1",32000);
}

void draw(){
    if (refresh == true) {
      background(backgroundColor);
      ts.run();
      cs.run();
      ls.run();
    }
    
    else{
    }
    
}

void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/csound/circ")==true){
      cs.addCircle();
  }
  if(theOscMessage.checkAddrPattern("/csound/line")==true){
    ls.addLine();
  }
  if(theOscMessage.checkAddrPattern("/csound/tri")==true){
    ts.addTriangle();
  }
  if(theOscMessage.checkAddrPattern("/csound/drumone")==true){
    grainOne = theOscMessage.get(0).floatValue();
    grainOne = grainOne * 300;
    int x = int(random(one.width));
    int y = int(random(one.height));
    color pix = one.get(x, y);
    noStroke();
    fill(pix, 120);
    ellipse(x, y, grainOne, grainOne);
  }
  if(theOscMessage.checkAddrPattern("/csound/drumtwo")==true){
    grainTwo = theOscMessage.get(0).floatValue();
    grainTwo = grainTwo * 300;
    int x2 = int(random(two.width));
    int y2 = int(random(two.height));
    color pix2 = two.get(x2, y2);
    noStroke();
    fill(pix2, 120);
    rect(x2, y2, grainTwo, grainTwo);
  }
  if(theOscMessage.checkAddrPattern("/csound/drumthree")==true){
    grainThree = theOscMessage.get(0).floatValue();
    grainThree = grainThree * 300;
    int x3 = int(random(three.width));
    int y3 = int(random(three.height));
    color pix3 = three.get(x3, y3);
    noStroke();
    fill(pix3, 120);
    rect(x3, y3, grainThree, grainThree);
  }
  if(theOscMessage.checkAddrPattern("/csound/drumfour")==true){
    grainFour = theOscMessage.get(0).floatValue();
    grainFour = grainFour * 300;
    int x4 = int(random(four.width));
    int y4 = int(random(four.height));
    color pix4 = four.get(x4, y4);
    noStroke();
    fill(pix4, 120);
    ellipse(x4, y4, grainFour, grainFour);
  }
  if(theOscMessage.checkAddrPattern("/csound/bgtrigger")==true){
    background(backgroundColor);
    if(refresh == true){
     refresh = false;
    }
    else{ 
      refresh = true;
    }
    println("bgtrigger worked.");
  }
  if(theOscMessage.checkAddrPattern("/csound/bgblack")==true){
    while(backgroundColor > 0){
      backgroundColor = backgroundColor - .1;
      background(backgroundColor);
    }
    if(backgroundColor < 0){
      backgroundColor = 0;
      background(backgroundColor);
    }
  }
}

/* Object Protoype
   Each class you create should extend from this prototype
   and contain at least these methods */
public class Shape{
  
  //Constructor: establish any variables the object will need
  //to function.
  Shape(){
   }
  
  //Any code required to put the object onto the screen
  void drawMe(){
  }
  
  //Any code that affects how the object changes from frame 
  //to frame. The condition used to test isDead() should be 
  //included here.
  void updateMe(){
  }
  
  //this function will update and draw the object on a frame by
  //frame basis.
  void run(){
    updateMe();
    drawMe();
  }
  
  //Checks to see if the object should still be on the screen.
  boolean isDead(){
    return false;
  }  
  
}

public class Triangle extends Shape {
  float x1,y1,x2,y2,x3,y3;
  color stroke;
  float alph;
  int counter;
  
  Triangle(){
    x1 = random(width);
    x2 = random(width);
    x3 = random(width);
    y1 = random(height);
    y2 = random(height);
    y3 = random(height);
    stroke = color(random(255), random(255), random(255));
    alph = 500;
  }
  
  void drawMe(){
    stroke(stroke,alph);
    strokeWeight(10);
    noFill();
    triangle(x1,y1,x2,y2,x3,y3);
  }
  
  void run(){
    updateMe();
    drawMe();
  }

  void updateMe(){
    if (x1>(width)){x1 = 0;}
    if(x1 <(0)){x1 = width;}
    if (y1>(height)){y1 = 0;}
    if(y1 <(0)){y1 = height;}
    if (x2>(width)){x2 = 0;}
    if(x2 <(0)){x2 = width;}
    if (y2>(height)){y2 = 0;}
    if(y2 <(0)){y2 = height;}
    if (x3>(width)){x3 = 0;}
    if(x3 <(0)){x3 = width;}
    if (y3>(height)){y3 = 0;}
    if(y3 <(0)){y3 = height;}
    alph -= 2;
    
    int i = round(random(0,2));
    if(i==0){
      x1 +=5;
      y1 -=5;
    }
    if(i==1){
      x2 -=5;
      y2 +=5;
    }
    if(i==2){
      x3 -=5;
      y3 -=5;
    }
  }
  
  boolean isDead() {
    if(alph<=0){
      return true;
    } else {
      return false;
    }
  }
}

public class Circle extends Shape {
  
  float x,y;
  float radius;
  color fillcol;
  float alph;
  float xmove, ymove;
  int counter;
  
  Circle(){
    x = random(width);
    y = random(height);
    radius = random(100)+10;
    fillcol = color(random(255), random(255), random(255));
    alph = random(100,255);
    xmove = random(10)-5;
    ymove = random(10)-5;
  }
  
  void drawMe(){
    noStroke();
    fill(fillcol, alph);
    ellipse(x, y, radius*2, radius*2);
  }
  
  void updateMe(){
    x += xmove;
    y += ymove;
    if (x>(width+radius)){x = 0 - radius;}
    if(x <(0-radius)){x = width+radius;}
    if (y>(height+radius)){y = 0 - radius;}
    if(y <(0-radius)){y = height+radius;}
    alph -= 0.9;
  }
  
  void run(){
    updateMe();
    drawMe();
  }
  
  boolean isDead(){
    if (alph <=0){return true;}
    else{return false;}
  }
  
}

public class Line extends Shape {
  float x1,y1,x2,y2;
  color stroke;
  float alph;
  float weight;
  int counter;
  
  Line(){
    x1 = random(width);
    x2 = random(width);
    y1 = random(height);
    y2 = random(height);
    stroke = color(random(255), random(255), random(255));
    alph = random(0,150);
    weight = random(20, 40);
  }
  
  void drawMe(){
    stroke(stroke, alph);
    strokeWeight(weight);
    line(x1,x2,y1,y2);
  }
  
 void updateMe(){
    x1 += random(-5,5);
    x2 += random(-5,5);
    y1 += random(-5,5);
    y2 += random(-5,5);
    alph -= 0.4;
  }
  
  void run(){
    updateMe();
    drawMe();
  }
  
  boolean isDead(){
    if(alph<=0){return true;}
    else{return false;}
  }
  
}


class CircleSystem {
  ArrayList<Circle> circles;
  
  CircleSystem(){
    circles = new ArrayList<Circle>();
  }

  void addCircle() {
    circles.add(new Circle());
  }
  
  void run() {
    for (int i = circles.size()-1; i>=0; i--){
      Circle c = circles.get(i);
      c.run();
      if (c.isDead()){
        circles.remove(i);
      }
    }
  }
  
}

class LineSystem {
  ArrayList<Line> lines;
  
  LineSystem(){
   lines = new ArrayList<Line>();
  }

  void addLine() {
    lines.add(new Line());
  }
  
  void run() {
    for (int i = lines.size()-1; i>=0; i--){
    Line l = lines.get(i);
    l.run();
    if (l.isDead()){
      lines.remove(i);
    }
    }
  }
}

class TriangleSystem {
  ArrayList<Triangle> triangles;
  
  TriangleSystem(){
    triangles = new ArrayList<Triangle>();
  }

  void addTriangle() {
    triangles.add(new Triangle());
  }
  
  void run() {
    for (int i = triangles.size()-1; i>=0; i--){
      Triangle t = triangles.get(i);
      t.run();
      if (t.isDead()){
        triangles.remove(i);
      }
    }
  }
}



