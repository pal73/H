#include <ESP8266WiFi.h>

// WiFi settings
const char* ssid     = "Rover";
const char* password = "prst4xv8";

//// Параметры доступа к вашей сети WiFi
//const char* ssid = "your_wifi_ssid";
//const char* password = "your_wifi_password";

// Параметры доступа к IFTTT
const char* host = "maker.ifttt.com";
const char* eventName   = "hello";
// Введите здесь ваш ключ сервиса Maker Webhooks
const char* key = "b4nsvuFo6sRig5bPIdwkNQu7QAeDoLTgjMrGTqsfC3A";

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
  Serial.print("connecting to ");
  Serial.println(host);
  
  //Используем WiFiClient для TCP подключения
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
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");

  // Пауза 1 минута
  delay(60 * 1000);
}

