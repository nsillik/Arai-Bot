// this constant won't change.  It's the pin number
// of the sensor's output:
const int pingPin  = 13;
const int photoPin = 1;
const int thermPin = 2;
const int touchPin = 0;
const int accel1Pin = 5;
const int accel2Pin = 6;
const int accel3Pin = 7;
void setup() {
  // initialize serial communication:
  Serial.begin(9600);
  pinMode(pingPin, INPUT);
  pinMode(accel1Pin, INPUT);
  pinMode(accel2Pin, INPUT);
  pinMode(accel3Pin, INPUT);  
}

// Returns distance in CM
int see(){
  // establish variables for duration of the ping, 
  // and the distance result in inches and centimeters:
  long duration, inches, cm;

  // The PING))) is triggered by a HIGH pulse of 2 or more microseconds.
  // Give a short LOW pulse beforehand to ensure a clean HIGH pulse:
  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin, LOW);

  // The same pin is used to read the signal from the PING))): a HIGH
  // pulse whose duration is the time (in microseconds) from the sending
  // of the ping to the reception of its echo off of an object.
  pinMode(pingPin, INPUT);
  duration = pulseIn(pingPin, HIGH);

  // convert the time into a distance
  return microsecondsToCentimeters(duration);
}

int therm(){
  return analogRead(thermPin);
}

int photo(){
  return analogRead(photoPin);  
}

int feel(){
  return analogRead(touchPin);
}

int accel1r(){
    pulseIn(accel1Pin, HIGH);
    return analogRead(((pulseIn(accel1Pin, HIGH) / 10 ) - 500) * 8);
}

int accel2r(){
    pulseIn(accel2Pin, HIGH);
    return analogRead(((pulseIn(accel2Pin, HIGH) / 10 ) - 500) * 8);
}

int accel3r(){
    pulseIn(accel3Pin, HIGH);
    return analogRead(((pulseIn(accel3Pin, HIGH) / 10 ) - 500) * 8);
}

void loop()
{
  int distance = 0;
  int temp = 0;
  int light = 0;
  int touch = 0;
  int accel1 = 0;
  int accel2 = 0;
  int accel3 = 0;
  distance = see();
  temp = therm();
  light = photo();
  touch = feel();
  accel1 = accel1r();
  accel2 = accel2r();
  accel3 = accel3r();
  output(distance, temp, light, touch, accel1, accel2, accel3);
  delay(100);
}

void output(int distance, int temp, int light, int touch, int accel1, int accel2, int accel3){
  Serial.print(millis());
  Serial.print(",");
  Serial.print(distance);
  Serial.print(",");
  Serial.print(temp);
  Serial.print(",");
  Serial.print(light);
  Serial.print(",");
  Serial.print(touch);
    Serial.print(",");
  Serial.print(accel1);
    Serial.print(",");
  Serial.print(accel2);
    Serial.print(",");
  Serial.print(accel3);
  Serial.print("\n");
}

long microsecondsToInches(long microseconds)
{
  // According to Parallax's datasheet for the PING))), there are
  // 73.746 microseconds per inch (i.e. sound travels at 1130 feet per
  // second).  This gives the distance travelled by the ping, outbound
  // and return, so we divide by 2 to get the distance of the obstacle.
  // See: http://www.parallax.com/dl/docs/prod/acc/28015-PING-v1.3.pdf
  return microseconds / 74 / 2;
}

long microsecondsToCentimeters(long microseconds)
{
  // The speed of sound is 340 m/s or 29 microseconds per centimeter.
  // The ping travels out and back, so to find the distance of the
  // object we take half of the distance travelled.
  return microseconds / 29 / 2;
}



