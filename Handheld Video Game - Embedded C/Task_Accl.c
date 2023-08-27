/*
 * task_accl.c
 *
 *  Created on: Dec 8, 2021
 *      Author: Neil Walsh
 */

#include "main.h"

TaskHandle_t Task_Accl_Bottom_Half_Handle;
TaskHandle_t Task_Accl_Timer_Handle;

/******************************************************************************
 * Used to start an ADC14 Conversion
 ******************************************************************************/
void Task_Accl_Timer(void *pvParameters)
{
    while (1)
    {
        //Start the ADC conversion
        ADC14->CTL0 |= ADC14_CTL0_SC | ADC14_CTL0_ENC;
        // Delay 50mS
        vTaskDelay(pdMS_TO_TICKS(LCD_update_ms));
    }
}

/**
 * Handle data from accl interrupt, returning in a queue the X and Y direction as an ENUM
 */
void Task_Accl_Bottom_Half(void *pvParameters)
{
    ACCL_MSG_t msg;

    int Xhigh1Thresh = ((int) (1.7 / (3.3 / 4096)));
    int Xlow1Thresh = ((int) (1.6 / (3.3 / 4096)));
    int Yhigh1Thresh = ((int) (1.7 / (3.3 / 4096)));
    int Ylow1Thresh = ((int) (1.6 / (3.3 / 4096)));

    int Xhigh2Thresh = ((int) (1.8 / (3.3 / 4096)));
    int Xlow2Thresh = ((int) (1.5 / (3.3 / 4096)));
    int Yhigh2Thresh = ((int) (1.8 / (3.3 / 4096)));
    int Ylow2Thresh = ((int) (1.5 / (3.3 / 4096)));

    int Xhigh3Thresh = ((int) (1.9 / (3.3 / 4096)));
    int Xlow3Thresh = ((int) (1.4 / (3.3 / 4096)));
    int Yhigh3Thresh = ((int) (1.9 / (3.3 / 4096)));
    int Ylow3Thresh = ((int) (1.4 / (3.3 / 4096)));

    while (1)
    {

        ulTaskNotifyTake(pdTRUE, portMAX_DELAY);

        // set x direction as one of 8 discrete directions or center

        // LEFT
        if ((ACCL_X_DIR < Xlow1Thresh) && (ACCL_Y_DIR < Yhigh1Thresh)
                && (ACCL_Y_DIR > Ylow1Thresh))
        {
            msg.dir = LEFT;
            if ((ACCL_X_DIR < Xlow2Thresh) && (ACCL_Y_DIR < Yhigh1Thresh)
                    && (ACCL_Y_DIR > Ylow1Thresh))
            {
                if ((ACCL_X_DIR < Xlow3Thresh) && (ACCL_Y_DIR < Yhigh1Thresh)
                        && (ACCL_Y_DIR > Ylow1Thresh))
                {
                    msg.spd = FAST;
                }
                else
                {
                    msg.spd = MED;
                }
            }
            else
            {
                msg.spd = SLOW;
            }
        }

        // RIGHT
        else if ((ACCL_X_DIR > Xhigh1Thresh) && (ACCL_Y_DIR < Yhigh1Thresh)
                && (ACCL_Y_DIR > Ylow1Thresh))
        {
            msg.dir = RIGHT;
            if ((ACCL_X_DIR > Xhigh2Thresh) && (ACCL_Y_DIR < Yhigh1Thresh)
                    && (ACCL_Y_DIR > Ylow1Thresh))
            {
                if ((ACCL_X_DIR > Xhigh3Thresh) && (ACCL_Y_DIR < Yhigh1Thresh)
                        && (ACCL_Y_DIR > Ylow1Thresh))
                {
                    msg.spd = FAST;
                }
                else
                {
                    msg.spd = MED;
                }
            }
            else
            {
                msg.spd = SLOW;
            }
        }

        // DOWN
        else if ((ACCL_Y_DIR < Ylow1Thresh) && (ACCL_X_DIR < Xhigh1Thresh)
                && (ACCL_X_DIR > Xlow1Thresh))
        {
            msg.dir = DOWN;
            if ((ACCL_Y_DIR < Ylow2Thresh) && (ACCL_X_DIR < Xhigh1Thresh)
                    && (ACCL_X_DIR > Xlow1Thresh))
            {
                if ((ACCL_Y_DIR < Ylow3Thresh) && (ACCL_X_DIR < Xhigh1Thresh)
                        && (ACCL_X_DIR > Xlow1Thresh))
                {
                    msg.spd = FAST;
                }
                else
                {
                    msg.spd = MED;
                }
            }
            else
            {
                msg.spd = SLOW;
            }
        }

        // UP
        else if ((ACCL_Y_DIR > Yhigh1Thresh) && (ACCL_X_DIR < Xhigh1Thresh)
                && (ACCL_X_DIR > Xlow1Thresh))
        {
            msg.dir = UP;
            if ((ACCL_Y_DIR > Yhigh2Thresh) && (ACCL_X_DIR < Xhigh1Thresh)
                    && (ACCL_X_DIR > Xlow1Thresh))
            {
                if ((ACCL_Y_DIR > Yhigh3Thresh) && (ACCL_X_DIR < Xhigh1Thresh)
                        && (ACCL_X_DIR > Xlow1Thresh))
                {
                    msg.spd = FAST;
                }
                else
                {
                    msg.spd = MED;
                }

            }
            else
            {
                msg.spd = SLOW;
            }
        }

        // DIAGONALS

        // DOWNRIGHT
        else if ((ACCL_X_DIR > Xhigh1Thresh) && (ACCL_Y_DIR < Ylow1Thresh))
        {
            msg.dir = DOWNRIGHT;
            if ((ACCL_X_DIR > Xhigh2Thresh) && (ACCL_Y_DIR < Ylow2Thresh))
            {
                if ((ACCL_X_DIR > Xhigh3Thresh) && (ACCL_Y_DIR < Ylow3Thresh))
                {
                    msg.spd = FAST;
                }
                else
                {
                    msg.spd = MED;
                }
            }
            else
            {
                msg.spd = SLOW;
            }
        }

        // DOWNLEFT
        else if ((ACCL_X_DIR < Xlow1Thresh) && (ACCL_Y_DIR < Ylow1Thresh))
        {
            msg.dir = DOWNLEFT;
            if ((ACCL_X_DIR < Xlow2Thresh) && (ACCL_Y_DIR < Ylow2Thresh))
            {
                if ((ACCL_X_DIR < Xlow3Thresh) && (ACCL_Y_DIR < Ylow3Thresh))
                {
                    msg.spd = FAST;
                }
                else
                {
                    msg.spd = MED;
                }
            }
            else
            {
                msg.spd = SLOW;
            }
        }
        // UPRIGHT
        else if ((ACCL_X_DIR > Xhigh1Thresh) && (ACCL_Y_DIR > Yhigh1Thresh))
        {
            msg.dir = UPRIGHT;
            if ((ACCL_X_DIR > Xhigh2Thresh) && (ACCL_Y_DIR > Yhigh2Thresh))
            {
                if ((ACCL_X_DIR > Xhigh3Thresh) && (ACCL_Y_DIR > Yhigh3Thresh))
                {
                    msg.spd = FAST;
                }
                else
                {
                    msg.spd = MED;
                }
            }
            else
            {
                msg.spd = SLOW;
            }
        }

        // UPLEFT
        else if ((ACCL_X_DIR < Xlow1Thresh) && (ACCL_Y_DIR > Yhigh1Thresh))
        {
            msg.dir = UPLEFT;
            if ((ACCL_X_DIR < Xlow2Thresh) && (ACCL_Y_DIR > Yhigh2Thresh))
            {
                if ((ACCL_X_DIR < Xlow3Thresh) && (ACCL_Y_DIR > Yhigh3Thresh))
                {
                    msg.spd = FAST;
                }
                else
                {
                    msg.spd = MED;
                }
            }
            else
            {
                msg.spd = SLOW;
            }
        }

        // CENTER
        else
        {
            msg.dir = CENTER;
        }

        xSemaphoreGive(Sem_LCD);
        xQueueSendToBack(Queue_Accl, &msg, portMAX_DELAY);

    }

}

/**
 * Top half of IRQ Handler, sends task notification to bottom half when new accl data is recieved
 */
void ADC14_IRQHandler(void)
{

    BaseType_t xHigherPriorityTaskWoken = pdFALSE;

    // Read the X channel
    ACCL_X_DIR = ADC14->MEM[0];

    // Read the Y channel
    ACCL_Y_DIR = ADC14->MEM[1];

    vTaskNotifyGiveFromISR(Task_Accl_Bottom_Half_Handle,
                           &xHigherPriorityTaskWoken);

    portYIELD_FROM_ISR(xHigherPriorityTaskWoken);

}
