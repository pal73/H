// Подключаем библиотеки
#include <ESP8266WiFi.h>
#include <ArduinoJson.h>
#include <Wire.h>
#include "SSD1306.h"

// Определяем выводы для подключения дисплея
#define SDA 14 // вывод платы D5
#define SCL 12 // вывод платы D6
#define I2C 0x3C // адрес дисплея на шине I2C

// Создаем объект дисплея
SSD1306 display(I2C, SDA, SCL);

// выводы для подключения светодиодов
#define LED_PIN_UP 4 // вывод платы D2
#define LED_PIN_DOWN 5 // вывод платы D1

// предыдущее значение курса и порог изменения
float previousValue = 0.0;
float threshold = 0.05;

// Настройки доступа WiFi
const char* ssid     = "your_wifi_name";
const char* password = "your_wifi_password";

// Адрес API
const char* host = "api.coindesk.com";

void setup() {

  // Инициализируем последовательный порт
  Serial.begin(115200);

   // Инициализируем дисплей
  display.init();
  display.flipScreenVertically();
  display.clear();
  display.display();

  // выводы светодиодов в режим выхода
  pinMode(LED_PIN_DOWN, OUTPUT);
  pinMode(LED_PIN_UP, OUTPUT);

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

  // Подключаемся к серверу
  Serial.print("connecting to ");
  Serial.println(host);
  
  // Используем WiFiClient для создания TCP соединения
  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
  }
  
  // Формируем запрос
  String url = "/v1/bpi/currentprice.json";
  
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  // Отправляем запрос на сервер
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(100);
  
  // Читаем ответ сервера и выводим в терминал
  String answer;
  while (!client.available()) {} // ждем ответ сервера
  while(client.available()){
    String line = client.readStringUntil('\r');
    answer += line;
  }

  client.stop();
  Serial.println();
  Serial.println("closing connection");

  // обрабатываем ответ
  Serial.println();
  Serial.println("Answer: ");
  Serial.println(answer);

  // конвертируем в JSON
  String jsonAnswer;
  int jsonIndex;

  for (int i = 0; i < answer.length(); i++) {
    if (answer[i] == '{') {
      jsonIndex = i;
      break;
    }
  }

  // извлекаем данные JSON
  jsonAnswer = answer.substring(jsonIndex);
  Serial.println();
  Serial.println("JSON answer: ");
  Serial.println(jsonAnswer);
  jsonAnswer.trim();

  // конвертируем курс в число с плавающей запятой
  int rateIndex = jsonAnswer.indexOf("rate_float");
  String priceString = jsonAnswer.substring(rateIndex + 12, rateIndex + 18);
  priceString.trim();
  float price = priceString.toFloat();

  // выводим курс в терминал
  Serial.println();
  Serial.println("Bitcoin price: ");
  Serial.println(price);

  // отображаем курс на дисплее
  display.clear();
  display.setFont(ArialMT_Plain_24);
  display.drawString(26, 20, priceString);
  display.display();

  // фиксируем предыдущее значение 
  if (previousValue == 0.0) {
    previousValue = price;
  }

  // Курс падает?
  if (price < (previousValue - threshold)) {

    // мигаем светодиодом
    digitalWrite(LED_PIN_DOWN, HIGH);
    delay(100);
    digitalWrite(LED_PIN_DOWN, LOW);
    delay(100);
    digitalWrite(LED_PIN_DOWN, HIGH);
    delay(100);
    digitalWrite(LED_PIN_DOWN, LOW);
    
  }

  // курс растет?
  if (price > (previousValue + threshold)) {

    // мигаем светодиодом
    digitalWrite(LED_PIN_UP, HIGH);
    delay(100);
    digitalWrite(LED_PIN_UP, LOW);
    delay(100);
    digitalWrite(LED_PIN_UP, HIGH);
    delay(100);
    digitalWrite(LED_PIN_UP, LOW);
    
  }

  // Сохраняем предыдущее значение
  previousValue = price;

  // ждем 5 секунд
  delay(5000);
}

