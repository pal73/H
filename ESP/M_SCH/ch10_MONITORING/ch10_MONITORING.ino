// Импорт библиотек
#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <aREST.h>
#include <SHT1x.h>

// Клиенты
WiFiClient espClient;
PubSubClient client(espClient);

// Выводы
#define dataPin  4
#define clockPin 5

// Создаем экземпляр объекта aREST
aREST rest = aREST(client);

// Создаем объект датчика
SHT1x sht1x(dataPin, clockPin);

// Введите уникальный идентификатор устройства
char* device_id = "gveie2y5";

// Параметры Wi-Fi
const char* ssid = "your-wifi";
const char* password = "your-password";

// Переменные для передачи данных в API
float temperature;
float humidity;

// Функции
void callback(char* topic, byte* payload, unsigned int length);

void setup(void)
{
  
  // Инициализация последовательного порта
  Serial.begin(115200);

  // Задаем обратный вызов
  client.setCallback(callback);

  // Привязываем переменные к REST API
  rest.variable("temperature", &temperature);
  rest.variable("humidity", &humidity);
  
  // Присваиваем устройству уникальный идентификатор
  rest.set_id(device_id);
  rest.set_name("gardening");

  // Подключаемся к Wi-Fi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");
  
}

void loop() {

  //Читаем данные из датчика
  temperature = sht1x.readTemperatureC();
  humidity = sht1x.readHumidity();

  // Подключение к облаку
  rest.handle(client);

}

// Поддержка отправки сообщений
void callback(char* topic, byte* payload, unsigned int length) {

  rest.handle_callback(client, topic, payload, length);

}
