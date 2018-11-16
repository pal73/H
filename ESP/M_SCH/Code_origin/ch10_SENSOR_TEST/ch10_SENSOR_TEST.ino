// Подключаем библиотеку датчика
#include <SHT1x.h>

// Назначаем выводы
#define dataPin  4
#define clockPin 5

// Создаем экземпляр объекта сенсора
SHT1x sht1x(dataPin, clockPin);

void setup()
{
   // Инициализируем последовательный порт
   Serial.begin(115200); 
   Serial.println("Starting up");
}

void loop()
{
  // Переменные
  float temp_c;
  float temp_f;
  float humidity;

  // Читаем данные из датчика
  temp_c = sht1x.readTemperatureC();
  temp_f = sht1x.readTemperatureF();
  humidity = sht1x.readHumidity();

  // Выводим значения в последовательный порт
  Serial.print("Temperature: ");
  Serial.print(temp_c, DEC);
  Serial.print("C / ");
  Serial.print(temp_f, DEC);
  Serial.print("F. Humidity: ");
  Serial.print(humidity);
  Serial.println("%");

  // Пауза 2 секунды
  delay(2000);
}
