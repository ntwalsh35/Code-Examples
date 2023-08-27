/*
 * task_accl.h
 *
 *  Created on: Dec 8, 2021
 *      Author: Neil Walsh
 */

#ifndef TASK_ACCL_H_
#define TASK_ACCL_H_

// Direction enum for accl control
typedef enum
{
    RIGHT, LEFT, UP, DOWN, CENTER, UPRIGHT, UPLEFT, DOWNRIGHT, DOWNLEFT
} DIR;

typedef enum
{
    SLOW, MED, FAST
} SPEED;

extern TaskHandle_t Task_Accl_Bottom_Half_Handle;
extern TaskHandle_t Task_Accl_Timer_Handle;
extern TaskHandle_t Task_Accl_Handle;

// struct holding data sent in queue from accl to animation
typedef struct
{
    DIR dir;
    SPEED spd;
} ACCL_MSG_t;

// global variables that holds the most recent value of the X,Y and Z directions
volatile float ACCL_X_DIR;
volatile float ACCL_Y_DIR;
volatile float ACCL_Z_DIR;

// Update speed of accelerometer
volatile int LCD_update_ms;

/******************************************************************************
 * Used to start an ADC14 Conversion
 ******************************************************************************/
void Task_Accl_Timer(void *pvParameters);

/**
 * Handle data from accl, returning in a queue the X and Y direction as an enum
 */
void Task_Accl_Bottom_Half(void *pvParameters);

#endif /* TASK_ACCL_H_ */
