
#include "stm8s.h"
#include <iostm8s103.h>
#include "i2c.h"

char addr7r = 0b10010001, addr7w = 0b10010000;

#define PAUSE(val) {char i; for(i=0;i<val;i++){nop();}}

#define H_DEL   PAUSE(30)
#define Q_DEL   PAUSE(15)
#define H_SCL	GPIOC->ODR|=(1<<7)
//PORT(I2C_SCL_PORT, ODR) |= I2C_SCL_PIN
#define L_SCL	GPIOC->ODR&=~(1<<7)
//PORT(I2C_SCL_PORT, ODR) &= ~I2C_SCL_PIN
#define H_SDA	GPIOB->ODR|=(1<<5)
//PORT(I2C_SDA_PORT, ODR) |= I2C_SDA_PIN
#define L_SDA	GPIOB->ODR&=~(1<<5)
//PORT(I2C_SDA_PORT, ODR) &= ~I2C_SDA_PIN
#define CHK_SDA ((GPIOB->IDR)&(1<<5))
//(PORT(I2C_SDA_PORT, IDR) & I2C_SDA_PIN)
#define CHK_SCL ((GPIOC->IDR)&(1<<7))
//(PORT(I2C_SCL_PORT, IDR) & I2C_SCL_PIN)

void i2c_setup(){
	// configure pins: I2C_SDA; I2C_SCL (both opendrain)
	GPIOB->ODR|=(1<<5);		//PORT(I2C_SDA_PORT, ODR) |= I2C_SDA_PIN; // set to 1
	GPIOC->ODR|=(1<<7);		//PORT(I2C_SCL_PORT, ODR) |= I2C_SCL_PIN;
	GPIOB->DDR|=(1<<5);		//PORT(I2C_SDA_PORT, DDR) |= I2C_SDA_PIN;
	GPIOC->DDR|=(1<<7);		//PORT(I2C_SCL_PORT, DDR) |= I2C_SCL_PIN;
	GPIOB->CR2|=(1<<5);		//PORT(I2C_SDA_PORT, CR2) |= I2C_SDA_PIN;
	GPIOC->CR2|=(1<<7);		//PORT(I2C_SCL_PORT, CR2) |= I2C_SCL_PIN;
}

void i2c_set_addr7(char addr){
	addr7w = addr << 1;
	addr7r = addr7w | 1;
}

void SoftStart(){
	H_SCL;
	H_DEL;
	L_SDA;
	H_DEL;
	L_SCL;
	H_DEL;
}

void SoftStop(){
	L_SDA;
	L_SCL;
	H_DEL;
	H_SCL;
	H_DEL;
	H_SDA;
}

/**
 * send 1 byte without start/stop
 */
char softi2c_send(char data)
	{
	char i;
	for(i=0; i < 8; i++)
		{
		L_SCL;
		if(data & 0x80)
			H_SDA;
		else
			L_SDA;
		H_DEL;
		H_SCL;
		H_DEL;
		data <<= 1;
		}
	// ACK
	L_SCL;
	H_SDA;
	H_DEL;
	H_SCL;
	Q_DEL;
	i = !(CHK_SDA);
//	Q_DEL;
	L_SCL;
//	Q_DEL;
	return i;
}
/**
 * receive one byte without start/stop
 */
char softi2c_receive(char ack)
	{
	char data = 0, i;
	for(i=0; i<8; i++)
		{
		data <<= 1;
		L_SCL;
		H_DEL;
		H_SCL;
		if(CHK_SDA) data |= 1;
		H_DEL;
		}
	// prepare for ACK/NACK
	//GPIOC->ODR&=~(1<<7);
	L_SCL;
	if(ack) L_SDA;
	else H_SDA;
	H_DEL;
	H_SCL;
	H_DEL;
	L_SCL;
	H_SDA;
	return data;
}

/**
 * send one byte in 7bit address mode
 * @param data - data to write
 * @param stop - ==1 to send stop event
 * @return I2C_OK if success errcode if fails
 */
i2c_status i2c_7bit_send_onebyte(char data, char stop){
	i2c_status ret = I2C_LINEBUSY;
	char err = 1;
	H_SCL; H_SDA;
	if(!CHK_SDA || !CHK_SCL) goto eotr;
	SoftStart();
	ret = I2C_NACK;
	if(!softi2c_send(addr7w)) goto eotr;
	if(softi2c_send(data)){
		ret = I2C_OK;
		err = 0;
	}
eotr:
	if(stop || err){
		SoftStop();
	}
	return ret;
}

/**
 * send datalen bytes over I2C
 * @param data - data to write
 * @param datalen - amount of bytes in data array
 * @param stop - ==1 to send stop event
 * return I2C_OK if OK
 */
i2c_status i2c_7bit_send(char *data, char datalen, char stop){
	i2c_status ret = I2C_LINEBUSY;
	char err = 1;
	H_SCL; H_SDA;
	if(!CHK_SDA || !CHK_SCL) goto eotr;
	SoftStart();
	ret = I2C_NACK;
	if(!softi2c_send(addr7w)) goto eotr;
	while(datalen--){
		if(!softi2c_send(*data++)) goto eotr;
	}
	ret = I2C_OK;
	err = 0;
eotr:
	if(stop || err){
		SoftStop();
	}
	return I2C_OK;
}

/**
 * get one byte by I2C
 * @param data - data to read (one byte)
 * @param wait - leaved for compatibility with HW I2C
 * @return I2C_OK if ok  || error code
 */
i2c_status i2c_7bit_receive_onebyte(char *data)
{
	i2c_status ret = I2C_NACK;
	H_SCL; H_SDA;
	if(!CHK_SDA || !CHK_SCL){
		ret = I2C_LINEBUSY;
		goto eotr;
	}
	SoftStart();
	if(!softi2c_send(addr7r)) goto eotr;
	*data = softi2c_receive(0);
	ret = I2C_OK;
eotr:
	SoftStop();
	return ret;
}

/**
 * receive 2 bytes by I2C
 * @param data - data to read (two bytes array, 0 first)
 * @param wait - ==1 to wait while LINEBUSY (can send STOP before reading)
 * @return I2C_OK if ok  || error code
 */
i2c_status i2c_7bit_receive_twobyte(char *data, char wait){
	i2c_status ret = I2C_NACK;
	H_SCL; H_SDA;
	(void) wait;
	if(!CHK_SDA || !CHK_SCL){
		ret = I2C_LINEBUSY;
		goto eotr;
	}
	SoftStart();
	if(!softi2c_send(addr7r)) goto eotr;
	data[0] = softi2c_receive(1);
	data[1] = softi2c_receive(0);
	ret = I2C_OK;
eotr:
	SoftStop();
	return ret;
}