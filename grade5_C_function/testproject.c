#include <stdio.h>
#include "place_weights.h"


int main(){

    int S[K][K] ={{1,2,1},
                  {2,4,2},
                  {1,2,1}};

    int quad_inpt[F][F];
    //int result[R][R];

    for(int j = 0; j < F  ; j++){
       for(int i = 0; i < F ; i++){
          quad_inpt[j][i] = 0;
          if((i>7)&&(i<20)){
             if((j>7)&&(j<20)){
                quad_inpt[j][i] = 255;
             }
          }
       }
    }



    weigh_in(S);



    frame_in(quad_inpt);



    read_mode_on();


/*
    int out1,out2 = 0;
    for(int i = 0; i < 13 ; i++){
       for(int j = 0; j < R ; j++){
          out1 = read_result();
          out2 = out1 << 16;
          result[0+i*2][j] = out1 >> 16;
          result[1+i*2][j] = out2 >> 16;
       }
    }
    for(int i = 0; i < R ; i++){
       for(int j = 0; j < R ; j++){
          printf("%d%d%d  ",(result[i][j]/100), ((result[i][j]/10)%10), (result[i][j]%10));
       }
      printf("\n");
    }
*/  

    int B = 0;
    for(int i = 0; i < 338 ; i++){
       B = read_result();
    }


    read_mode_off();


    return 0;

}
