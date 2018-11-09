
// flags for i2c_state
typedef enum{
	I2C_OK = 0,
	I2C_LINEBUSY,
	I2C_TMOUT,
	I2C_NOADDR,
	I2C_NACK,
	I2C_HWPROBLEM
} i2c_status;

void i2c_setup(void);
void SoftStart(void);
void SoftStop(void);
i2c_status i2c_7bit_send_onebyte(char data, char stop);
i2c_status i2c_7bit_receive_onebyte(char *data);
i2c_status i2c_7bit_receive_twobyte(char *data, char wait);
i2c_status i2c_7bit_send(char *data, char datalen, char stop);