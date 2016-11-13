#include <SoftwareSerial.h>
SoftwareSerial mySerial(2, 3);          // RX, TX
int ch = 0;
String val = "";
#define MASTER "+79139294352"          //укажите  телефон хозяина
//#include <OneWire.h>


#define GREEN_LED 3
#define YELLOW_LED 2

bool ylState,glState;
int oldMillis;
//OneWire ds(4);

void setup()
{
pinMode(GREEN_LED, OUTPUT);
pinMode(YELLOW_LED, OUTPUT);

Serial.begin(9600);                  //подключаем порт компьютера
Serial.println("GSM Neoway M590 example");
mySerial.begin(19200);                //подключаем порт модема (при других скоростях не отвечает)
mySerial.println("ATI");     //вывести в терминал иноформацию о модеме
mySerial.println("AT+CLIP=1");        //включаем АОН
delay(100);
mySerial.println("AT+CMGF=1");        //режим кодировки СМС - обычный (для англ.)
delay(100);
mySerial.println("AT+CSCS=\"GSM\"");  //режим кодировки текста
delay(100);
mySerial.println("AT+CNMI=2,2");
 
}
 
void loop()
{
digitalWrite(YELLOW_LED,ylState);
digitalWrite(GREEN_LED,glState);

if(millis()/1000!=oldMillis) {
 ylState=!ylState;
 glState=!glState; 
}
oldMillis=millis()/1000;
  
byte data[2];
//ds.reset();
//ds.write(0xCC);
//ds.write(0x44);
//delay(750);
//ds.reset();
//ds.write(0xCC);
//ds.write(0xBE);
//data[0] = ds.read();
//data[1] = ds.read();
//int Temp = (data[1] << 8) + data[0];
//Temp = Temp >> 4;
//Serial.println(Temp);
if (mySerial.available()) {          //есть данные от GSM модуля
delay(200);                        //выждем, чтобы строка успела попасть в порт целиком раньше чем будет считана
    while (mySerial.available()) {      //сохраняем входную строку в переменную val
      ch = mySerial.read();
      val += char(ch);
      delay(10);
    }
    Serial.println(val);                    // дублируем сообщение в терминал
    //----------------------- определение факта приема СМС и сравнение номера(ов) с заданным(и)
    if (val.indexOf("+CMT") > -1) {          //если обнаружен СМС (для определения звонка вместо "+CMT" вписать "RING", трубку он не берет, но реагировать на факт звонка можно)
      if (val.indexOf(MASTER) > -1) {        //если СМС от хозяина
        Serial.println("--- MASTER SMS DETECTED ---");
      } else {
        Serial.println("NO MASTER SMS");
      }
 
      //----------------------- поиск кодового слова в СМС (вообще эту часть надо поместить внутрь предыдущей, но если использовать кодовое слово не совпадающее с сообщениями модема, то не обязательно)
      if (val.indexOf("temp") > -1) {      // если обнаружено кодовое слово
        Serial.println("send you ok");      // сообщаем об этом в терминал (если нужно)
       sms("temperatura  ", MASTER, String(millis()));            // отвечаем смской
      } else {
        Serial.println("no send you");
        sms("wrong ", MASTER, "command");
        if (val.indexOf("temp") > -1) {      // если обнаружено кодовое слово
          Serial.println("send you ok");      // сообщаем об этом в терминал (если нужно)
          sms("temperatura  ", MASTER, String(millis()));            // отвечаем смской
        } else {
          Serial.println("no send you");
          sms("wrong ", MASTER, "command");
        }
        val = "";
      }
    }
  }
}

void sms(String text, String phone, String Temp)
{
  Serial.println("SMS send started");
  mySerial.println("AT+CMGS=\"" + phone + "\"");
  delay(500);
  mySerial.print(text);
  delay(500);
  mySerial.print(Temp);
  delay(500);
  mySerial.print((char)26);
  delay(500);
  Serial.println("SMS send complete");
  delay(2000);
  mySerial.println("AT+CMGD=1");        //стираем память смс
  delay(100);
}

