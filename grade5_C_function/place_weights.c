#include "place_weights.h"

void weigh_in(int a[K][K]){
    WA = (a[0][0]<<16) + (a[0][1]<<8) + a[0][2];
    WB = (a[1][0]<<16) + (a[1][1]<<8) + a[1][2];
    WC = (a[2][0]<<16) + (a[2][1]<<8) + a[2][2];
}

void frame_in(int frm[F][F]){
   for(int j = 0; j < 13  ; j++){
      for(int i = 0; i < 28 ; i++){
         IIN = (frm[0+j*2][i]<<24) + (frm[1+j*2][i]<<16) + (frm[2+j*2][i]<<8) + frm[3+j*2][i];
      }
   }
}

void read_mode_on(void){
    CHK = 1;
}

int read_result(void){
    int a = OUT;
    return a;
}

void read_mode_off(void){
    CHK = 0;
}
