/*
 * Task_animate.h
 *
 *  Created on: Dec 8, 2021
 *      Author: Neil Walsh
 */

#ifndef TASK_ANIMATE_H_
#define TASK_ANIMATE_H_

// queue for direction data
QueueHandle_t Queue_Accl;

TaskHandle_t Task_animate_Handle;

// colors
volatile uint16_t charColor;
volatile uint16_t backColor;

// struct type that holds corner values for collision checking
typedef struct
{
    int x1, x2, y1, y2;
} ghostLocation;

// struct for this ghost
volatile ghostLocation ghostLoc;

/**
 * Animates ghost character using data taken from queue sent by Task_accl
 * keeps the ghost on the screen and adjusts data for corners stored in
 * ghostLocation struct for collision checking
 */
void Task_animate(void *pvParameters);

#endif /* TASK_ANIMATE_H_ */
