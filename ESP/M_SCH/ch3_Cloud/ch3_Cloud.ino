/***************************************************
  Written by Marco Schwartz for Open Home Automation.
  BSD license, all text above must be included in any redistribution
  Based on the original sketches supplied with the ESP8266/Arduino
  implementation written by Ivan Grokhotkov
****************************************************/

// Подключаем библиотеки
#include <ESP8266WiFi.h>
#include "DHT.h"

// Имя и пароль ВАШЕЙ вашей точки доступа
const char* ssid = "your_wifi_name";
const char* password = "your_wifi_password";

// Задаем номер вывода GPIO
#define DHTPIN 5

// Задаем тип датчика
#define DHTTYPE DHT11

// Создаем объект датчика
DHT dht(DHTPIN, DHTTYPE);

// Адрес сервера
const char* host = "dweet.io";

void setup() {

  // Инициализируем последовательный порт
  Serial.begin(115200);
  delay(10);

  // Инициализируем датчик
  dht.begin();

  // Подключаемся к сети WiFi
  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void loop() {
  // Пауза между повторными измерениями 10 секунд
  delay(10000);

  Serial.print("Connecting to ");
  Serial.println(host);

  // Создаем TCP соединение при помощи класса WiFiClient
  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
  }

  // Считываем значение влажности
  int h = dht.readHumidity();
  // Считываем значение температуры
  int t = dht.readTemperature();

  // Отправляем запрос на сервер
  client.print(String("GET /dweet/for/theBHVbook?temperature=") + String(t) + "&humidity=" + String(h) + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" +
               "Connection: close\r\n\r\n");
  delay(10);

  // Получаем все строки ответа сервера и отправляем их в последовательный порт
  while (client.available()) {
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }

  Serial.println();
  Serial.println("closing connection");
}
