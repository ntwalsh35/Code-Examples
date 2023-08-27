/*
 * Task_light.c
 *
 *  Created on: Dec 11, 2021
 *      Author: Nathaniel Tate and Neil Walsh
 */

#include <Task_light.h>

TaskHandle_t Task_LIGHT_Handle;

/******************************************************************************
 * Convert the lux reading to a color to be displayed
 ******************************************************************************/
uint16_t luxToColor(void)
{
    float light = opt3001_read_light();

    if (light > 300)
    {
        return 0xF800;
    }
    else if (light > 240)
    {
        return 0xF81F;
    }
    else if (light > 180)
    {

        return 0xFFE0;
    }
    else if (light > 120)
    {
        return 0x07FF;
    }
    else if (light > 60)
    {
        return 0x07E0;
    }
    else
    {
        return 0xFCA0;
    }
}

/******************************************************************************
 * Task used to convert the ambient light level to the character and level color
 ******************************************************************************/
void Task_Light(void *pvParameters)
{
    while (1)
    {
        lvlColor = charColor = luxToColor();

        //Delay for 100ms using vTaskDelay
        vTaskDelay(pdMS_TO_TICKS(1000));

    }
}

