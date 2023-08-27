/*
 * Task_animate.c
 *
 *  Created on: Dec 8, 2021
 *      Author: Neil Walsh
 */

#include "main.h"

/**
 * Animates ghost character using data taken from queue sent by Task_accl
 * keeps the ghost on the screen and adjusts data for corners stored in
 * ghostLocation struct for collision checking
 */
void Task_animate(void *pvParameters)
{
    BaseType_t status;
    ACCL_MSG_t msg;

    int jumpSize = 1; // distance moved in each movement

    // starting position
    int xVal = 66;
    int yVal = 132 - 18 - ghostHeightPixels / 2;

    // screen boundaries
    int yHighBound = 132 - (ghostHeightPixels / 2) - 1 - level1HeightPixels;
    int yLowBound = ghostHeightPixels / 2 + 1;
    int xHighBound = 132 - (ghostWidthPixels / 2) - 1;
    int xLowBound = ghostWidthPixels / 2 + 1;

    while (1)
    {
        xSemaphoreTake(Sem_LCD, portMAX_DELAY);

        status = xQueueReceive(Queue_Accl, &msg, portMAX_DELAY);

        if (status != pdPASS)
        {
            while (1)
            {
            };
        }

        switch (msg.dir)
        {
        case RIGHT:
            //ece353_MKII_RGB_LED(true, false, false);
            xVal += jumpSize;
            break;
        case LEFT:
            //ece353_MKII_RGB_LED(false, false, true);
            xVal -= jumpSize;
            break;
        case UP:
            //ece353_MKII_RGB_LED(false, true, false);
            yVal -= jumpSize;
            break;
        case DOWN:
            //ece353_MKII_RGB_LED(true, false, true);
            yVal += jumpSize;
            break;
        case DOWNRIGHT:
            //ece353_MKII_RGB_LED(true, false, false);
            xVal += jumpSize;
            yVal += jumpSize;
            break;
        case DOWNLEFT:
            //ece353_MKII_RGB_LED(false, false, true);
            xVal -= jumpSize;
            yVal += jumpSize;
            break;
        case UPRIGHT:
            //ece353_MKII_RGB_LED(false, true, false);
            yVal -= jumpSize;
            xVal += jumpSize;
            break;
        case UPLEFT:
            //ece353_MKII_RGB_LED(true, false, true);
            yVal -= jumpSize;
            xVal -= jumpSize;
            break;

        case CENTER:
            ece353_MKII_RGB_LED(false, false, false);
            break;
        }

        // keep the image on the screen
        if (yVal < yLowBound)
        {
            yVal = yLowBound;
        }
        if (yVal > yHighBound)
        {
            yVal = yHighBound;
        }
        if (xVal < xLowBound)
        {
            xVal = xLowBound;
        }
        if (xVal > xHighBound)
        {
            xVal = xHighBound;
        }

        // update corners
        ghostLoc.x1 = xVal - (ghostWidthPixels / 2 - 1);
        ghostLoc.x2 = xVal + (ghostWidthPixels / 2 - 1);
        ghostLoc.y1 = yVal - (ghostHeightPixels / 2 - 1);
        ghostLoc.y2 = yVal + (ghostHeightPixels / 2 - 1);

        // draw image
        lcd_draw_image((int) xVal, (int) yVal, ghostWidthPixels,
                       ghostHeightPixels, ghostBitmaps, charColor, backColor);
        xSemaphoreGive(Sem_LCD);

    }
}

