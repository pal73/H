// Импортируем библиотеку поддержки ESP8266
#include <ESP8266WiFi.h>

// Параметры вашей сети WiFi
const char* ssid = "your_wifi_name";
const char* password = "your_wifi_password";

void setup(void)
{
  // Инициализация последовательного порта
  Serial.begin(115200);
  // Инициализация соединения WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");
  // Вывод IP адреса платы в терминал
  Serial.println(WiFi.localIP());
}
void loop() {
}
