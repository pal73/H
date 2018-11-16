// Этот скетч адаптирован для работы с модулем NodeMCU и 
// шилдом для управления моторами DoIt Smart Car
// Задаем выводы управления моторами
#define PWM1 D1
#define PWM2 D2
#define DIR1 D3
#define DIR2 D4

void setup()
{  
   // Задаем режим работы выводов
   pinMode(D1, OUTPUT);
   pinMode(D2, OUTPUT);
   pinMode(D3, OUTPUT);
   pinMode(D4, OUTPUT); 
}

void loop()
{
  
   // Движение вперед
   setMotorOne(true, 1000);
   setMotorTwo(true, 1000);

   // Пауза
   delay(5000);

   // Остановка
   setMotorOne(true, 0);
   setMotorTwo(true, 0);

   // Пауза
   delay(5000);
   
}

// Функция управления первым мотором
void setMotorOne(boolean forward, int motor_speed){
   digitalWrite(DIR1, forward);
   analogWrite(PWM1, motor_speed);
}

// Функция управления вторым мотором
void setMotorTwo(boolean forward, int motor_speed){
   digitalWrite(DIR2, forward);
   analogWrite(PWM2, motor_speed);
}
