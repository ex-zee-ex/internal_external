/*yeah so you gots to match up some numbers with your external camera and the camera array stuff
check the "getting started with capture" sketch thing that comes
with the video library if need be
also definitely use a midi controller with knobs for control
it makes a world of diference


*/

import themidibus.*; //Import the library
MidiBus myBus;
import processing.video.*;
int sw1,sw2,sw3;
PImage screen;

Capture cam1;
int cs=4;//change this value to a higher integer if its not going fast enough


//int sw1,sw2,sw3;//i always mispell swtich bc its like reserved in java
float tt,yy,qq,ww,ee,rr,dd,ff,uu,ii;
int cols,rows;
int[] readpixels;
float ss;
//int[] cam2pixels;
float a2,theta;
//float p=1;
void setup() {
 size(640, 480,P3D);

  colorMode(HSB,100);
  MidiBus.list();
  myBus = new MidiBus(this, 0, -1);
 
 rectMode(CENTER);
noCursor();
  String[] cameras = Capture.list();
 

 
   println("Available cameras:");
   printArray(cameras);

   
     cam1 = new Capture(this, cameras[18]);
    
  
    
   
    cam1.start();
    

 readpixels=new int[2*width*height];
 noSmooth();
 background(0);
 
 
 
 
 yy=1;
}

void draw() {
 
   // saveFrame("read.tif");   
  screen=loadImage("read.tif");
   for(int i=1;i<width*height;i++){
   readpixels[i]=screen.pixels[i];
   }//grabbingone pixelarray

  if (cam1.available() == true) {
    cam1.read();
   
    cam1.loadPixels();
   
  
   
  }//endifcam1available
  
  

 
 
 
 

 
  
 
    for (int i = 1; i < cam1.height/cs-1; i++) {
   
    
      for (int j = 1; j < cam1.width/cs-1; j++) {
      
        // Where are we, pixel-wise?
        int x = j*cs;
        int y = i*cs;
        int loc = (cam1.width + x - 1) + y*cam1.width;
        int loc2 = (screen.width + x - 1) + y*screen.width;
   
        
        float h1=(hue(cam1.pixels[loc])*(1+uu))%100;
        if(sw3==1){h1=100-h1;}
        float s1=(saturation(cam1.pixels[loc])*(1+tt))%100;
          if(sw2==1){s1=100-s1;}
        float b1=(brightness(cam1.pixels[loc])*(1+yy))%100;
        if(sw1==1){b1=100-b1;}
        float a1=b1;
        
        
        float h2=hue(readpixels[loc]);
        float s2=saturation(readpixels[loc])*2;
        float b2=brightness(readpixels[loc2]);
        float a2=b2;
      
        pushMatrix();
       
       noStroke();
  
        
       //translate(x,y,0);
    fill(h1,s1,b1,a1);
       rect(x,y,cs,cs);
      fill(h2,s2,b2,a2);
      float cs2=(100-b1)/50.0*cs*(1+2*qq);
      rect(x,y,cs2,cs2);
        popMatrix();
        
        
       
       
       
        
        
        
      }//endjfor
      
      
    }//endifor
    
   
  
 
  
  
  
 
 
    
    
    
    //theta+=.001;
  
 saveFrame("read.tif");    
 
    if(keyPressed){
    if(key=='1'){sw1=1;}
   if(key=='2'){sw2=1;}
   if(key=='3'){sw3=1;}
  // if(key=='4'){sw4=1;}
  // if(key=='5'){sw5=1;}
  // if(key=='6'){sw6=1;}
   if(key=='q'){sw1=0;}
   if(key=='w'){sw2=0;}
   if(key=='e'){sw3=0;}
 //  if(key=='r'){sw4=0;}
  // if(key=='t'){sw5=0;}
  // if(key=='y'){sw6=0;}
    
    if(key=='s'){ss+=10;}
    if(key=='x'){ss-=10;}
     if(key=='d'){dd+=.010;}
    if(key=='c'){dd-=.010;}
     if(key=='f'){ff+=.010;}
    if(key=='v'){ff-=.010;}
    }//endifkeypressed
}//enddraw


void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
 
 
 //if you don't know what the cc numbers of yr midi controller is 
 //uncomment the chunk below and run the sketch and write down the 'value' for each knob as u turn it
 
 
 /*
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  */
  
  
  /*
  if(number==16){
  xn=(value)/127.0*screen.width/2;

 // println("x="+x);
  }
  if(number==17){
  yn=(value)/127.0*screen.height/2;
  println(yn);

  //println("x="+x);
  }
  
*/
    if(number==27){
  qq=(value-63)/63.0;

  //println("x="+qq);
  }
   if(number==26){
  ww=(value-63)/63.0;

  //println("x="+x);
  }
   if(number==25){
  ee=(value-63)/63.0;

  //println("x="+x);
  }
  
   if(number==24){
  rr=(value-63)/63.0;
  //println("x="+x);
  }
  
  
   if(number==23){
 tt=(value-63)/63.0;

  //println("x="+x);
  }
  

  
  
   if(number==22){
 yy=(value-63)/63.0;

  
  }
  
  /*
  if(number==21){
 zn=.01*(value-63)/63.0*(dd);

  }
    if(number==20){
 uu=(value-63)*ff;//fine tune the scaling here
 if(uu==0){uu=.01*ff;};

  //println("x="+x);
  }
  /*
  if(number==20){
 skew=(value)*.1;

  }
  */
}//endcontrollerchange
