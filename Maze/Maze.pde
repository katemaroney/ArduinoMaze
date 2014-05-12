import processing.serial.*;
Serial port;
int val;

void setup(){
  frameRate(10);
  port = new Serial(this, 9600);
}

void draw(){
  if (0 < port.available()){
     val = port.read();
     println(val);
  }
}
