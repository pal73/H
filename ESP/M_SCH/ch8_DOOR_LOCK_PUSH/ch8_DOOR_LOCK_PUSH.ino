#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <aREST.h>

// Создаем объекты клиентов
WiFiClient espClient;
PubSubClient client(espClient);

// Создаем объект aREST
aREST rest = aREST(client);

// Придумайте уникальный идентификатор вашего устройства
char* device_id = "*********";

// Параметры доступа к вашей сети WiFi
const char* ssid = "your_wifi_ssid";
const char* password = "your_wifi_password";

// Настройки сервиса IFTTT
const char* host = "maker.ifttt.com";
const char* eventName   = "lock_opened";
// Введите здесь свой ключ сервиса Maker Webhooks
const char* key = "*****************************************";

// Функция обработки команд aREST
void callback(char* topic, byte* payload, unsigned int length);

// Переменные состояния замка
bool lockStatus;
bool previousLockStatus;

void setup(void)
{

  // Инициализируем последовательный порт
  Serial.begin(115200);

  // Задаем функцию обратного вызова
  client.setCallback(callback);

  // Задаем имя и ID устройства
  rest.set_id(device_id);
  rest.set_name("door_lock");

  // Подключение к сети WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");

  // Принудительно устанавливаем вывод D5 в низкий уровень,
  // чтобы избежать ложное включение соленоида до подключения к серверу aREST
  // (в исходном коде автора книги этих двух строк нет)
  pinMode(D5, OUTPUT);
  digitalWrite(D5, LOW);

  // Начальное чтение состояния замка
  lockStatus = digitalRead(D5);
  previousLockStatus = lockStatus;

}

void loop() {
  delay(1000);
  // Подключаемся к облаку
  rest.handle(client);

  // Считываем состояние вывода управления замком
  lockStatus = digitalRead(D5);
  Serial.println(lockStatus);

  // Если статус замка изменился и замок открыт
  if (lockStatus != previousLockStatus && lockStatus == 1) {

    Serial.print("connecting to ");
    Serial.println(host);

    // Используем WiFiClient для подключения TCP
    WiFiClient client;
    const int httpPort = 80;
    if (!client.connect(host, httpPort)) {
      Serial.println("connection failed");
      return;
    }

    // Формируем URI запроса к серверу
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
    while (client.available()) {
      String line = client.readStringUntil('\r');
      Serial.print(line);
    }

    Serial.println();
    Serial.println("closing connection");
  }
  // Сохраняем предыдущее состояние замка
  previousLockStatus = lockStatus;
}

// Обработка сообщений, поступающих из канала (каналов)
void callback(char* topic, byte* payload, unsigned int length) {
  rest.handle_callback(client, topic, payload, length);
}
