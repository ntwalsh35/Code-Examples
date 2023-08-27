/*
 * Task_enemy.c
 *
 *  Created on: Dec 10, 2021
 *      Author: Neil Walsh
 */

#include "main.h"

/**
 * Controls movement for enemies and checks for collisions.
 * Enemies will start at the top of the screen in a pseudo random x location
 * and descend slowly, increasing in speed as the levels increase.
 *
 * If a collision is detected the game ends
 *
 */
void Task_enemy(void *pvParameters)
{
    int i;
    int jumpSize = 1;

    while (1)
    {
        xSemaphoreTake(Sem_LCD, portMAX_DELAY);
        for (i = 0; i < 3; i++)
        {
            // move enemies
            enemiesList[i].enemyY += jumpSize;
            lcd_draw_image(enemiesList[i].enemyX, enemiesList[i].enemyY,
                           enemyWidthPixels, enemyHeightPixels, enemyBitmaps,
                           enemiesList[i].enemyColor, backColor);

            // once enemy hits bottom of screen give it a new random color and x position and start it again from the top
            if (enemiesList[i].enemyY >= (132 - (enemyHeightPixels / 2) + 1))
            {
                enemiesList[i].enemyY = 0 - enemyHeightPixels / 2;
                enemiesList[i].enemyX = (rand()
                        % ((132 - enemyWidthPixels / 2) - (enemyWidthPixels / 2)
                                + 1)) + enemyWidthPixels / 2;
                enemiesList[i].x1 = enemiesList[i].enemyX
                        - (enemyWidthPixels / 2 - 1);
                enemiesList[i].x2 = enemiesList[i].enemyX
                        + (enemyWidthPixels / 2 - 1);
                enemiesList[i].y1 = enemiesList[i].enemyY
                        - (enemyHeightPixels / 2 - 1);
                enemiesList[i].y2 = enemiesList[i].enemyY
                        + (enemyHeightPixels / 2 - 1);
                enemiesList[i].enemyColor = rand() % 0xFFFF;
                enemiesDefeated++;
            }

            // set corners for collisions
            enemiesList[i].y1++;
            enemiesList[i].y2++;

            // detect collision
            if (((enemiesList[i].x1 >= ghostLoc.x1
                    && enemiesList[i].x1 <= ghostLoc.x2)
                    && (enemiesList[i].y1 >= ghostLoc.y1
                            && enemiesList[i].y1 <= ghostLoc.y2))
                    || ((enemiesList[i].x2 >= ghostLoc.x1
                            && enemiesList[i].x2 <= ghostLoc.x2)
                            && (enemiesList[i].y1 >= ghostLoc.y1
                                    && enemiesList[i].y1 <= ghostLoc.y2))
                    || ((enemiesList[i].x1 >= ghostLoc.x1
                            && enemiesList[i].x1 <= ghostLoc.x2)
                            && (enemiesList[i].y2 >= ghostLoc.y1
                                    && enemiesList[i].y2 <= ghostLoc.y2))
                    || ((enemiesList[i].x2 >= ghostLoc.x1
                            && enemiesList[i].x2 <= ghostLoc.x2)
                            && (enemiesList[i].y2 >= ghostLoc.y1
                                    && enemiesList[i].y2 <= ghostLoc.y2)))
            {
                // SIGNIFY LOSS
                lcd_draw_image(66, 66, 132, 132, gameOverBitmaps, backColor,
                               0xF800);
                int sound = 3; // player died
                buzzer_sounds(sound);
                playerDied();
                endOfGame();

                // end freeRTOS
                vTaskEndScheduler();
            }

        }

        xSemaphoreGive(Sem_LCD);

        // delay to make enemies descend in a choppy way in the arcade style
        // and also allow Task_animate to access LCD
        // the enemies will gently speed up as the game goes on
        int delay;
        if (enemiesDefeated < 5)
        {
            delay = 300;
            //levelUp();
            lcd_draw_image(66, 122, level1WidthPixels, level1HeightPixels,
                           level1Bitmaps, backColor, lvlColor);
        }
        else if (enemiesDefeated < 10)
        {
            delay = 200;
            lcd_draw_image(66, 122, level2WidthPixels, level2HeightPixels,
                           level2Bitmaps, backColor, lvlColor);
        }
        else if (enemiesDefeated < 20)
        {
            delay = 100;
            lcd_draw_image(66, 122, level2WidthPixels, level2HeightPixels,
                           level3Bitmaps, backColor, lvlColor);
        }
        else if (enemiesDefeated < 25)
        {
            delay = 50;
            lcd_draw_image(66, 122, level2WidthPixels, level2HeightPixels,
                           level4Bitmaps, backColor, lvlColor);

        }
        else
        {
            delay = 30;
            lcd_draw_image(66, 122, level2WidthPixels, level2HeightPixels,
                           level5Bitmaps, backColor, lvlColor);
        }
        vTaskDelay(pdMS_TO_TICKS(delay));

    }
}

/**
 * Initializes the 3 enemies that will scroll throughout the game
 * Gives them x and Y coordinates and sets corner locations for collision checking
 */
void enemy_init()
{
    enemiesDefeated = 0;
    int i;
// create 3 enemies
    for (i = 0; i < 3; i++)
    {
        enemy_t newEnemy;
        newEnemy.enemyX = (rand()
                % ((132 - enemyWidthPixels / 2) - (enemyWidthPixels / 2) + 1))
                + enemyWidthPixels / 2;

        newEnemy.enemyColor = rand() % 0xFFFE + 1;
        enemiesList[i] = newEnemy;
    }

// stagger 3 yVals so the enemies are staggered in the game
    enemiesList[0].enemyY = 0 - enemyHeightPixels / 2;
    enemiesList[1].enemyY = 0 - enemyHeightPixels / 2 - 50;
    enemiesList[2].enemyY = 0 - enemyHeightPixels / 2 - 110;

    for (i = 0; i < 3; i++)
    {
        // set corners for collisions
        enemiesList[i].x1 = enemiesList[i].enemyX - (enemyWidthPixels / 2 - 1);
        enemiesList[i].x2 = enemiesList[i].enemyX + (enemyWidthPixels / 2 - 1);
        enemiesList[i].y1 = enemiesList[i].enemyY - (enemyHeightPixels / 2 - 1);
        enemiesList[i].y2 = enemiesList[i].enemyY + (enemyHeightPixels / 2 - 1);
    }
}
