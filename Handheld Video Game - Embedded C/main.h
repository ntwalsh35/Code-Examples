/*
 * main.h
 *
 *  Created on: Dec 8, 2021
 *      Author: Neil Walsh
 */

#ifndef MAIN_H_
#define MAIN_H_

#include "msp.h"
#include "msp432p401r.h"
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include "serial_debug.h"
#include "circular_buffer.h"
#include "UART.h"
#include "LCD.h"
#include "ece353.h"

/* RTOS header files */
#include <FreeRTOS.h>
#include <task.h>
#include <semphr.h>
#include <queue.h>

// tasks
#include "Task_Accl.h"
#include "Task_animate.h"
#include "Task_enemy.h"
#include "Task_light.h"
#include "Task_Buzzer.h"

// images
#include "ghost.h"
#include "enemy.h"
#include "level1.h"
#include "level2.h"
#include "level3.h"
#include "level4.h"
#include "level5.h"
#include "GameOver.h"
#include "titleScreen.h"
#include "clearScreen.h"
#include "buzzer.h"

// Semaphores
SemaphoreHandle_t Sem_LCD;
SemaphoreHandle_t Sem_UART;

#endif /* MAIN_H_ */
