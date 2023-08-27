/*
 * UART.c
 *
 *  Created on: Dec 12, 2021
 *      Author: Nate Tate
 */

#include "main.h"

/**
 * Uart message displayed at startup of game
 */
void startup(void)
{
    printf("\n\r\n\r");
    printf("*********************************************\n\r");
    printf("Welcome to Ghoster!!\n\r");
    printf("Your goal is to dodge as many enemy block ghosts as you can.\n\r");
    printf("To do so, tilt your game pad in any direction to make Ghosty move.\n\r");
    printf("If you collide with an enemy, your game is over.\n\r");
    printf("Good luck! You'll need it!\n\r");
    printf("Press S1 to start!\n\r");
    printf("*********************************************\n\r");
    printf("\n\r");
}

/**
 * Uart message displayed at start of game after s1 is pressed
 */
void startOfGame(void)
{
    printf("\n\r");
    printf("*********************************************\n\r");
    printf("Your game has now begun!\n\r");
    printf("Dodge the enemy ghosts before they hit you!\n\r");
    printf("You should probably stop reading now and play the game...\n\r");
    printf("*********************************************\n\r");
    printf("\n\r");
}

/**
 * Uart message displayed at player death
 */
void playerDied(void)
{
    printf("\n\r");
    printf("*********************************************\n\r");
    printf("You feel something pass through your ghostly body\n\r");
    printf("Hm.......it feels strange\n\r");
    printf("*********************************************\n\r");
    printf("\n\r");
}

/**
 * Uart message displayed at finish of game
 */
void endOfGame(void)
{
    printf("\n\r");
    printf("*********************************************\n\r");
    printf("OH NO! You've been struck by an enemy!!\n\r");
    printf("However you dodged ");

    char enemiesStr[4];
    sprintf(enemiesStr, "%i", enemiesDefeated);
    printf(enemiesStr);
    printf(" enemies!!\n\r");
    printf("Sadly your game is now over :(\n\r");
    printf("Press reset to play again!\n\r");
    printf("*********************************************\n\r");
    printf("\n\r");
}

