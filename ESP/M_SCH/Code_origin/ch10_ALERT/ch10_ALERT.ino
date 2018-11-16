// Подключаем библиотеки
#include <ESP8266WiFi.h>
#include <SHT1x.h>

// Параметры доступа к вашей сети Wi-Fi
const char* ssid = "wifi-name";
const char* password = "wifi-pass";

// Порог влажности
float threshold = 30.00;

// Выводы
#define dataPin  4
#define clockPin 5

// Переменные для результатов измерений
float temperature;
float humidity;

// Создаем экземпляр объекта датчика
SHT1x sht1x(dataPin, clockPin);

// Настройки сервиса IFTTT
const char* host = "maker.ifttt.com";
const char* eventName   = "alert";
const char* key = "ifttt-key";

void setup() {
  
  Serial.begin(115200);
  delay(10);


  // Подключаемся к сети Wi-Fi
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

  // Читаем данные из сенсора
  temperature = sht1x.readTemperatureC();
  humidity = sht1x.readHumidity();

  // Проверяем уровень влажности
  if (humidity < threshold) {

    Serial.print("connecting to ");
    Serial.println(host);
  
    // Используем класс WiFiClient для создания TCP соединения
    WiFiClient client;
    const int httpPort = 80;
    if (!client.connect(host, httpPort)) {
      Serial.println("connection failed");
      return;
    }
  
    // Создаем строку запроса
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

    // Ждем 10 минут
    delay(10 * 60 * 1000);
    
  }
 
}

