class Cube{
  float ellipseR = 150;
  float x;
  float[] colors = new float[3];
  float rectHeight = 25;
  float waveHeight = 15;
  float sqrWidth = 12;
  int Number;
  boolean isBeat;
PShape rectangle;
PShape circle;
 Cube(float xpos,int number){
   x = xpos;
   Number = number;
   // Make a group PShape
   if(number <36){
   circle = createShape(ELLIPSE,0, 0, ellipseR, ellipseR);
     circle.translate(width/2,height/2);
   }
  stroke(5);
  
  colors[0] = random(1,255);
  colors[1] = random(1,255);
  colors[2] = random(1,255);
 }
 
 void updateCircle(boolean beat){
   if(beat){
     isBeat = true;
     ellipseR += 15;
      fill(#1C7AFA);
   }
    else
    {
      isBeat = false;
      fill(#F0660A);
    }
    if(Number <37){
   circle = createShape(ELLIPSE,0, 0, ellipseR, ellipseR);
     circle.translate(width/2,height/2);
    }
 }
 
 void update(int Vheight){

  


   
 //fill( colors[0], colors[1], colors[2]);
   waveHeight = Vheight;
   if(Number <37){
    rectangle = createShape(RECT,ellipseR/2, 0, Vheight,sqrWidth);
    rectangle.translate(width/2,height/2);
    rectangle.rotate(radians(x));
   }
    if(isBeat)
     ellipseR -= 15;
    
 }

  
  void render(){
   rect(x,height -50,sqrWidth,-waveHeight); 
   strokeWeight(2);
   if(Number <37){
  shape(circle);
  shape(rectangle);
   }
  }
 }
  