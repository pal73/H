#define __nop() _asm("nop")

extern char wire1_in[10];			//���������� ������, ����� 1wire
extern char ds18b20ErrorHiCnt; 		//������� ������ �� ��������� ����� � "+" (��� ���������� �������)
extern char ds18b20ErrorLoCnt;		//������� ������ �� ��������� ����� � "-" 
extern char ds18b20ErrorOffCnt;		//������� ���������� ������� �������
typedef enum {esNORM=0x55,esHI=1,esLO=0} enumDsErrorStat; 
extern enumDsErrorStat airSensorErrorStat;
//-----------------------------------------------
typedef enum {sensOFF=0,sens18B20=1,sens1775=2} enumSensorType;
enumSensorType sensor;

//-----------------------------------------------
char wire1_rts(void);
