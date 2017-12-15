/*
Получатель SMS
 
Этот скетч для Arduino GSM Shield ждет входящих SMS-сообщений,
а затем отображает их на Serial Monitor.
 
Цепь:
* GSM Shield
 
Создан 25 февраля 2012 Хавьером Зорзано (Javier Zorzano) / TD
 
Этот код не защищен авторским правом.
*/
 
// Библиотеки:
#include <GSM.h>
 
// PIN-код:
#define PINNUMBER ""
 
// Создаем экземпляры классов:
GSM gsmAccess; // включая параметр «true» для активации отладки
GSM_SMS sms;
 
char remoteNumber[20];  // массив, в котором будет храниться входящий номер
 
void setup()
{
  // Инициализируем последовательную передачу данных:
  Serial.begin(9600);
 
  Serial.println("SMS Messages Receiver");  //  "Получатель SMS-сообщений"
 
  // Состояние соединения:
  boolean notConnected = true;
 
  // Запускаем GSM Shield.
  // Если ваша SIM-карта заблокирована PIN-кодом,
  // то укажите его параметром в функции gsmAccess.begin():
  while(notConnected)
  {
    if(gsmAccess.begin(PINNUMBER)==GSM_READY)
      notConnected = false;
    else
    {
      Serial.println("Not connected");  //  "Подключиться не удалось"
      delay(1000);
    }
  }
 
  Serial.println("GSM initialized");  //  "GSM инициализирован"
  Serial.println("Waiting for messages");  //  "Ожидание сообщений"
}
 
void loop()
{
  char c;
 
  // Если есть какие-либо доступные SMS:  
  if (sms.available())
  {
    Serial.println("Message received from:");  //  "Сообщение получено от:"
 
    // «Изымаем» номер:
    sms.remoteNumber(remoteNumber, 20);
    Serial.println(remoteNumber);
 
    // Это лишь пример удаления сообщения.    
    // Сообщения, начинающиеся с «#», должны быть отклонены:
    if(sms.peek()=='#')
    {
      Serial.println("Discarded SMS");  //  "Сообщение отклонено"
      sms.flush();
    }
 
    // Считываем байты сообщения и выводим на Serial Monitor:
    while(c=sms.read())
      Serial.print(c);
 
    Serial.println("\nEND OF MESSAGE");  //  "\nКонец сообщения"
 
    // Удаляем сообщение из памяти модема:
    sms.flush();
    Serial.println("MESSAGE DELETED");  //  "Сообщение удалено"
  }
 
  delay(1000);
 
}
