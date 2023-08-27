/*
 * opt3001.c
 *
 *  Created on: Oct 20, 2020
 *      Author: Nathaniel Tate
 */

#include "opt3001.h"
#include <math.h>

/******************************************************************************
 * Initialize the opt3001 light sensor on the MKII.  This function assumes
 * that the I2C interface has already been configured to operate at 100KHz.
 ******************************************************************************/
void opt3001_init(void)
{
    int i;

    i2c_init();

    // Reset the device using the CONFIG register
    i2c_write_16(I2C_OPT_ADDR, I2C_OPT_CONFIG, OPT3001_RST);
    // delay
    for(i = 0; i < 50000; i++){};

    uint16_t autoConfig = i2c_read_16(I2C_OPT_ADDR, I2C_OPT_CONFIG);

    i2c_write_16(I2C_OPT_ADDR, I2C_OPT_CONFIG, autoConfig | OPT3001_CONTMODE);

//    // Program the CONFIG register to POWER_UP and be in CR_2 mode
//    i2c_write_16(I2C_TEMP_ADDR, I2C_TEMP_CONFIG, OPT3001_ | TMP006_CR_2);
}

/******************************************************************************
 * Returns the current light reading in lux.
 ******************************************************************************/
float opt3001_read_light(void)
{
    uint16_t result;
    uint16_t resultMask = 0x0FFF;

    // Read the ambient light
    result = i2c_read_16(I2C_OPT_ADDR, I2C_OPT_RESULT);
    // Return the data in lux.  (See OPT3001 Data Sheet)

    uint16_t exponent = result >>12;
    uint16_t fracResult = result & resultMask;

    return ((float)fracResult) * .01 * pow(2,exponent);
}

