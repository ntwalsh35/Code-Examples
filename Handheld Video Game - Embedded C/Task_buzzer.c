/*
 * Task_buzzer.c
 *
 *  Created on: Dec 12, 2021
 *      Author: Nate Tate
 */

#include <Task_buzzer.h>

TaskHandle_t Task_BUZZER_Handle;

extern volatile int soundToPlay;

/******************************************************************************
* Task used to play the buzzer sound that corresponds to the int soundToPlay
******************************************************************************/
void Task_Buzzer(void *pvParameters)
{
    int msg;

    while(1)
    {
        xQueueReceive(Queue_Buzzer, &msg, portMAX_DELAY);

        buzzer_sounds(msg);
        while (buzzer_run_status()) {};

        //Delay for 10ms using vTaskDelay
        //vTaskDelay(pdMS_TO_TICKS(10));

    }
}

