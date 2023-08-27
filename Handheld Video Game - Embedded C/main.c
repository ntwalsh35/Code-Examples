/**
 * Authors: Neil Walsh and Nate Tate
 */

/*
 * Copyright (c) 2016-2019, Texas Instruments Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 *  ======== main_freertos.c ========
 */
#include "main.h"

/*
 * Starting function to clean up main()
 * initializes all resources, creates necessary tasks, starts scheduler
 */
void init_all(void)
{
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;     // stop watchdog timer

    // set Accl speed
    LCD_update_ms = 10;

    // set colors
    charColor = 0x07F0;
    backColor = 0x0000;
    lvlColor = 0x77FF;
    titleColor = 0x4628;

    // init all resources
    LCD_init();
    ece353_universal_init(false);
    enemy_init();
    serial_debug_init();
    buzzer_init(8000);
    opt3001_init();

    // enable interrupts
    __enable_irq();

    // create all tasks
    xTaskCreate(Task_Accl_Bottom_Half, "Task_Accl",
    configMINIMAL_STACK_SIZE,
                NULL, 2, &Task_Accl_Bottom_Half_Handle);
    xTaskCreate(Task_animate, "Task_animate",
    configMINIMAL_STACK_SIZE,
                NULL, 3, &Task_animate_Handle);
    xTaskCreate(Task_Accl_Timer, "Task_Accl_Timer",
    configMINIMAL_STACK_SIZE,
                NULL, 2, &Task_Accl_Timer_Handle);
    xTaskCreate(Task_enemy, "Task_enemy",
    configMINIMAL_STACK_SIZE,
                NULL, 3, &Task_enemy_Handle);
    xTaskCreate(Task_Light, "Task_Light", configMINIMAL_STACK_SIZE, NULL, 2,
                &Task_LIGHT_Handle);

    // Create semaphores
    Sem_LCD = xSemaphoreCreateBinary();
    xSemaphoreGive(Sem_LCD);

    Sem_UART = xSemaphoreCreateBinary();
    xSemaphoreGive(Sem_UART);

    enemiesDefeated = 0;

    // create queues
    Queue_Accl = xQueueCreate(10, sizeof(ACCL_MSG_t));
    Queue_Buzzer = xQueueCreate(2, sizeof(int));

    // display title screen
    lcd_draw_image(66, 66, 132, 132, titleScreenBitmaps, backColor, titleColor);
    buzzer_sounds(0); // startup sound
    startup();

    while (!debounce_s1())
    {
    };

    buzzer_sounds(1); // startup/button sound
    startOfGame();
    lcd_draw_image(66, 66, 132, 132, clearScreenBitmaps, backColor, titleColor);
    // start scheduler
    vTaskStartScheduler();
}

/*
 *  ======== main ========
 */
int main(void)
{
    init_all();

    while (1)
    {

    };
}

//*****************************************************************************
//
//! \brief Application defined malloc failed hook
//!
//! \param  none
//!
//! \return none
//!
//*****************************************************************************
void vApplicationMallocFailedHook()
{
    /* Handle Memory Allocation Errors */
    while (1)
    {
    }
}

//*****************************************************************************
//
//! \brief Application defined stack overflow hook
//!
//! \param  none
//!
//! \return none
//!
//*****************************************************************************
void vApplicationStackOverflowHook(TaskHandle_t pxTask, char *pcTaskName)
{
    //Handle FreeRTOS Stack Overflow
    while (1)
    {
    }
}
