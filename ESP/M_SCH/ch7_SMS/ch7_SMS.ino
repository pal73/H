#include <ESP8266WiFi.h>
#include "DHT.h"

// Параметры доступа к вашей сети WiFi
const char* ssid = "your_wifi_ssid";
const char* password = "your_wifi_password";

// Номер вывода и тип датчика
#define DHTPIN 5
#define DHTTYPE DHT11

// Создаем объект датчика DHT11
DHT dht(DHTPIN, DHTTYPE);

// Параметры доступа к IFTTT
const char* host = "maker.ifttt.com";
const char* eventName   = "data";
// Введите здесь ваш ключ сервиса Maker Webhooks
const char* key = "****************************************";

void setup() {

  Serial.begin(115200);
  delay(10);

  // Инициализируем датчик
  dht.begin();
  delay(1000);

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
  // Измеряем влажность и температуру
  float h = dht.readHumidity();
  float t = dht.readTemperature();

  Serial.print("connecting to ");
  Serial.println(host);

  // Используем WiFiClient для TCP подключения
  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
  }

  // Создаем URI запроса
  String url = "/trigger/";
  url += eventName;
  url += "/with/key/";
  url += key;
  url += "?value1=";
  url += String(t);
  url += "&value2=";
  url += String(h);

  Serial.print("Requesting URL: ");
  Serial.println(url);

  // Отправляем запрос на сервер
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" +
               "Connection: close\r\n\r\n");
  int timeout = millis() + 5000;

  // Проверяем продолжительность ожидания ответа
  while (client.available() == 0) {
    if (timeout - millis() < 0) {
      Serial.println(">>> Client Timeout !");
      client.stop();
      return;
    }
  }

  // Читаем ответ сервера и выводим его в терминал
  while (client.available()) {
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }

  Serial.println();
  Serial.println("closing connection");

  // Пауза 1 минута
  delay(60 * 1000);
}

