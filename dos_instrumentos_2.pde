import beads.*;

import processing.serial.*;

PFont f;

float i,volumen1,volumen2,volumen3;
float frec1,frec2;
int frecuencia,frecuencia1;

int serial_1,serial_2,serial_3,serial_4;
int flauta_1,flauta_2,flauta_3,flauta_4;

int lf = 48;

float barra_volumen;

Serial myPort;  // The serial port}

int verificador;

AudioContext ac,ac1;

SamplePlayer sp1;

Glide rateValue;

Glide frequencyGlide1;

Glide frequencyGlide2;

WavePlayer wp;

WavePlayer wp1;

// we can run both SamplePlayers through the same Gain
Gain g;
Gain g2;
Glide gainValue;
Glide gainValue2;

void setup(){
  // Sonido SONIDO!!
  
  ac = new AudioContext(); // create our AudioContext
  ac1 = new AudioContext();
  

  frequencyGlide1 = new Glide(ac, 20, 50);
  frequencyGlide2 = new Glide(ac1, 20, 50);

  wp = new WavePlayer(ac, frequencyGlide1, Buffer.SINE);
  wp1 = new WavePlayer(ac, frequencyGlide2, Buffer.SINE);
  
  // as usual, we create a gain that will control the volume of our sample player
  gainValue = new Glide(ac, 0.0, 50);
  gainValue2 = new Glide(ac1, 0.0, 50);
  g = new Gain(ac, 1, gainValue);
  g2 = new Gain(ac1, 1, gainValue2);
  
  g.addInput(wp);
  g2.addInput(wp1);
  
  ac.out.addInput(g);
  ac1.out.addInput(g2);
  
  ac.start(); // begin audio processing
  
  // Dibujo de la Ventana //
  
  size(800,600); // tamaño de la ventana
  background(0); // color de fondo
  stroke(255);
  f = createFont("Papyrus",20,true); // letra
  textFont(f,35);
  line(width/2,0,width/2,height);
  text("Armónica:", width/5-20,height/15);
  text("Fláuta:", (width*3/4)-30,height/15);
  textFont(f,18);
  text("Volumen:",50,100);
  text("Volumen:",450,100);
  text("Velocidad:",50,250);
  text("Velocidad:",450,250);
  fill(255);
  rect(50,150,300,20);
   
  // // List all the available serial ports
  println(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[1], 115200);
  myPort.bufferUntil(32);
  
}

void draw(){
      background(0);
        background(0); // color de fondo
  stroke(255,255,255);
  f = createFont("Papyrus",20,true); // letra
  textFont(f,35);
  line(width/2,0,width/2,height);
  text("Armónica:", width/5-20,height/15);
  text("Fláuta:", (width*3/4)-30,height/15);
  textFont(f,18);
  text("Volumen:",50,100);
  text("Volumen:",450,100);
  text("Velocidad:",50,250);
  text("Velocidad:",450,250);
  fill(255);
  rect(50,150,300,20);
      //println(serial_1);
     // Recepción de Amplitud MICROFONO!!!!
      //int medio=serial_2-101;
      volumen1=(float)(serial_2-97)/100;
      i=volumen1*200;
      //println(serial_2);
      //Dibujar Volumen de armonica Variable
      fill(255);
      rect(50,150,300,20);
      fill(0,0,255);
      rect(50,150,i,20);
      gainValue.setValue(volumen1);


      // Prueba SAPA!!!
    
      frec1=(float)(serial_3-112)/112;
      frecuencia=serial_3*10;
      frequencyGlide1.setValue(frecuencia); 
      i=frec1*250;
      
      //println(serial_3); 
      //Dibujar Velocidad de Armónica Variable
      fill(255);
      rect(50,300,300,20);
      fill(0,0,255);
      rect(200,300,i,20);
           

      volumen2=(float)(flauta_2)/255;
      i=volumen2*300;
      volumen3=volumen2*10;
      gainValue2.setValue(volumen3);
      //println(serial_2);
      //Dibujar Volumen de armonica Variable
      fill(255);
      rect(450,150,300,20);
      fill(0,0,255);
      rect(450,150,i,20);
      //gainValue.setValue(volumen1); 

      // Prueba SAPA!!!
    
      frec2=(float)(flauta_3-112)/112;
      frecuencia1=(flauta_3+10)*10;
      frequencyGlide2.setValue(frecuencia1);
      i=frec2*250;
      
      //println(serial_3); 
      //Dibujar Velocidad de Armónica Variable
      fill(255);
      rect(450,300,300,20);
      fill(0,0,255);
      rect(600,300,i,20);
      
      

}


void serialEvent(Serial p) {
serial_1=myPort.read();
if(serial_1==15){
serial_2=myPort.read();
serial_3=myPort.read();
serial_4=myPort.read();
myPort.clear();
}
if(serial_1==12){
  flauta_2=myPort.read();
  flauta_3=myPort.read();
  flauta_4=myPort.read();
}
else myPort.clear();
println(myPort.available());
}


void mousePressed(){
  sp1.setPosition(000); // set the start position to the beginning
 sp1.start(); // play the audio file  
}
