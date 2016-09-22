#include "FastLED.h"
#include <iarduino_RTC.h>

iarduino_RTC time(RTC_DS3231);

// How many leds in your strip?
#define NUM_LEDS 27
#define START_OF_HOUR_LEDS        3
#define START_OF_HOUR_DECS_LEDS   0
#define START_OF_MINUTE_LEDS      18
#define START_OF_MINUTE_DECS_LEDS 12   

bool b100Hz;
bool b10Hz;
bool b1Hz;
int seconds=15;
byte minutes=39;

// For led chips like Neopixels, which have a data line, ground, and power, you just
// need to define DATA_PIN.  For led chipsets that are SPI based (four wires - data, clock,
// ground, and power), like the LPD8806 define both DATA_PIN and CLOCK_PIN
#define CHIPSET     WS2812
#define DATA_PIN 7
#define CLOCK_PIN 13
#define COLOR_ORDER GRB

// Define the array of leds
CRGB leds[NUM_LEDS];

void setHours (int number, CRGB color) {
  for(int i = 0; i<10; i++) {
    if(i<=number)   leds[START_OF_HOUR_LEDS+i]=color;
    else            leds[START_OF_HOUR_LEDS+i]=CRGB::Black; 
  }
}

void setup() { 
  delay(300);
  Serial.begin(9600);
  FastLED.addLeds<WS2812, DATA_PIN, COLOR_ORDER>(leds, NUM_LEDS);
  time.begin();
  
}

void loop() { 

if(millis()%10==0){ 
  b100Hz=1;
}
if(millis()%100==0){ 
  b10Hz=1;
}
if(millis()%1000==0){ 
  b1Hz=1;
}
delay(1); // приостанавливаем на 1 мс, чтоб не выводить время несколько раз за 1мс
 

if(b1Hz){ 
  b1Hz=0;

  //Serial.println(time.gettime("d-m-Y, H:i:s, D")); // выводим время
  time.gettime();
  //Serial.println(time.gettime("s")/*seconds*/);
  Serial.println(time.seconds);
  leds[0] = CRGB::Green;
  FastLED.show();
}





/*  // Turn the LED on, then pause
  //leds[0] = CRGB::White;
  leds[0].red =    0;
  leds[0].green = 0;
  leds[0].blue =  0;  
  FastLED.show();
  delay(500);*/
  // Now turn the LED off, then pause
  //leds[0] = CRGB::Black;
  //leds[0].red =    2;
  //leds[0].green = 2;
  //leds[0].blue =  2;
/*  FastLED.show();
  leds[0] = CRGB::Green;
  leds[1] = CRGB::Green;
  leds[2] = CRGB::Green;

  leds[3] = CRGB::Red;
  leds[4] = CRGB::Red;
  leds[5] = CRGB::Red;
  leds[6] = CRGB::Red;
  leds[7] = CRGB::Red;
  leds[8] = CRGB::Red;
  leds[9] = CRGB::Red;
  leds[10] = CRGB::Red;
  leds[11] = CRGB::Red;

  leds[12] = CRGB::Blue;
  leds[13] = CRGB::Blue;
  leds[14] = CRGB::Blue;
  leds[15] = CRGB::Blue;
  leds[16] = CRGB::Blue;
  leds[17] = CRGB::Blue;
*/
/*
  leds[18] = CRGB::Amethyst ;
  leds[19] = CRGB::Aqua;
  leds[20] = CRGB::Sienna;
  leds[21] = CRGB::FireBrick;
  leds[22] = CRGB::ForestGreen ;
  leds[23] = CRGB::Tomato;
  leds[24] = CRGB::Pink;
  leds[25] = CRGB::Yellow; 
  leds[26] = CRGB::Coral;*/
/*
  // Amethyst
  //Aqua
 // delay(500);*/
/*  // Turn the LED on, then pause
  //leds[0] = CRGB::White;
  leds[0].red =    0;
  leds[0].green = 0;
  leds[0].blue =  0;  
  FastLED.show();
  delay(500);  
  // Now turn the LED off, then pause
  //leds[0] = CRGB::Black;
  leds[0].red =    1500;
  leds[0].green = 0;
  leds[0].blue =  0;
  FastLED.show();
  delay(500); 
    // Turn the LED on, then pause
  //leds[0] = CRGB::White;
  leds[0].red =    0;
  leds[0].green = 0;
  leds[0].blue =  0;  
  FastLED.show();
  delay(500);
     // Now turn the LED off, then pause
  //leds[0] = CRGB::Black;
  leds[0].red =    0;
  leds[0].green = 0;
  leds[0].blue =  150;
  FastLED.show();
  delay(500);
    // Turn the LED on, then pause
  //leds[0] = CRGB::White;
  leds[0].red =    0;
  leds[0].green = 0;
  leds[0].blue =  0;  
  FastLED.show();
  delay(500);
     // Now turn the LED off, then pause
  //leds[0] = CRGB::Black;
  leds[0].red =    150;
  leds[0].green = 150;
  leds[0].blue =  150;
  FastLED.show();
  delay(500); */
}
