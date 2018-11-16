// Импорт необходимой библиотеки
#include <ESP8266WiFi.h>
void setup(void)
{
// Старт последовательного порта
// для передачи текста в монитор
Serial.begin(115200);
// Настраиваем GPIO5 (D1) как вход
pinMode(5, INPUT);}
void loop() {
// Читаем уровень на GPIO5 и выводим в монитор
Serial.print("State of GPIO 5: ");
Serial.println(digitalRead(5));
// Пауза 1 секунда
delay(1000);
}

