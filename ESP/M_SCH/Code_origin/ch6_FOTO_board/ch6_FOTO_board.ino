#include <ESP8266WiFi.h>

WiFiClient client;

// Параметры доступа к вашей сети WiFi
const char* ssid = "your_wifi_ssid";
const char* password = "your_wifi_password";

const int httpPort = 80;
const char* host = "maker.ifttt.com";
// Введите здесь ваш ключ сервиса Maker Webhooks
const char* key = "***************************************";

bool lightLevel = false;

void setup() {
  Serial.begin(115200);
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
  Serial.print("Light level: ");
  Serial.println(analogRead(A0));
  delay(1000);

  if (analogRead(A0) < 700 && lightLevel) {
    lightLevel = false;
    makeRequest("light_level_low");
  }
  if (analogRead(A0) > 800 && !lightLevel) {
    lightLevel = true;
    makeRequest("light_level_high");
  }
}

void makeRequest(String eventName) {
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
  }
  // Создаем URI запроса
  String url = "/trigger/";
  url += eventName;
  url += "/with/key/";
  url += key;
  Serial.print("Requesting URL: ");
  Serial.println(url);
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
}

