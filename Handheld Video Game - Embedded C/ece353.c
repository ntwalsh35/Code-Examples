#include "ece353.h"
//****************************************************
//****************************************************
// 02-Ex-Code-Organization
//****************************************************
//****************************************************

/* ***************************************************
 * Initialize hardware resources used to control LED1
 *****************************************************/
void ece353_led1_init(void) {
    P1->DIR |= BIT0; //set direction as an output
    P1->OUT &= ~BIT0; //turn off led
}

/*****************************************************
 * Initialize hardware resources used to control Button1
 *****************************************************/
void ece353_button1_init(void) {
    P1->DIR &= ~BIT1; //set to input
    P1->REN |= BIT1; //enable resistor
    P1->OUT |= BIT1; //select pull-up
}

/*****************************************************
 * Initialize hardware resources used to control S1
 *****************************************************/
void ece353_S1_init(void) {
    P5->DIR &= ~BIT1; //set to input
    P5->REN |= BIT1; //enable resistor
    P5->OUT |= BIT1; //select pull-up
}

/*****************************************************
 * Returns if S1 is currently pressed.
 *
 * Parameters
 *
 * Returns
 *      true    :   S1 is pressed
 *      false   :   S1 is NOT pressed
 *****************************************************/
bool ece353_S1(void) {
    if((P5->IN & BIT1) == 0) {
        return true;
    } else {
        return false;
    }
}

/*****************************************************
 * Turn LED1 ON/Off.
 *
 * Parameters
 *  on: if true,  turn LED on
 *      if false, turn LED off
 *****************************************************/
void ece353_led1(bool on) {
    if(on) {
        P1->OUT |= BIT0; //turn led on
    } else {
        P1->OUT&= ~BIT0; //turn led off
    }
}

/*****************************************************
 * Returns if Button1 is currently pressed.
 *
 * Parameters
 *
 * Returns
 *      true    :   Button1 is pressed
 *      false   :   Button1 is NOT pressed
 *****************************************************/
bool ece353_button1(void) {
    if((P1->IN & BIT1) == 0) {
        return true;
    } else {
        return false;
    }
}



//****************************************************
//****************************************************
// 02-ICE-Code-Organization
//****************************************************
//****************************************************

/*****************************************************
 * Initialize hardware resources used to control RGBLED
 *****************************************************/
void ece353_rgb_init(void) {
    P2->DIR |= BIT0;    //LED_RED Enable
    P2->DIR |= BIT1;    //LED_GREEN Enable
    P2->DIR |= BIT2;    //LED_BLUE Enable
}

/*****************************************************
 * Turn RGBLED ON/Off.
 *
 * Parameters
 *  red_on      :   if true,  turn RGBLED.RED on
 *                  if false, turn RGBLED.RED off
 *  green_on    :   if true,  turn RGBLED.GREEN on
 *                  if false, turn RGBLED.GREEN off
 *  blue_on     :   if true,  turn RGBLED.BLUE on
 *                  if false, turn RGBLED.BLUE off
 *****************************************************/
void ece353_rgb(bool red_on, bool green_on, bool blue_on)
{
    if(red_on) {
        P2->OUT |= BIT0;
    } else {
        P2->OUT &= ~BIT0;
    }

    if(green_on) {
            P2->OUT |= BIT1;
    } else {
        P2->OUT &= ~BIT1;
    }

    if(blue_on) {
            P2->OUT |= BIT2;
    } else {
        P2->OUT &= ~BIT2;
    }
}

/*****************************************************
 * Initialize hardware resources used to control Button2
 *****************************************************/
void ece353_button2_init(void)
{
    P1->DIR &= ~BIT4; //set to input
    P1->REN |= BIT4; //enable resistor
    P1->OUT |= BIT4; //select pull-up
}

/*****************************************************
 * Returns if Button2 is currently pressed.
 *
 * Parameters
 *
 * Returns
 *      true    :   Button2 is pressed
 *      false   :   Button2 is NOT pressed
 *****************************************************/
bool ece353_button2(void) {
    if((P1->IN & BIT4) == 0) {
        return true;
    } else {
        return false;
    }
}

//*****************************************************************************
//*****************************************************************************
// ICE 03 - Timer32_1 Push Button Detection
//*****************************************************************************
//*****************************************************************************

/*****************************************************
 * Busy waits for 100mS and then returns.
 *
 * Timer32_1 MUST be configured as a 16-bit timer.
 * Assume that the MCU clock runs at 3MHz.  You will
 * need to use a pre-scalar in order to achieve a delay
 * of 100mS.
 *
 * Parameters:
 *      None
 * Returns
 *      None
 *****************************************************/
void ece353_T32_1_wait_100mS(void) {
    //Stop the timer
    TIMER32_1->CONTROL = 0;

    //Set the timer to be a 16-bit, one-shot with prescale of 16
    TIMER32_1->CONTROL = TIMER32_CONTROL_ONESHOT | TIMER32_CONTROL_PRESCALE_1;

    //Set the load register
    TIMER32_1->LOAD = 18750;

    //Start the timer
    TIMER32_1->CONTROL |= TIMER32_CONTROL_ENABLE;

    //Wait until it reaches 0
    while(TIMER32_1->VALUE != 0){
        //Timer is still counting, so wait
        }
}


/*****************************************************
 * Debounces Button1 using Timer32_1.
 * This function does not return until Button 1 has
 * been pressed for a minimum of 5 seconds.
 *
 * Waiting 5 Seconds will require you to call
 * ece353_T32_1_wait_100mS multiple times.
 *
 * Parameters
 *      None
 * Returns
 *      None
 *****************************************************/
void ece353_button1_wait_for_press(void) {
    bool heldForFive = false; //if held for five, heldForFive will equal true
    while(1){
        int i = 0;
        for(i = 0; i < 50; i++) {
            ece353_T32_1_wait_100mS();
            if(!ece353_button1()){
                break;
            }
            if(i == 49) {
                heldForFive = true;
            }
        }
        if(heldForFive) {
            return;
        }
    }
}

//*****************************************************************************
//*****************************************************************************
// ICE 04 - PWMing MKII tri-color LED.
//*****************************************************************************
//*****************************************************************************

/*****************************************************
 * Initialize the 3 GPIO pins that control the RGB
 * LED on the MKII.
 *
 * Parameters
 *      None
 * Returns
 *      None
 *****************************************************/
void ece353_MKII_RGB_IO_Init(bool en_primary_function)
{

    // Complete the comments below to identify which pins
    // control which LEDs.
    //
    // Replace a and c with the correct port number
    // Replace b and d with the correct pin numbers.
    // RED      : P2.6
    // GREEN    : P2.4
    // BLUE     : P5.6

    // ADD CODE that configures the RED, GREEN, and
    // BLUE LEDs to be outputs

    P2->DIR |= BIT6;
    P2->DIR |= BIT4;
    P5->DIR |= BIT6;



    // ADD CODE that selects the Primary module function
    // for all 3 pins
    if(en_primary_function)
    {
        P2->SEL0 |= BIT6;
        P2->SEL1 &= ~BIT6;

        P2->SEL0 |= BIT4;
        P2->SEL1 &= ~BIT4;

        P5->SEL0 |= BIT6;
        P5->SEL1 &= ~BIT6;
    }

}

/*****************************************************
 * Sets the PWM levels for the MKII RGBLED
 *
 * Parameters
 *      ticks_period    :   Period of PWM Pulse
 *      red_num         :   RED RGB Number
 *      green_num       :   GREEN RGB Number
 *      blue_num        :   BLUE RGB Number
 * Returns
 *      None
 *****************************************************/
void ece353_MKII_RGB_PWM(
        uint16_t ticks_period,
        uint16_t red_num,
        uint16_t green_num,
        uint16_t blue_num
)
{
    // This code converts the HTML color codes into a
    // number of clock ticks used to generate the duty cyle of
    // the PWM signal.
    uint16_t ticks_red_on = (red_num * ticks_period)/255;
    uint16_t ticks_green_on = (green_num * ticks_period)/255;
    uint16_t ticks_blue_on = (blue_num * ticks_period)/255;

    // Initialze the IO pins used to control the
    // tri-color LED.
    ece353_MKII_RGB_IO_Init(true);

    // Complete the comments below that identify which
    // TimerA outputs will control the IO pins.
    //
    // Replace w and y with the correct TimerA number
    // Replace x and z with the correct CCR number.
    // RED      <--> TA0.3
    // GREEN    <--> TA0.1
    // BLUE     <--> TA2.1

    // ADD CODE BELOW
    //
    // Turn off the timer peripherals
    TIMER_A0->CTL = 0;
    TIMER_A2->CTL = 0;

    // Set the period for both TimerA peripherals.
    TIMER_A0->CCR[0] = ticks_period - 1;
    TIMER_A2->CCR[0] = ticks_period - 1;
    // Configure RED PWM duty cycle
    TIMER_A0->CCR[3] = ticks_red_on - 1;
    // Configure GREEN PWM duty cycle
    TIMER_A0->CCR[1] = ticks_green_on - 1;
    // Configure BLUE PWM duty cycle
    TIMER_A2->CCR[1] = ticks_blue_on - 1;
    // Set the OUT MODE to be mode 7 for each
    // PWM output
    TIMER_A0->CCTL[3] = TIMER_A_CCTLN_OUTMOD_7;
    TIMER_A0->CCTL[1] = TIMER_A_CCTLN_OUTMOD_7;
    TIMER_A2->CCTL[1] = TIMER_A_CCTLN_OUTMOD_7;
    // Turn the first TimerA peripheral.  Use SMCLK as the clock source
    TIMER_A0->CTL = TIMER_A_CTL_SSEL__SMCLK;
    TIMER_A0->CTL |= TIMER_A_CTL_MC__UP;
    TIMER_A0->CTL |= TIMER_A_CTL_CLR;
    // Turn the second TimerA peripheral.  Use SMCLK as the clock source
    TIMER_A2->CTL = TIMER_A_CTL_SSEL__SMCLK;
    TIMER_A2->CTL |= TIMER_A_CTL_MC__UP;
    TIMER_A2->CTL |= TIMER_A_CTL_CLR;
}

//*****************************************************************************
//*****************************************************************************
// ICE 06 - ADC14
//*****************************************************************************

/******************************************************************************
 * Configure the IO pins for BOTH the X and Y directions of the analog
 * joystick.  The X direction should be configured to place the results in
 * MEM[0].  The Y direction should be configured to place the results in MEM[1].
 *
 * After BOTH analog signals have finished being converted, a SINGLE interrupt
 * should be generated.
 *
 * Parameters
 *      None
 * Returns
 *      None
 ******************************************************************************/
void ece353_ADC14_PS2_XY(void)
{
    // Configure the X direction as an analog input pin.
    P6->SEL0 |= BIT0;
    P6->SEL1 |= BIT0;
    // Configure the Y direction as an analog input pin.
    P4->SEL0 |= BIT4;
    P4->SEL1 |= BIT4;
    // Configure CTL0 to sample 16-times in pulsed sample mode.
    // NEW -- Indicate that this is a sequence-of-channels.
    ADC14->CTL0 = ADC14_CTL0_SHP | ADC14_CTL0_SHT02;
    ADC14->CTL0 |= ADC14_CTL0_CONSEQ_1;

    // Configure ADC to return 12-bit values
    ADC14->CTL1 &= ~ADC14_CTL1_RES_MASK;
    ADC14->CTL1 |= ADC14_CTL1_RES__12BIT;
    // Associate the X direction analog signal with MEM[0]
    ADC14->MCTL[0] = ADC14_MCTLN_INCH_15;
    // Associate the Y direction analog signal with MEM[1]
    ADC14->MCTL[1] = ADC14_MCTLN_INCH_9;
    // NEW -- Make sure to indicate this is the end of a sequence.
    ADC14->MCTL[1] |= ADC14_MCTLN_EOS;
    // Enable interrupts in the ADC AFTER a value is written into MEM[1].
        // NEW: This is not the same as what is demonstrated in the example
        // coding video.
    ADC14->IER0 = ADC14_IER0_IE1;

    // Enable ADC Interrupt in the NVIC
    NVIC_EnableIRQ(ADC14_IRQn);

    // Turn ADC ON
    ADC14->CTL0 |= ADC14_CTL0_ON;
}

/*****************************************************
 * Turn RGB on the MKII LED ON/Off.
 *
 * Parameters
 *  red:    if true,  turn RED LED on
 *          if false, turn RED LED off
 *  green:  if true,  turn GREEN LED on
 *          if false, turn GREEN LED off
 *  blue:   if true,  turn BLUE LED on
 *          if false, turn BLUE LED off
 *****************************************************/
void ece353_MKII_RGB_LED(bool red, bool green, bool blue)
{
    {
        if(red) {
            P2->OUT |= BIT6;
        } else {
            P2->OUT &= ~BIT6;
        }

        if(green) {
                P2->OUT |= BIT4;
        } else {
            P2->OUT &= ~BIT4;
        }

        if(blue) {
                P5->OUT |= BIT6;
        } else {
            P5->OUT &= ~BIT6;
        }
    }
}

//void ece353_RGB_LED_Init() {
//    P2->DIR |= BIT6;    //LED_RED Enable
//    P2->DIR |= BIT4;    //LED_GREEN Enable
//    P5->DIR |= BIT6;    //LED_BLUE Enable
//}

//Configures Timer32_1 to generate a periodic interrupt
//Parameters: ms = number of milliseconds per interrupt
void ece353_T32_1_Interrupt_Ms(uint16_t ms) {
    uint32_t ticks = (SystemCoreClock * ms)/1000 - 1;

    TIMER32_1->CONTROL = 0;

    TIMER32_1->LOAD = ticks;

    __enable_irq();
    NVIC_EnableIRQ(T32_INT1_IRQn);
    NVIC_SetPriority(T32_INT1_IRQn, 0);

    TIMER32_1->CONTROL = TIMER32_CONTROL_ENABLE | TIMER32_CONTROL_MODE | TIMER32_CONTROL_SIZE | TIMER32_CONTROL_IE;
}

//*****************************************************************************
//*****************************************************************************
// ICE 07 - ADC14 Comparator
//*****************************************************************************
#define VOLT_0P85 1056      // 0.85 /(3.3/4096)
#define VOLT_2P50 3103      // 2.50 /(3.3/4096)

/******************************************************************************
 * Configure the IO pins for the X direction of the analog
 * joystick.  The X direction should be configured to place the results in
 * MEM[0].
 *
 * The ADC14 should be configured to generate interrupts using the Window
 * comparator.  The HI0 threshold should be set to 2.5V.  The LO0 threshold
 * should be set to 0.85V.
 *
 * Parameters
 *      None
 * Returns
 *      None
 ******************************************************************************/
void ece353_ADC14_PS2_XY_COMP(void)
{
    // Configure the X direction as an analog input pin.
    P6->SEL0 |= BIT0;
    P6->SEL1 |= BIT0;
    // Configure CTL0 to sample 16-times in pulsed sample mode.
    // Indicate that this is a sequence of samples.
    ADC14->CTL0 = ADC14_CTL0_SHP | ADC14_CTL0_SHT02;
    ADC14->CTL0 |= ADC14_CTL0_CONSEQ_1;
    // Configure CTL1 to return 12-bit values
    ADC14->CTL1 &= ~ADC14_CTL1_RES_MASK;
    ADC14->CTL1 |= ADC14_CTL1_RES__12BIT;
    // Set up the HI0 Window
    ADC14->HI0 = VOLT_2P50;
    // Set up the LO0 Window
    ADC14->LO0 = VOLT_0P85;
    // Associate the X direction analog signal with MEM[0], indicate the end of sequence,
    // turn on the window comparator
    ADC14->MCTL[0] = ADC14_MCTLN_INCH_15;
    ADC14->MCTL[0] |= ADC14_MCTLN_EOS;
    ADC14->MCTL[0] |= ADC14_MCTLN_WINC;
    // Enable interrupts when either the HI or LO thresholds of the window
    // comparator has been exceeded.  Disable all other interrupts
    ADC14->IER1 = ADC14_IER1_HIIE;
    ADC14->IER1 |= ADC14_IER1_LOIE;
    // Enable ADC Interrupt
    NVIC_EnableIRQ(ADC14_IRQn);

    // Turn ADC ON
    ADC14->CTL0 |= ADC14_CTL0_ON;

}

void ece353_ADC14_ACCL_Init(void)
{
    // Configure P6.1 (A15) the X direction as an analog input pin
    P6->SEL0 |= BIT1;
    P6->SEL1 |= BIT1;

    // config y dir
    P4->SEL0 |= BIT0;
    P4->SEL1 |= BIT0;

    // Config Z dir
    P4->SEL0 |= BIT2;
    P4->SEL1 |= BIT2;

    // Configure the ADC14 Control Registers
    // Sample time of 16 ADC cycles for the first 8 analog channels
    // Allow the ADC timer to control pulsed samples

    ADC14->CTL0 = ADC14_CTL0_SHP | ADC14_CTL0_SHT02 | ADC14_CTL0_CONSEQ_1;

    // use sampling timer, 12-bit conversion results
    // More bits -> more accurate, slower and vice versa
    ADC14->CTL1 = ADC14_CTL1_RES_2;

    // Configure Memory Control register so that we assosciate the
    // correct analog channel with MEM[0]
    ADC14->MCTL[0] = ADC14_MCTLN_INCH_14; // x dir

    ADC14->MCTL[1] = ADC14_MCTLN_INCH_13; // y dir

    ADC14->MCTL[2] = ADC14_MCTLN_INCH_11 | ADC14_MCTLN_EOS; // z dir

    // Enable inputs after the conversion of MEM[0] completes
    ADC14->IER0 = ADC14_IER0_IE1;

    // Enable ADC interrupt
    NVIC_EnableIRQ(ADC14_IRQn);

    NVIC_SetPriority(ADC14_IRQn, 3);

    // Turn ADC On
    ADC14->CTL0 |= ADC14_CTL0_ON;
    ADC14->CTL0 |= ADC14_CTL0_ENC;
}

/******************************************************************************
 * De-bounce switch S1.
 *****************************************************************************/
bool debounce_s1(void)
{
    static uint8_t debounce_state = 0x00;

    // Shift the de-bounce variable to the left
    debounce_state = debounce_state << 1;

    // If S1 is being pressed, set the LSBit of debounce_state to a 1;
    if(ece353_S1())
    {
        debounce_state |= 0x01;
    }

    // If the de-bounce variable is equal to 0x7F, change the color of the tri-color LED.
    if(debounce_state == 0x7F)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/**
 * Function that calls all init functions within ece353.c
 */
void ece353_universal_init(bool MKII_en_primary_function) {
    ece353_MKII_RGB_IO_Init(MKII_en_primary_function);
    ece353_button2_init();
    ece353_led1_init();
    ece353_S1_init();
    ece353_button1_init();
    ece353_rgb_init();
    ece353_button2_init();
    ece353_ADC14_ACCL_Init();
    ece353_rgb(false, false, false);
}

