#ifndef SPEEDY_H_
#define SPEEDY_H_

#include <stdio.h>
#include <stdlib.h>
#ifdef __cplusplus
extern "C"{
#endif


void encrypt(uint32_t* rk, uint32_t* pt, uint32_t* ct);

#ifdef __cplusplus
} // extern "C"
#endif
#endif 	// SPEEDY_H_
