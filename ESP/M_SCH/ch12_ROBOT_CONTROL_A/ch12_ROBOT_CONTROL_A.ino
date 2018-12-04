// Этот скетч адаптирован для работы с модулем NodeMCU и
// шилдом для управления моторами DoIt Smart Car
// Импортируем необходимые библиотеки
#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <aREST.h>

// Задаем выводы управления моторами
#define PWM1 D1
#define PWM2 D2
#define DIR1 D3
#define DIR2 D4

// Клиенты
WiFiClient espClient;
PubSubClient client(espClient);

// Создаем экземпляр объекта aREST
aREST rest = aREST(client);

// Введите здесь уникальный идентификатор вашего устройства
char* device_id = "*******";

// Параметры доступа WiFi
const char* ssid = "********";
const char* password = "**********";

// Функция обратного вызова
void callback(char* topic, byte* payload, unsigned int length);

// Объявляем функции для обращения через API
int stop(String command);
int forward(String command);
int left(String command);
int right(String command);
int backward(String command);

void setup()
{

  Serial.begin(1152000);

  // Задаем режим работы выводов
  pinMode(D1, OUTPUT);
  pinMode(D2, OUTPUT);
  pinMode(D3, OUTPUT);
  pinMode(D4, OUTPUT);

  // Инициализируем функцию обратного вызова
  client.setCallback(callback);

  // Назначаем устройству идентификатор и имя
  rest.set_id(device_id);
  rest.set_name("robot");

  // Подключаем функции к API
  rest.function("forward", forward);
  rest.function("stop", stop);
  rest.function("right", right);
  rest.function("left", left);
  rest.function("backward", backward);

  // Подключаемся к WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");


}

void loop()
{

  // Подключаемся к облаку
  rest.handle(client);

}

// Функции для управления первым мотором
void setMotorOne(boolean forward, int motor_speed) {
  digitalWrite(DIR1, forward);
  analogWrite(PWM1, motor_speed);
}

// Функции для управления первым мотором
void setMotorTwo(boolean forward, int motor_speed) {
  digitalWrite(DIR2, forward);
  analogWrite(PWM2, motor_speed);
}

// Обработка входящих сообщений
void callback(char* topic, byte* payload, unsigned int length) {

  rest.handle_callback(client, topic, payload, length);

}

// Функции для управления роботом
int stop(String command) {

  setMotorOne(true, 0);
  setMotorTwo(true, 0);

}

int forward(String command) {

  setMotorOne(true, 1000);
  setMotorTwo(true, 1000);

}

int backward(String command) {

  setMotorOne(false, 1000);
  setMotorTwo(false, 1000);

}

int left(String command) {

  setMotorOne(false, 700);
  setMotorTwo(true, 700);

}

int right(String command) {

  setMotorOne(true, 700);
  setMotorTwo(false, 700);

}
