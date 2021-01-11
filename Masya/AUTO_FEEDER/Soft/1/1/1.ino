
#include <Ticker.h>


short st_cnt0, st_cnt1, st_cnt2, st_cnt3;
bool b1Hz, b2Hz, b5Hz, b10Hz;
Ticker sys_timer_10ms;

void system_time_grid_service_routine(void) 
{
if(++st_cnt0>=10)
  {
  st_cnt0=0;
  b10Hz=1;  
  }
  
if(++st_cnt1>=20)
  {
  st_cnt1=0;
  b5Hz=1;  
  } 

if(++st_cnt2>=50)
  {
  st_cnt2=0;
  b2Hz=1;  
  }
  
if(++st_cnt3>=100)
  {
  st_cnt3=0;
  b1Hz=1;  
  }
}

void setup() 
{
pinMode(LED_BUILTIN, OUTPUT);     // Initialize the LED_BUILTIN pin as an output
sys_timer_10ms.attach(0.01, system_time_grid_service_routine);
}

// the loop function runs over and over again forever
void loop() 
{
/*  digitalWrite(LED_BUILTIN, LOW);   // Turn the LED on (Note that LOW is the voltage level
  // but actually the LED is on; this is because
  // it is active low on the ESP-01)
  delay(1000);                      // Wait for a second
  digitalWrite(LED_BUILTIN, HIGH);  // Turn the LED off by making the voltage HIGH
  delay(2000);                      // Wait for two seconds (to demonstrate the active low LED)*/
if(b2Hz)
  {
  b2Hz=0;

  digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
  }
}
