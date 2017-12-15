int a[20];
int b[25];
int c[25];
int d[30];
bool b100Hz,b10Hz,b1Hz;
bool bBlink;
int redSensorVal,greenSensorVal;
int buttonInputVal=1; 
unsigned long oldMillis;

int ledBuiltin_cnt=0;
long ledBuiltin_buff=0;

int inDrvRed1SecCnt;
int inDrvRedGreenOnCnt,inDrvRedGreenOffCnt,inDrvRedOnCnt,inDrvGreenOnCnt;
bool bRed1Sec,bRedGreen;

#define RED_INPUT 2
#define GREEN_INPUT 3
#define BUTTON_INPUT 4
#define BUTTON_OUTPUT 8

//------------------------------------------------------
void inDrv(void)  //100Гц
{
bool locRed,locGreen;
   
locRed= digitalRead(RED_INPUT);
locGreen= digitalRead(GREEN_INPUT);

//Отслеживание красного 1-секундного сигнала
if(locRed==0) 
  {
  if(inDrvRed1SecCnt<100)
    {
    inDrvRed1SecCnt++;
    if(inDrvRed1SecCnt>75)
      {
      bRed1Sec=1;
      ledBuiltin_cnt_init(9);  
      }
    }
     
  }
else
  {
  inDrvRed1SecCnt=0;  
  }


if(locRed&&locGreen)
  {
  if(inDrvRedGreenOffCnt<30)
    {
    inDrvRedGreenOffCnt++; 
    if(inDrvRedGreenOffCnt>=25)
      {
      inDrvRedGreenOnCnt=0;  
      inDrvRedOnCnt=0; 
      inDrvGreenOnCnt=0;  
      }
    }
  }
else if(!locRed)
  {
  inDrvRedGreenOffCnt=0;  
  if(inDrvRedOnCnt<50)
    {
    inDrvRedOnCnt++;
/*    if(inDrvRedOnCnt>=50)
      {
      bRedGreen=1; 
      ledBuiltin_cnt_init(20);   
      }*/
    }
  }
else if(!locGreen)
  {
  inDrvRedGreenOffCnt=0;  
  if(inDrvGreenOnCnt<50)
    {
    inDrvGreenOnCnt++;
/*    if(inDrvRedOnCnt>=50)
      {
      bRedGreen=1; 
      ledBuiltin_cnt_init(20);   
      }*/
    }
  } 

if((inDrvRedOnCnt>=50)&&(inDrvGreenOnCnt>=50))
  {
        bRedGreen=1; 
      ledBuiltin_cnt_init(20);  
  }
   
}
//------------------------------------------------------
void ledBuiltin_cnt_init(int init_int)
{
ledBuiltin_cnt=init_int;
ledBuiltin_buff=0; 
//digitalWrite(LED_BUILTIN, HIGH); 
}
//------------------------------------------------------
void ledBuiltin_drv(void)
{
if((!ledBuiltin_cnt) && (!ledBuiltin_buff)) 
  {
                      digitalWrite(LED_BUILTIN, LOW);  
  }
else if(ledBuiltin_cnt)
  {
  if(ledBuiltin_cnt)  digitalWrite(LED_BUILTIN, HIGH);
  else                digitalWrite(LED_BUILTIN, LOW); 
  ledBuiltin_cnt--; 
  }
  
}

void setup() {
  // put your setup code here, to run once:
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(RED_INPUT, INPUT_PULLUP);
  pinMode(GREEN_INPUT, INPUT_PULLUP);
  pinMode(BUTTON_INPUT, INPUT_PULLUP);
  pinMode(BUTTON_OUTPUT, OUTPUT);

  Serial.begin(9600);
}

void loop() 
{
  
if(millis()!=oldMillis)
  {
  oldMillis=millis();
  if ((millis()%10)==0)b100Hz=1;
  if ((millis()%100)==0)b10Hz=1;
  if ((millis()%1000)==0)b1Hz=1; 
     
  }


if(b100Hz)
  {
  b100Hz=0; 

  inDrv();

  //redSensorVal = digitalRead(RED_INPUT);
  //greenSensorVal = digitalRead(GREEN_INPUT);
  buttonInputVal = digitalRead(BUTTON_INPUT); 
   
  }

if(b10Hz)
  {
  b10Hz=0; 

  ledBuiltin_drv();
/*  if (redSensorVal == HIGH) 
    {
    digitalWrite(LED_BUILTIN, LOW);
    } 
  else 
    {
    digitalWrite(LED_BUILTIN, HIGH);
    } */

  if (buttonInputVal == LOW) 
    {
    digitalWrite(BUTTON_OUTPUT, HIGH);
    } 
  else 
    {
    digitalWrite(BUTTON_OUTPUT, LOW);
    }   

  //Serial.println(inDrvRedGreenOnCnt,"     ",inDrvRedGreenOffCnt);  
  Serial.print(inDrvRedGreenOnCnt);
  Serial.print("     ");
  Serial.println(inDrvRedGreenOffCnt);
  Serial.print("     ");
  Serial.println(bRedGreen);

  } 

if(b1Hz)
  {
  b1Hz=0; 
  
  
  } 

/*  if (bBlink == LOW) 
    {
    digitalWrite(LED_BUILTIN, HIGH);
    } 
  else 
    {
    digitalWrite(LED_BUILTIN, LOW);
    }  */  
  // put your main code here, to run repeatedly:

/*  digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(3000);                       // wait for a second
  digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
  delay(1000); */
/*
  if (buttonInputVal == LOW) 
    {
    digitalWrite(LED_BUILTIN, HIGH);
    } 
  else 
    {
    digitalWrite(LED_BUILTIN, LOW);
    } */  

  
}
