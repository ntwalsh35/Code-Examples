/*
 * Task_light.h
 *
 *  Created on: Dec 11, 2021
 *      Author: Nathaniel Tate
 */

#ifndef TASK_LIGHT_H_
#define TASK_LIGHT_H_

#include "main.h"
#include "opt3001.h"

extern TaskHandle_t Task_LIGHT_Handle;

/******************************************************************************
* Convert the lux reading to a color to be displayed
******************************************************************************/
uint16_t luxToColor(void);

void Task_Light(void *pvParameters);


#endif /* TASK_LIGHT_H_ */
