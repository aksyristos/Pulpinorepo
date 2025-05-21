#include "place_weights.h"

void weigh_in(int a[K][K]){
    WA = a[0][0]*65536 + a[0][1]*256 + a[0][2];
    WB = a[1][0]*65536 + a[1][1]*256 + a[1][2];
    WC = a[2][0]*65536 + a[2][1]*256 + a[2][2];
}

void send_input(int a, int b ,int c, int d){
    IIN = a*16777216 + b*65536 + c*256 + d;
}

void read_mode_on(void){
    CHK = 1;
}

int read_result(void){
    int a = OUT;
    return a;
}
