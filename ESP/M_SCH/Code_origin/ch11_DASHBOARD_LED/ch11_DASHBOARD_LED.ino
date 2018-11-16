// Подключаем библиотеки
#include "ESP8266WiFi.h"
#include <PubSubClient.h>
#include <aREST.h>

// Клиенты
WiFiClient espClient;
PubSubClient client(espClient);

// Введите здесь свой идентификатор для  cloud.arest.io
char* device_id = "*********";

// Создаем экземпляр объекта aREST
aREST rest = aREST(client);

// Параметры доступа к WiFi
const char* ssid = "wifi-name";
const char* password = "wifi-pass";

// Порт для входящих подключений TCP 
#define LISTEN_PORT           80

// Создаем экземпляр сервера
WiFiServer server(LISTEN_PORT);

void setup(void)
{  
  // Запускаем последовательный порт
  Serial.begin(115200);
 
  // Регистрируем функцию обратного вызова
  client.setCallback(callback);
    
  // Присваиваем устройству имя и идентификатор
  rest.set_id(device_id);
  rest.set_name("dimmer");
  
  // Подключаемся к WiFi
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
  
  // Выводим на печать IP адрес
  Serial.println(WiFi.localIP());
  
}

void loop() {
  
  // Обработка вызовов REST
  rest.handle(client);
 
}

// Обработка поступающих сообщений
void callback(char* topic, byte* payload, unsigned int length) {

  rest.handle_callback(client, topic, payload, length);

}
