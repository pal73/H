#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <aREST.h>

WiFiClient espClient;
PubSubClient client(espClient);

aREST rest = aREST(client);

// Придумайте и введите уникальный идентификатор на arest.io
char* device_id = "*********";
// Параметры доступа к вашей сети WiFi
const char* ssid = "your_wifi_ssid";
const char* password = "your_wifi_password";

bool ledState;
int toggle(String command);
// Функция обратного вызова
void callback(char* topic, byte* payload, unsigned int length);

void setup() {
  // Инициализация последовательного порта
  Serial.begin(115200);
  // Задаем имя и идентификатор устройства
  rest.set_id(device_id);
  rest.set_name("led");
  // Задаем имя функции, исполняемой по внешнему запросу
  rest.function("toggle", toggle);
  // Задаем функцию обратного вызова
  client.setCallback(callback);
  // Текущее состояние светодиода
  ledState = false;
  // Подключение к WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");
  // Pin 5 as output
  pinMode(5, OUTPUT);
}

void loop() {
  // Подключение к облаку
  rest.handle(client);
}

int toggle(String command) {
  ledState = !ledState;
  digitalWrite(5, ledState);
  return 1;
}

// Обработка сообщений, поступающих из канала (каналов)
void callback(char* topic, byte* payload, unsigned int length) {
  rest.handle_callback(client, topic, payload, length);
}
