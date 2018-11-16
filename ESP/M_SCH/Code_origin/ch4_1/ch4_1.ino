// Подключаем нужные библиотеки
#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <aREST.h>
// Создаем объекты клиентов
WiFiClient espClient;
PubSubClient client(espClient);
// Создаем объект aREST
aREST rest = aREST(client);
// Уникальный идентификатор для cloud.arest.io
// укажите здесь свой идентификатор
char* device_id = "theBHVbook";
// Параметры вашей сети WiFi
//const char* ssid = "your_wifi_name";
//const char* password = "your_wifi_password";
const char* ssid = "Rover";
const char* password = "prst4xv8";

// Функция обработки команд aREST
void callback(char* topic, byte* payload, unsigned int length);

void setup(void)
{
  // Инициализируем последовательный порт
  Serial.begin(115200);
  // Задаем функцию обратного вызова
  client.setCallback(callback);
  // Задаем имя и ID устройства
  rest.set_id(device_id);
  rest.set_name("devices_control");
  // Подключение к сети WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");
  // Задаем канал сообщений 
  char* out_topic = rest.get_topic();
}
void loop() {
  // Подключаемся к облаку
  rest.handle(client);
}
// Обработка сообщений, поступающих из канала (каналов)
void callback(char* topic, byte* payload, unsigned int length) {
  rest.handle_callback(client, topic, payload, length);
}


