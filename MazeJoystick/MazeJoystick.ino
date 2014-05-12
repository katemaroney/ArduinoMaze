/* Read Jostick
  * ------------
  *
  * Reads two analog pins that are supposed to be
  * connected to a jostick made of two potentiometers
  *
  * We send three bytes back to the comp: one header and two
  * with data as signed bytes, this will take the form:
  *     Jxy\r\n
  *
  * x and y are integers and sent in ASCII 
  * 
  * http://www.0j0.org | http://arduino.berlios.de
  * copyleft 2005 DojoDave for DojoCorp
  */
 int joyPin1 = 0;                 // slider variable connecetd to analog pin 0
 int joyPin2 = 1;                 // slider variable connecetd to analog pin 1
 int value1 = 0;                  // variable to read the value from the analog pin 0
 int value2 = 0;                  // variable to read the value from the analog pin 1
 
 int val1 = 4; // default direction for joystick
 int val2 = 4;
 boolean canMove = true;
 void setup() {  
   // initializes digital pins 0 to 7 as outputs
  Serial.begin(9600);
  Serial.print("Hello");
 }

 int treatValue(int data) {
  return (data * 9 / 1024) + 48;
 }

 void loop() {
  // reads the value of the variable resistor 
  value1 = analogRead(joyPin1);   
  // this small pause is needed between reading
  // analog pins, otherwise we get the same value twice
 //delay(100);             
  // reads the value of the variable resistor 
  value2 = analogRead(joyPin2);   
      
  //delay(value1);
 // delay(value2);
 if (!canMove && treatValue(value1) - 48 == 4 && treatValue(value2) - 48 == 4){
  canMove = true; 
 }
  if (canMove){
    if (treatValue(value1) - 48 == 8){
      Serial.println(2); // up
      canMove = false;
    }
    if (treatValue(value1) - 48 == 0){
      Serial.println(0); // down
      canMove = false;
    }
    if (treatValue(value2) - 48 == 0){
      Serial.println(3); // right
      canMove = false;
    }
    if (treatValue(value2) - 48 == 8){
      Serial.println(1); // left
      canMove = false;
    }
  }
    //while(!(treatValue(value1) - 48 == 4 && treatValue(value2) - 48 ==4)){
    //  value1 = analogRead(joyPin1);
    //  value2 = analogRead(joyPin2);
    //}
 }
