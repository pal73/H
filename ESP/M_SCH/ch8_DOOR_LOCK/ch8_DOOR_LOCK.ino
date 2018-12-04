#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <aREST.h>

// Создаем объекты клиентов
WiFiClient espClient;
PubSubClient client(espClient);

// Создаем объект aREST
aREST rest = aREST(client);

// Придумайте уникальный идентификатор вашего устройства
// и укажите его при создании элемента управления панели aREST
char* device_id = "*******";


// Параметры доступа к вашей сети WiFi
const char* ssid = "your_wifi_ssid";
const char* password = "your_wifi_password";

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
  rest.set_name("Lock");

  // Подключение к сети WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");  
  
}

void loop() {
  // Подключаемся к облаку
  rest.handle(client);
}

// Обработка сообщений, поступающих из канала (каналов)
void callback(char* topic, byte* payload, unsigned int length) {
  rest.handle_callback(client, topic, payload, length);
}
