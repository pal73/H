// Импортируем библиотеки
#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <aREST.h>

// Назначаем выводы управления моторами
int motorOnePlus = 12;
int motorOneMinus = 13;
int motorOneEnable = 14;

int motorTwoPlus = 5;
int motorTwoMinus = 16;
int motorTwoEnable = 4;

// Объявление веб-клиентов
WiFiClient espClient;
PubSubClient client(espClient);

// Объект aREST
aREST rest = aREST(client);

// Придумайте и введите идентификатор устройства на cloud.arest.io
char* device_id = "********";

// Параметры доступа к WiFi
const char* ssid = "*********";
const char* password = "**********";

// Объявляем функцию обратного вызова
void callback(char* topic, byte* payload, unsigned int length);

// Объявляем функции API сервиса aREST
int stop(String command);
int forward(String command);
int left(String command);
int right(String command);
int backward(String command);

void setup()
{
  Serial.begin(9600);

  // Задаем режим работы выводов
  pinMode(motorOnePlus, OUTPUT);
  pinMode(motorOneMinus, OUTPUT);
  pinMode(motorOneEnable, OUTPUT);

  pinMode(motorTwoPlus, OUTPUT);
  pinMode(motorTwoMinus, OUTPUT);
  pinMode(motorTwoEnable, OUTPUT);

  // Привязываем функцию обратного вызова к клиенту
  client.setCallback(callback);

  // Присваиваем устройству имя и идентификатор
  rest.set_id(device_id);
  rest.set_name("robot");

  // Команды, которые будут обработаны
  rest.function("forward", forward);
  rest.function("stop", stop);
  rest.function("right", right);
  rest.function("left", left);
  rest.function("backward", backward);

  // Подключение к WiFi
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

  // Подключение к облачному сервису
  rest.handle(client);

}

// Функция управления первым мотором
void setMotorOne(boolean forward, int motor_speed) {
  digitalWrite(motorOnePlus, forward);
  digitalWrite(motorOneMinus, !forward);
  analogWrite(motorOneEnable, motor_speed);
}

// Функция управления вторым мотором
void setMotorTwo(boolean forward, int motor_speed) {
  digitalWrite(motorTwoPlus, forward);
  digitalWrite(motorTwoMinus, !forward);
  analogWrite(motorTwoEnable, motor_speed);
}

// Обработка входящих команд
void callback(char* topic, byte* payload, unsigned int length) {

  rest.handle_callback(client, topic, payload, length);

}

// Функции управления роботом
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
