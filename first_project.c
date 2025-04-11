
    #include <stdio.h> 
    #include "gpio.h"
    
    volatile int  O[4][4];

    int main(){
        volatile int I[4][8]={{1,2,3,4,5,6,7,8},
                              {1,2,3,4,5,6,7,8},
                              {1,2,3,4,5,6,7,8},
                              {1,2,3,4,5,6,7,8}};
        volatile int A[8][4]={{ 3, 8,18, 1},
                              {22,15,40,10},
                              {11, 2, 3, 4},
                              { 1, 4, 2, 0},
                              { 8,12,16, 2},
                              { 3, 6, 9,12},
                              { 1, 1, 1, 1},
                              { 2, 2, 2, 2}};
     
        
        
	set_gpio_pin_direction(0, DIR_OUT);
	set_gpio_pin_value(0,1);

        for(int i=0; i<4; i++){
            for(int j=0; j<4; j++){
                
                O[i][j] = (I[i][0]*A[0][j]) + (I[i][1]*A[1][j]) + (I[i][2]*A[2][j]) + (I[i][3]*A[3][j]) + (I[i][4]*A[4][j]) + (I[i][5]*A[5][j]) + (I[i][6]*A[6][j]) + (I[i][7]*A[7][j]);

            }
        }
	set_gpio_pin_value(0,0);
        return 0;

    }

//O = 4*165, 4*179, 4*272, 4*138
