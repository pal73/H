// Подключаем библиотеку DHT
#include "DHT.h"
// Объявляем номер вывода для датчика
#define DHTPIN 5
// Объявляем датчик DHT11
#define DHTTYPE DHT11
// Создаем объект датчика
DHT dht(DHTPIN, DHTTYPE);
void setup() {
  // Инициализируем последовательный порт
  Serial.begin(115200);
  // Инициализируем датчик
  dht.begin();
}
void loop() {
  // Ждем 2 секунды перед очередным измерением
  delay(2000);
  // Считываем влажность
  float h = dht.readHumidity();
  // Считываем температуру в градусах Цельсия
  float t = dht.readTemperature();

  // Проверяем, нет ли ошибки измерения
  if (isnan(h) || isnan(t)) {
    Serial.println("Failed to read from DHT sensor!");
  }
  
  // Выводим данные на печать
  Serial.print("Humidity: ");
  Serial.print(h);
  Serial.print(" %\t");
  Serial.print("Temperature: ");
  Serial.print(t);
  Serial.println(" *C ");
}

