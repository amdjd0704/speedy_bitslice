#ifndef SPEEDY_H_
#define SPEEDY_H_

#include <stdint.h>
#ifdef __cplusplus
extern "C"{
#endif

#define Rounds 7 /* Put a number between 1 and 9 here */

void encrypt(uint32_t (*rkey)[6], uint32_t* ptext, uint32_t* ctext);

#ifdef __cplusplus
} // extern "C"
#endif
#endif 	// SPEEDY_H_
