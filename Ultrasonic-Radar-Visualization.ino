#include <Stepper.h>
#include <PingSerial.h>

int distance = 1;
int angle;
int ScanSpd = 5;

const int stepsPerRevolution = 32 * 64;

bool stop = false;

float stepsPerDegree = 5.6888888888888888888888888888889;

PingSerial us100(Serial1, 20, 600);
Stepper myStepper(stepsPerRevolution, 9, 11, 10, 8);

void setup() {
  Serial.begin(9600);
  us100.begin();
  stop = true;
  pinMode(5, OUTPUT);
  pinMode(6, INPUT_PULLUP);
  pinMode(13, OUTPUT);
  digitalWrite(13, LOW);
  digitalWrite(5, LOW);
}
void loop() {
  if (digitalRead(6) == LOW) {
    if (stop == false) {
      Serial.end();
      myStepper.setSpeed(10);
      myStepper.step(512);
      myStepper.setSpeed(ScanSpd);
      digitalWrite(13, HIGH);
      stop = true;
    }
  } else if (digitalRead(6) == HIGH) {
    if (stop == true) {
      Serial.begin(9600);
      digitalWrite(13, LOW);
      myStepper.setSpeed(10);
      myStepper.step(-512);
      myStepper.setSpeed(ScanSpd);
      stop = false;
    }
  }
  if (stop == false) {
    for (int i = 0; i <= 1024; i++) {
      us100.request_distance();
      angle = i / (stepsPerDegree);
      myStepper.step(1);
      byte data_available;
      data_available = us100.data_available();
      if (data_available & DISTANCE) {
        distance = us100.get_distance() / 10;
      }
      Serial.print(angle);
      Serial.print(",");
      Serial.print(distance);
      Serial.print(".");
    }
    for (int i = 1024; i > 0; i--) {
      us100.request_distance();
      angle = i / stepsPerDegree;
      myStepper.step(-1);
      byte data_available;
      data_available = us100.data_available();
      if (data_available & DISTANCE) {
        distance = us100.get_distance() / 10;
      }
      Serial.print(angle);
      Serial.print(",");
      Serial.print(distance);
      Serial.print(".");
    }
  }
}