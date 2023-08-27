/*
 * opt3001.h
 *
 *  Created on: Oct 20, 2020
 *      Author: Nathaniel Tate
 */

#ifndef OPT3001_H_
#define OPT3001_H_

#include "msp.h"
#include "i2c.h"
#include <stdint.h>
#include <stdbool.h>

#define I2C_OPT_ADDR   0x44

#define I2C_OPT_RESULT    0x00
#define I2C_OPT_CONFIG    0x01
#define I2C_OPT_LOW_LIM   0x02
#define I2C_OPT_HIGH_LIM  0x03
#define I2C_OPT_DEV_ID    0x7F

/* CONFIGURATION REGISTER SETTINGS */
#define OPT3001_RST                0xC810     //Automatic Full Scale Setting Mode
#define OPT3001_CONTMODE           0x0C00     //Continuous Conversions

/******************************************************************************
 * Initialize the opt3001 light sensor on the MKII.  This function assumes
 * that the I2C interface has already been configured to operate at 100KHz.
 ******************************************************************************/
void opt3001_init(void);

/******************************************************************************
 * Returns the current light level.
 ******************************************************************************/
float opt3001_read_light(void);

#endif /* OPT3001_H_ */
