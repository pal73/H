// Импортируем библиотеки
#include "ESP8266WiFi.h"
#include <aREST.h>
#include "DHT.h"

// Номер вывода GPIO и тип сенсора
#define DHTPIN 5
#define DHTTYPE DHT11

// Создаем объект aREST
aREST rest = aREST();

// Создаем объект сенсора
DHT dht(DHTPIN, DHTTYPE);

// Логин и пароль ВАШЕЙ сети WiFi
const char* ssid = "Rover";
const char* password = "prst4xv8";

// Номер входящего порта
#define LISTEN_PORT           80

// Создаем сервер
WiFiServer server(LISTEN_PORT);

// Переменные для подключения через API
float temperature;
float humidity;

void setup(void)
{
  // Инициализируем последовательный порт
  Serial.begin(115200);

  // Инициализируем датчик
  dht.begin();

  // Инициализируем переменные REST API
  rest.variable("temperature", &temperature);
  rest.variable("humidity", &humidity);

  // Присваиваем устройству индес и имя
  rest.set_id("1");
  rest.set_name("esp8266");

  // Подключаемся к сети WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");

  // Запускаем сервер
  server.begin();
  Serial.println("Server started");

  // Выводим на печать IP адрес сервера
  Serial.println(WiFi.localIP());

}

void loop() {
  // задержка между измерениями
  delay(2000);
  // Считываем данные влажности и температуры
  humidity = dht.readHumidity();
  temperature = dht.readTemperature();

  // Обработка внешних запросов REST
  WiFiClient client = server.available();
  if (!client) {
    return;
  }
  while (!client.available()) {
    delay(1);
  }
  rest.handle(client);

}
