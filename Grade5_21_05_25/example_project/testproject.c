
#include <stdio.h>

#include "place_weights.h"


int main(){

    int S[K][K] ={{0,1,2},
                  {3,4,5},
                  {6,7,8}};

    int quad_inpt[4][4] = {{16,16,16,16},
                           {16,16,16,16},
                           {16,16,16,16},
                           {16,16,16,16}};

    weigh_in (S);

    for(int i = 0; i < 4 ; i++){
       send_input(quad_inpt[0][i],quad_inpt[1][i],quad_inpt[2][i],quad_inpt[3][i]);
    }

    read_mode_on();

    int B = read_result();

    B = read_result();

    return 0;

}
