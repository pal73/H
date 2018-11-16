// Назначаем выводы управления моторами
int motorOnePlus = 12;
int motorOneMinus = 13;
int motorOneEnable = 14;

int motorTwoPlus = 5;
int motorTwoMinus = 16;
int motorTwoEnable = 4;

void setup()
{
  
   // Назначаем режимы выводов
   pinMode(motorOnePlus, OUTPUT);
   pinMode(motorOneMinus, OUTPUT);
   pinMode(motorOneEnable, OUTPUT);
   
   pinMode(motorTwoPlus, OUTPUT);
   pinMode(motorTwoMinus, OUTPUT);
   pinMode(motorTwoEnable, OUTPUT);
  
}

void loop()
{
  
   // Движение вперед
   setMotorOne(true, 700);
   setMotorTwo(true, 700);

   // Задержка 5 секунд
   delay(5000);

   // Остановка
   setMotorOne(true, 0);
   setMotorTwo(true, 0);

   // Задержка 5 секунд
   delay(5000);
   
}

// Функция управления первым мотором
void setMotorOne(boolean forward, int motor_speed){
   digitalWrite(motorOnePlus, forward);
   digitalWrite(motorOneMinus, !forward);
   analogWrite(motorOneEnable, motor_speed);
}

// Функция управления вторым мотором
void setMotorTwo(boolean forward, int motor_speed){
   digitalWrite(motorTwoPlus, forward);
   digitalWrite(motorTwoMinus, !forward);
   analogWrite(motorTwoEnable, motor_speed);
}
