#ifndef place_weights_h
#define place_weights_h

#include "pulpino.h"

#define WA_ADDR           0x00
#define WB_ADDR           0x04
#define WC_ADDR           0x08
#define IIN_ADDR          0x0c
#define CHK_ADDR          0x10
#define OUT_ADDR          0x14
#define K 3

#define __PT__(a) *(volatile int*) (TIMER_BASE_ADDR + a)
#define WA  __PT__(WA_ADDR)
#define WB  __PT__(WB_ADDR)
#define WC  __PT__(WC_ADDR)
#define IIN __PT__(IIN_ADDR)
#define CHK __PT__(CHK_ADDR)
#define OUT __PT__(OUT_ADDR)

void weigh_in(int a[K][K]);

void send_input(int a, int b ,int c, int d);

void read_mode_on(void);

int read_result(void);
     
#endif
