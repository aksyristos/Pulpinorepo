#include <stdio.h>
#include "gpio.h" 
int main()
{
    volatile int  O[26][26];
    volatile int  I[28][28];
    volatile int  K[3][3];
    for(int i=0; i<28; i++)
        for(int j=0; j<28; j++)
            I[i][j]=(i*28+j);
    for(int i=0; i<3; i++)
        for(int j=0; j<3; j++)
            K[i][j]=(i*3+j);
    
	set_gpio_pin_direction(0, DIR_OUT);
	set_gpio_pin_value(0,1);
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");        
	asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
    for(int i=0; i<26; i++){
        for(int j=0; j<26; j++){
            int sum=0;
            for(int ki=0; ki<3; ki++){
                for(int kj=0; kj<3; kj++){
                    sum+=I[i+ki][j+kj]*K[ki][kj];
                }
            }
            O[i][j]=sum;
	    //printf("%d ",O[i][j]);
        }
	//puts("");
    }
	set_gpio_pin_direction(0, DIR_OUT);
	set_gpio_pin_value(0,0);
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");        
	asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
    return 0;
}

