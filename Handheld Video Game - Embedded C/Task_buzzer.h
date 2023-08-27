/*
 * Task_buzzer.h
 *
 *  Created on: Dec 12, 2021
 *      Author: ntate
 */

#ifndef TASK_BUZZER_H_
#define TASK_BUZZER_H_

#include "main.h"
#include "buzzer.h"

extern TaskHandle_t Task_BUZZER_Handle;

volatile QueueHandle_t Queue_Buzzer;

volatile int soundToPlay;

/******************************************************************************
* Task used to play the buzzer sound that corresponds to the int soundToPlay
******************************************************************************/
void Task_Buzzer(void *pvParameters);


#endif /* TASK_LIGHT_H_ */




