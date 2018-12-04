#include <ESP8266WiFi.h>
#include <Temboo.h>
#include "TembooAccount.h"

int calls = 1;   // Счетчик запросов
int maxCalls = 10;   // Максимальное количество запросов

#define WIFI_SSID "your_wifi_ssid"
#define WPA_PASSWORD "your_wifi_password"

WiFiClient client;

void setup() {
  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WPA_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("...");
  }
  Serial.println("Wifi Connected.\n");
}

void loop() {
  if (calls <= maxCalls) {
    Serial.println("Running GetWeatherByAddress - Run #" + String(calls++));
    TembooChoreo GetWeatherByAddressChoreo(client);

    // Инициализируем клиента Temboo
    GetWeatherByAddressChoreo.begin();

    // Данные из аккаунта Temboo
    GetWeatherByAddressChoreo.setAccountName(TEMBOO_ACCOUNT);
    GetWeatherByAddressChoreo.setAppKeyName(TEMBOO_APP_KEY_NAME);
    GetWeatherByAddressChoreo.setAppKey(TEMBOO_APP_KEY);

    // Входные параметры Choreo
    GetWeatherByAddressChoreo.addInput("Address", "Moscow");

    // Определяем Choreo для запуска
    GetWeatherByAddressChoreo.setChoreo("/Library/Yahoo/Weather/GetWeatherByAddress");

    // Запускаем запрос и выводим ответ в терминал
    GetWeatherByAddressChoreo.run();
    Serial.println("Run");
    while (GetWeatherByAddressChoreo.available()) {
      char c = GetWeatherByAddressChoreo.read();
      ESP.wdtFeed();
      Serial.print(c);
    }
    GetWeatherByAddressChoreo.close();
  }
  Serial.println("\nWaiting...\n");

  delay(30000); // ждем 30 секунд перед следующим запросом
}
