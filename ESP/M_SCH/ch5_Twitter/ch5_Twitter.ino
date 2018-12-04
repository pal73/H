#include <ESP8266WiFi.h>
#include <Temboo.h>
#include "TembooAccount.h"
#include "DHT.h"

int calls = 1;   // Счетчик запросов
int maxCalls = 10;   // Максимальное количество запросов

#define WIFI_SSID "your_wifi_ssid"
#define WPA_PASSWORD "your_wifi_password"

// вывод GPIO для датчика DHT11
#define DHTPIN 5
#define DHTTYPE DHT11
// Создаем объект датчика DHT11
DHT dht(DHTPIN, DHTTYPE);

WiFiClient client;

void setup() {
  // Инициализация DHT11
  dht.begin();
  Serial.begin(115200); // Инициализируем последовательный порт
  // Подключаемся к сети WiFi
  WiFi.begin(WIFI_SSID, WPA_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("...");
  }
  Serial.println("Wifi Connected.\n");
}

void loop() {
  delay(2000);
  // Считывание данных
  float h = dht.readHumidity();
  float t = dht.readTemperature();
  // Создаем строку текста для твита
  String StatusUpdateValue = "The temperature is " + String(t) + " and the humidity is " + String(h) + ".";

  if (calls <= maxCalls) {
    Serial.println("Running StatusesUpdate - Run #" + String(calls++));

    TembooChoreo StatusesUpdateChoreo(client);

    // Инициализируем клиента Temboo
    StatusesUpdateChoreo.begin();

    // Данные из аккаунта Temboo
    StatusesUpdateChoreo.setAccountName(TEMBOO_ACCOUNT);
    StatusesUpdateChoreo.setAppKeyName(TEMBOO_APP_KEY_NAME);
    StatusesUpdateChoreo.setAppKey(TEMBOO_APP_KEY);

    // Входные параметры Choreo
    StatusesUpdateChoreo.addInput("StatusUpdate", StatusUpdateValue);
    
    // Подставьте вместо звездочек ключи из вашего аккаунта Twitter
    StatusesUpdateChoreo.addInput("AccessToken", "**********************************");
    StatusesUpdateChoreo.addInput("ConsumerKey", "******************************************");
    StatusesUpdateChoreo.addInput("ConsumerSecret", "*****************************************");
    StatusesUpdateChoreo.addInput("AccessTokenSecret", "****************************************");

    // Определяем Choreo для запуска
    StatusesUpdateChoreo.setChoreo("/Library/Twitter/Tweets/StatusesUpdate");

    // Запускаем запрос на публикацию нового твита
    StatusesUpdateChoreo.run();
    Serial.println("New tweet has been published. Check your account))");
    StatusesUpdateChoreo.close();
  }

  Serial.println("Waiting...");
  delay(30000); // ждем 30 секунд перед следующим запросом
}
