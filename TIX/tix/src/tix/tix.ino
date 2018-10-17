#include <Arduino.h>

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

const byte a = 0b10101010;
const int b = 0b1010101011110000;

const int DIGITS_3[3][2][10]={
  { {0b0000000000000001,0b0000000000000010,0b0000000000000100}, {3} },
  { {0b0000000000000011,0b0000000000000110,0b0000000000000101}, {3} },
  { {0b0000000000000111}, {1}  }
};

const int DIGITS_6[6][2][10]={
  { {0b0000000000000001,0b0000000000000010,0b0000000000000100,0b0000000000001000,0b0000000000010000,0b0000000000100000}, {6} },
  { {0b0000000000100001,0b0000000000010001,0b0000000000000101,0b0000000000000011,0b0000000000001001}, {5} },
/*3*/   { {0b0000000000000111,0b0000000000111000,0b0000000000010101,0b0000000000101010,0b0000000000010110,0b0000000000110010,0b0000000000010011,0b0000000000011010}, {8}  },
/*4*/   { {0b0000000000110110,0b0000000000101101,0b0000000000011011,0b0000000000011110,0b0000000000110011,0b0000000000111100,0b0000000000111001,0b0000000000100111,0b0000000000001111}, {9} },
/*5*/   { {0b0000000000111110,0b0000000000111101,0b0000000000111011,0b0000000000110111,0b0000000000101111,0b0000000000011111}, {6} },
/*6*/   { {0b0000000000111111}, {1} },
};
// For led chips like Neopixels, which have a data line, ground, and power, you just
// need to define DATA_PIN.  For led chipsets that are SPI based (four wires - data, clock,
// ground, and power), like the LPD8806 define both DATA_PIN and CLOCK_PIN
#define CHIPSET     WS2812
#define DATA_PIN 7
#define CLOCK_PIN 13
#define COLOR_ORDER GRB

// Define the array of leds
CRGB leds[NUM_LEDS];

void showHours (int number, CRGB color) {
  if(number!=0) {
    for(int i = 0; i<10; i++) {
      if(i<number)   leds[START_OF_HOUR_LEDS+i]=color;
      else            leds[START_OF_HOUR_LEDS+i]=CRGB::Black; 
    }
  } else {
    for(int i = 0; i<10; i++) leds[START_OF_HOUR_LEDS+i]=CRGB::Black;
    leds[START_OF_HOUR_LEDS+4]=CRGB::White; 
  }
}

void showHourDecs (int number, CRGB color) {
  if(number!=0) {
    for(int i = 0; i<3; i++) {
      if(i<number)   leds[START_OF_HOUR_DECS_LEDS+i]=color;
      else            leds[START_OF_HOUR_DECS_LEDS+i]=CRGB::Black; 
    }
  } else {
    for(int i = 0; i<3; i++) leds[START_OF_HOUR_DECS_LEDS+i]=CRGB::Black;
    leds[START_OF_HOUR_DECS_LEDS+1]=CRGB::White; 
  }
}

void showMinutes (int number, CRGB color) {
  if(number!=0) {
    for(int i = 0; i<10; i++) {
      if(i<number)   leds[START_OF_MINUTE_LEDS+i]=color;
      else            leds[START_OF_MINUTE_LEDS+i]=CRGB::Black; 
    }
  } else {
    for(int i = 0; i<10; i++) leds[START_OF_MINUTE_LEDS+i]=CRGB::Black;
    leds[START_OF_MINUTE_LEDS+4]=CRGB::White; 
  }
}

void showMinuteDecs (int number, CRGB color) {
  if(number!=0) {
    for(int i = 0; i<6; i++) {
      if(i<number)   leds[START_OF_MINUTE_DECS_LEDS+i]=color;
      else            leds[START_OF_MINUTE_DECS_LEDS+i]=CRGB::Black; 
    }
  } else {
    for(int i = 0; i<6; i++) leds[START_OF_MINUTE_DECS_LEDS+i]=CRGB::Black;
    leds[START_OF_MINUTE_DECS_LEDS+4]=CRGB::White; 
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

  Serial.println(time.gettime("d-m-Y, H:i:s, D")); // выводим время
  time.gettime();
  //leds[0] = CRGB::Green;
  Serial.println(a); // выводим время
  Serial.println(b); // выводим время
  showHours (time.Hours%10, CRGB::Red);
  showHourDecs (time.Hours/10, CRGB::Green);
  showMinutes (time.minutes%10, CRGB::Blue);
  showMinuteDecs (time.minutes/10, CRGB::Yellow);  
  FastLED.show();
}

if(b10Hz){ 
  b10Hz=0;
time.gettime();
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
