// sms по собынию
#include <SoftwareSerial.h>

SoftwareSerial gsm(7, 8); // RX, TX

short plazma=0;

void sms(String text, String phone)  //процедура отправки СМС
{
  Serial.println("SMS send started");
  gsm.println("AT+CMGS=\"" + phone + "\"");
  delay(500);
  gsm.print(text);
  delay(500);
  gsm.print((char)26);
  delay(500);
  Serial.println("SMS send complete");
  delay(2000);
}


void setup() {
  Serial.begin(9600);
  gsm.begin(9600);

  pinMode(6, INPUT_PULLUP); 
 
  gsm.println("AT+CMGF=1");  
  delay(100);
  gsm.println("AT+CSCS=\"GSM\"");   
  delay(100);
  Serial.println("Start");
  Serial.print("plazma=");
  Serial.println(plazma,DEC);

}

void loop() {
  plazma++;
  //Serial.print("plazma=");
  //Serial.println(plazma,DEC);
  //delay(100);
   if(!digitalRead(6)){     // если нажали кнопку
      Serial.println("sms");
      sms("Privet, ja tvoy dom","+79134863890");
      /*while(1){             // проверяем готовность модема
        gsm.println("AT+CPAS");
        if (gsm.find("0")) break;
        delay(100);  
      }
      gsm.println("AT+CMGS=\"+79139294352\""); // даем команду на отправку смс
      delay(1000);
      gsm.print("analogPin A0:");  // отправляем текст
      gsm.print(plazma);    // и переменную со значением
      gsm.print((char)26);          // символ завершающий передачу
       Serial.println("ok");*/
    }
    
     while (gsm.available() > 0) {  // останавливаем программу и смотрим что ответили
    Serial.write(gsm.read()); 
  }

}
