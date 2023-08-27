/*
 * UART.h
 *
 *  Created on: Dec 13, 2021
 *      Author: Nate Tate
 */
#include "main.h"

#ifndef UART_H_
#define UART_H_

volatile uint16_t titleColor;

/**
 * Uart message displayed at startup of game
 */
void startup(void);

/**
 * Uart message displayed at start of game after s1 is pressed
 */
void startOfGame(void);

/**
 * Uart message displayed at player death
 */
void playerDied(void);

/**
 * Uart message displayed at finish of game
 */
void endOfGame(void);



#endif /* UART_H_ */
