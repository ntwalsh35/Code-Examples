/*
 * Task_enemy.h
 *
 *  Created on: Dec 10, 2021
 *      Author: Neil Walsh
 */

#ifndef TASK_ENEMY_H_
#define TASK_ENEMY_H_

/**
 * Represents each enemy with center X, center Y, color and
 * 4 corners for collision checking
 */
typedef struct
{
    int enemyX;
    int enemyY;
    int x1, x2, y1, y2; // corners for collision checking
    uint16_t enemyColor;
} enemy_t;

// num of enemies dodged by ghosty
volatile int enemiesDefeated;

// simple array to keep track of enemies in game
enemy_t enemiesList[3];

// color of level display
volatile uint16_t lvlColor;

TaskHandle_t Task_enemy_Handle;

/**
 * Controls movement for enemies and checks for collisions.
 * Enemies will start at the top of the screen in a pseudo random x location
 * and descend slowly, increasing in speed as the levels increase.
 *
 * If a collision is detected the game ends
 *
 */
void Task_enemy(void *pvParameters);

/**
 * Initializes the 3 enemies that will scroll throughout the game
 * Gives them x and Y coordinates and sets corner locations for collision checking
 */
void enemy_init(void);

#endif /* TASK_ENEMY_H_ */
