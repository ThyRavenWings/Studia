#define WY 2
#define WE 8
#define POT A1
#define BUZZ 9

void setup() {
  pinMode(WY,OUTPUT);
  pinMode(WE,INPUT_PULLUP);
  pinMode(POT,INPUT);
  pinMode(BUZZ,OUTPUT);
}

void loop() {
  int p=0;
  for(int i=0;i<10;i++)
  {
    digitalWrite(WY,1);
    delay(5);
    digitalWrite(WY,0);
    delay(1);
    int f = pulseIn(WE,1,5000);
    int x = analogRead(POT);
    int y = map(x,0,1023,80,120);
    if(f>y)
      p++;
  }
  if(p>=8)
  {
    digitalWrite(BUZZ,1);
    delay(200);
    digitalWrite(BUZZ,0);
  }
  delay(1);
}
