// Импорт библиотеки
#include <ESP8266WiFi.h>
// Параметры вашей точки доступа
const char* ssid = "your_wifi_name";
const char* password = "your_wifi_password";
// Адрес сайта
const char* host = "www.example.com";
void setup() {
// Старт последовательного порта
// для передачи текста в монитор
Serial.begin(115200);
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
int value = 0;
void loop() {
Serial.print("Connecting to ");
Serial.println(host);
// Используем класс WiFiClient для создания подключения TCP
WiFiClient client;
const int httpPort = 80;
if (!client.connect(host, httpPort)) {
// Если сайт недоступен
Serial.println("connection failed");
return;
}
// Отправляем HTTP запрос на сервер
client.print(String("GET /") + " HTTP/1.1\r\n" +
"Host: " + host + "\r\n" + "Connection: close\r\n\r\n");
delay(10);
// Читаем все строки ответа сервера и выводим их в монитор
while(client.available()){
String line = client.readStringUntil('\r');
Serial.print(line);
}
Serial.println();
Serial.println("closing connection");
delay(5000);
}

