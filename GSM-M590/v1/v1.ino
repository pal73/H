// звоним по событию
//#include <SoftwareSerial.h>

//SoftwareSerial gsm(7, 8); // RX, TX
//Serial gsm;
void setup() {
  //Serial.begin(9600);
  Serial.begin(115200);
  //Serial.println("Hello");
  pinMode(6, INPUT_PULLUP);
  pinMode(13, OUTPUT);
  digitalWrite(13,0);

  while(!Serial.find("+PBREADY")) {
    //if (Serial.find("MODEM:STARTUP"))digitalWrite(13,digitalRead(13));
  }
  digitalWrite(13,1);
}

void loop() {
  //if (Serial.find("MODEM:STARTUP"))digitalWrite(13,!digitalRead(13));
   if(!digitalRead(6)){     // если нажали кнопку
      while(1){             // проверяем готовность модема
        Serial.println("AT+CPAS");
        if (Serial.find("0")) break;
        delay(100);  
      }
      Serial.println("ATD+79139294352;"); // звоним по указаному номеру
      delay(100);
      //if (gsm.find("OK")) Serial.println("OK!");
      //else Serial.println("error");
    } 

}

