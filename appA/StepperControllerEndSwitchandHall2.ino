// Stepper controller, V. Ziemann, 181201
#include <Stepper.h>
//                     a  b  c  d
Stepper myStepper(200, 4, 5, 6, 7);
char line[30];
volatile int steps=0;
void setup() {
  myStepper.setSpeed(60);
  Serial.begin (9600); while (!Serial) {;} 
  pinMode(8,OUTPUT);
  digitalWrite(8,LOW); // Enable pin
  pinMode(2,INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(2),homepos,FALLING);
}
void loop() {
  if (Serial.available()) {
    Serial.readStringUntil('\n').toCharArray(line,30);
    if (strstr(line,"MOVE ")) {   
      steps=(int)atof(&line[5]);
      Serial.print("STEPS = "); Serial.println(steps);
      Serial.println(digitalRead(2));
      if ((digitalRead(2)==1) | (digitalRead(2)==0) & (steps<0)) {
        Serial.println("qq");
        digitalWrite(8,HIGH); // enable output
        delay(200);
        digitalWrite(13,LOW); // turn limit switch indicator off
        Serial.print("MOVE = "); Serial.println(steps);
        myStepper.step(steps);
      }
    } else if (strstr(line,"B?")) {
      float B=(5.0*analogRead(1)/1023-2.4)/1.3e-3;
      Serial.print("B "); Serial.println(B);
    } else if (strstr(line,"HOME")) {
      if (digitalRead(2) == 1) {
        digitalWrite(8,HIGH); // enable output
        delay(200); 
        steps=200; myStepper.step(steps); 
      }
    } else if (strstr(line,"SCAN?")) {  
      if (digitalRead(2) == 1) {  // move to home position
        digitalWrite(8,HIGH);     // enable output
        delay(200); steps=200; myStepper.step(steps); 
        delay(200);
      }
      Serial.println("SCAN");
      digitalWrite(8,HIGH); 
      for (int i=0;i<150;i++) {
        steps=-1; myStepper.step(steps); 
        delay(100);
        float B=1e-4*(5.0*analogRead(1)/1023-2.4)/1.3e-3;
        Serial.println(B,4);
      }
    } 
    digitalWrite(8,LOW);
  }
}
void homepos() {
  if (steps>0) { digitalWrite(8,LOW);}  // disable output
  digitalWrite(13,HIGH);
}

