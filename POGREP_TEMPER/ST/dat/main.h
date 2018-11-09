#define __nop() _asm("nop")

extern char wire1_in[10];			//—читывание данных, буфер 1wire
extern char ds18b20ErrorHiCnt; 		//—четчик ошибок по замыканию линии в "+" (или отсутствию датчика)
extern char ds18b20ErrorLoCnt;		//—четчик ошибок по замыканию линии в "-" 
extern char ds18b20ErrorOffCnt;		//—четчик нормальных ответов датчика
typedef enum {esNORM=0x55,esHI=1,esLO=0} enumDsErrorStat; 
extern enumDsErrorStat airSensorErrorStat;
//-----------------------------------------------
typedef enum {sensOFF=0,sens18B20=1,sens1775=2} enumSensorType;
enumSensorType sensor;

//-----------------------------------------------
char wire1_rts(void);
