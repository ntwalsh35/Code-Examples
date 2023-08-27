/*
 * buzzer.c
 *
 *  Created on: Dec 9, 2021
 *      Author: Nathaniel Tate
 */

#include "buzzer.h"

/*****************************************************
 * Sets the PWM period of the Buzzer.  The duty cycle
 * will be set to 50%
 *
 * Parameters
 *      ticks_period    :   Period of PWM Pulse
 * Returns
 *      None
 *****************************************************/
void buzzer_init(uint16_t ticks_period)
{
    // The buzzer needs to be be a GPIO OUTPUT Pin
    BUZZER_PORT->DIR |= BUZZER_PIN;

    // Configure the buzzer pin to be controlled by a TIMERA peripheral
    BUZZER_PORT->SEL0 |= BUZZER_PIN;
    BUZZER_PORT->SEL1 &= ~BUZZER_PIN;

    // Turn off timer
    BUZZER_TIMER->CTL = 0;

    // Set the period of the timer.
    BUZZER_TIMER->CCR[0] = ticks_period - 1;

    // Configure BUZZER Duty Cycle to 50%
    BUZZER_TIMER->CCR[BUZZER_CHANNEL] = (ticks_period /2 ) -1;

    // Configure buzzer pin for RESET/SET Mode
    BUZZER_TIMER->CCTL[BUZZER_CHANNEL] = TIMER_A_CCTLN_OUTMOD_7;

    // Select the master clock as the timer source
    BUZZER_TIMER->CTL = TIMER_A_CTL_SSEL__SMCLK;

}

void buzzer_sounds(int soundToPlay) {
    int i;
    switch (soundToPlay) {
    case 0: //Startup
            buzzer_init(160000);
            buzzer_on();
            for(i = 0; i<160000; i++);
            buzzer_off();

            for(i = 0; i<16*8000; i++);

            buzzer_init(16*8000);
            buzzer_on();
            for(i = 0; i<16*10000; i++);
            buzzer_off();

            for(i = 0; i<16*8000; i++);

            buzzer_init(16*6000);
            buzzer_on();
            for(i = 0; i<16*10000; i++);
            buzzer_off();

            buzzer_init(16* 4500);
            buzzer_on();
            for(i = 0; i<16* 25000; i++);
            buzzer_off();

        break;

    case 1: //Collision
            buzzer_init(16*8000);
            buzzer_on();
            for(i = 0; i<16*8000; i++);
            buzzer_off();

            for(i = 0; i<16*8000; i++);

            buzzer_init(16*10000);
            buzzer_on();
            for(i = 0; i<16*8000; i++);
            buzzer_off();
        break;

    case 2: //Game finished
            buzzer_init(16*10000);
            buzzer_on();
            for(i = 0; i<16*10000; i++);
            buzzer_off();

            for(i = 0; i<16*15000; i++);

            buzzer_init(16*10000);
            buzzer_on();
            for(i = 0; i<16*10000; i++);
            buzzer_off();

            for(i = 0; i<16*15000; i++);

            buzzer_init(16*6000);
            buzzer_on();
            for(i = 0; i<16*10000; i++);
            buzzer_off();

            for(i = 0; i<16*10000; i++);

            buzzer_init(16*12000);
            buzzer_on();
            for(i = 0; i<16*10000; i++);
            buzzer_off();
            break;

    case 3: //Player Died
            buzzer_init(16*8000);
            buzzer_on();
            for(i = 0; i<16*15000; i++);
            buzzer_off();

            for(i = 0; i<16*10000; i++);

            buzzer_init(16*10000);
            buzzer_on();
            for(i = 0; i<16*15000; i++);
            buzzer_off();

            buzzer_init(16*14000);
            buzzer_on();
            for(i = 0; i<16*25000; i++);
            buzzer_off();
            break;
    }
}

/*****************************************************
 * Turns the Buzzer on
 *
 * Parameters
 *      None
 * Returns
 *      None
 *****************************************************/
void buzzer_on(void)
{
    // Clear the current Mode Control Bits
    BUZZER_TIMER->CTL &= ~TIMER_A_CTL_MC_MASK;

    // Set Mode Control to UP and Clear the current count
    BUZZER_TIMER->CTL |= TIMER_A_CTL_MC__UP | TIMER_A_CTL_CLR;
}

/*****************************************************
 * Turns the Buzzer off
 *
 * Parameters
 *      None
 * Returns
 *      None
 *****************************************************/
void buzzer_off(void)
{
    // Turn off the timer
    BUZZER_TIMER->CTL &= ~TIMER_A_CTL_MC_MASK;
}

/*****************************************************
 * Check Buzzer Run Status
 *
 * Parameters
 *      None
 * Returns
 *      True  if TimerA is On.
 *      False if TimerA is Off
 *****************************************************/
bool buzzer_run_status(void)
{

    if( (BUZZER_TIMER->CTL & TIMER_A_CTL_MC_MASK) == TIMER_A_CTL_MC__STOP)
    {
        return false;
    }
    else
    {
        return true;
    }
}




