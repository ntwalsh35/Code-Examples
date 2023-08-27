/*
 * level4.c
 *
 *  Created on: Dec 12, 2021
 *      Author: ntwal
 */

#include "main.h"
/*
**  Image data for level4
*/

const uint8_t level4Bitmaps[] =
{
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, // ####################################################################################################################################
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, // ####################################################################################################################################
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, // ####################################################################################################################################
    0xFF, 0xFF, 0xFF, 0xFF, 0xF3, 0xFC, 0x03, 0x3F, 0x30, 0x0E, 0x7F, 0xFF, 0xE7, 0xFF, 0xFF, 0xFF, 0xF0, // ####################################  ########        ##  ######  ##        ###  ##################  ###############################
    0xFF, 0xFF, 0xFF, 0xFF, 0xF3, 0xFC, 0xFF, 0x3F, 0x33, 0xFE, 0x7F, 0xFF, 0xE7, 0xFF, 0xFF, 0xFF, 0xF0, // ####################################  ########  ########  ######  ##  #########  ##################  ###############################
    0xFF, 0xFF, 0xFF, 0xFF, 0xE7, 0xF9, 0xFF, 0x3C, 0xE7, 0xFC, 0xFF, 0xFF, 0x8F, 0xFF, 0xFF, 0xFF, 0xF0, // ###################################  ########  #########  ####  ###  #########  #################   ################################
    0xFF, 0xF9, 0x9C, 0xCF, 0xE7, 0xF9, 0xFF, 0x3C, 0xE7, 0xFC, 0xFF, 0xFF, 0x8F, 0xF9, 0x9C, 0xCF, 0xF0, // #############  ##  ###  ##  #######  ########  #########  ####  ###  #########  #################   #########  ##  ###  ##  ########
    0xFF, 0xF3, 0x39, 0x9F, 0xCF, 0xF3, 0xFE, 0x79, 0xCF, 0xF9, 0xFF, 0xFE, 0x1F, 0xF3, 0x39, 0x9F, 0xF0, // ############  ##  ###  ##  #######  ########  #########  ####  ###  #########  ################    #########  ##  ###  ##  #########
    0xFF, 0xF8, 0x7C, 0x3F, 0xCF, 0xF0, 0x1F, 0x33, 0xC0, 0x79, 0xFF, 0xFC, 0x9F, 0xF8, 0x7C, 0x3F, 0xF0, // #############    #####    ########  ########       #####  ##  ####       ####  ###############  #  ##########    #####    ##########
    0xFF, 0xC0, 0x20, 0x1F, 0x9F, 0xE7, 0xFE, 0x67, 0x9F, 0xF3, 0xFF, 0xF9, 0x3F, 0xC0, 0x20, 0x1F, 0xF0, // ##########        #        ######  ########  ##########  ##  ####  #########  ###############  #  ########        #        #########
    0xFF, 0xF0, 0xF8, 0x7F, 0x9F, 0xE7, 0xFF, 0x6F, 0x9F, 0xF3, 0xFF, 0xF3, 0x3F, 0xF0, 0xF8, 0x7F, 0xF0, // ############    #####    ########  ########  ########### ## #####  #########  ##############  ##  ##########    #####    ###########
    0xFF, 0xCC, 0xE6, 0x7F, 0x3F, 0xCF, 0xFE, 0x1F, 0x3F, 0xE7, 0xFF, 0xE0, 0x3F, 0xCC, 0xE6, 0x7F, 0xF0, // ##########  ##  ###  ##  #######  ########  ###########    #####  #########  ##############       ########  ##  ###  ##  ###########
    0xFF, 0xCC, 0xE6, 0x7F, 0x3F, 0xCF, 0xFE, 0x1F, 0x3F, 0xE7, 0xFF, 0xFE, 0x7F, 0xCC, 0xE6, 0x7F, 0xF0, // ##########  ##  ###  ##  #######  ########  ###########    #####  #########  ##################  #########  ##  ###  ##  ###########
    0xFF, 0xFF, 0xFF, 0xFE, 0x7F, 0x9F, 0xFE, 0x7E, 0x7F, 0xCF, 0xFF, 0xFC, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, // ###############################  ########  ############  ######  #########  ##################  ####################################
    0xFF, 0xFF, 0xFF, 0xFE, 0x01, 0x80, 0x7E, 0x7E, 0x01, 0xC0, 0x3F, 0xFC, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, // ###############################        ##        ######  ######        ###        ############  ####################################
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, // ####################################################################################################################################
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, // ####################################################################################################################################
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, // ####################################################################################################################################
};

/* Bitmap sizes for level4 */
const uint8_t level4WidthPixels = 132;
const uint8_t level4HeightPixels = 18;

