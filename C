#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define Rounds 7

uint32_t RC[8][6]     = {     {0x243f6a88, 0x85a308d3, 0x13198a2e, 0x03707344, 0xa4093822, 0x299f31d0},
                               {0x082efa98, 0xec4e6c89, 0x452821e6, 0x38d01377, 0xbe5466cf, 0x34e90c6c},
                               {0xc0ac29b7, 0xc97c50dd, 0x3f84d5b5, 0xb5470917, 0x9216d5d9, 0x8979fb1b},
                               {0xd1310ba6, 0x98dfb5ac, 0x2ffd72db, 0xd01adfb7, 0xb8e1afed, 0x6a267e96},
                               {0xba7c9045, 0xf12c7f99, 0x24a19947, 0xb3916cf7, 0x0801f2e2, 0x858efc16},
                               {0x636920d8, 0x71574e69, 0xa458fea3, 0xf4933d7e, 0x0d95748f, 0x728eb658},
                               {0x718bcd58, 0x82154aee, 0x7b54a41d, 0xc25a59b5, 0x9c30d539, 0x2af26013},
                               {0xc5d1b023, 0x286085f0, 0xca417918, 0xb8db38ef, 0x8e79dcb0, 0x603a180e}};


void prepare_round_keys(uint32_t *key, uint32_t roundkey[][6]){
    bool temp[2][192];
    
    for( int i=0; i<6; i++)
    {
        for (int j=0; j<32; j++)
        {
            temp[0][32*i+j] = ((key[i]) >> (63 - j )) &1;
        }
        
    }
    
    for(int i=0; i<192; i++)
    {
        roundkey[0][i/32] ^=  (uint32_t)temp[0][i] << (31-(i%32));
    }

    for(int r = 1; r < Rounds; r++)
    {
        bool ind_new = (r % 2);
        bool ind_old = !ind_new;
        
        for(int i = 0; i < 192; i++)
        {
            temp[ind_new][i] = temp[ind_old][(7 * i + 1) % 192];
        }
        for(int i = 0; i < 6; i++)
        {
            roundkey[r][i]=RC[r-1][i];
        }
        for(int i=0; i<192; i++)
        {
            roundkey[r][i/32] ^=  (uint32_t)temp[ind_new][i] << (31-(i%32));
        }
    }
    for(int i = 0; i < 192; i++)
    {
        temp[Rounds%2][i] = temp[(Rounds+1)%2][(7 * i + 1) % 192];
    }
    for(int i=0; i<192; i++)
    {
        roundkey[Rounds][i/32] ^=  (uint32_t)temp[Rounds%2][i] << (31-(i%32));
    }
}


void transpose(uint32_t* State, uint32_t* out){
    bool bit[192];
    uint32_t ret[6] ={0,0,0,0,0,0};
    
    for(int i=0; i<192; i++)
    {
        bit[i] = (State[i/32] >> (31-(i%32)) )&1;
    }
    
    for(int i=0; i<6;i++)
    {
        for(int j=0; j<32;j++)
        {
                ret[i] ^= (uint32_t)bit[j*6+i]<<(31-j);
        }
        out[i]=ret[i];
    }
}


void untranspose(uint32_t* State, uint32_t* out){
    bool bit[192];
    uint32_t ret[6]={0,};
     
    for(int i=0; i<6;i++)
    {
        for(int j=0; j<32;j++)
        {
            bit[j*6+i] = (bool)((State[i]>>(31-j))&1);
        }
    }
    
    for(int i=0; i<192; i++)
    {
        ret[i/32] ^=  (uint32_t)bit[i] << (31-(i%32));
    }
    for(int i=0;i<6;i++)
    {
        out[i] = ret[i];
    }
}

void AddRoundKey(uint32_t *state, uint32_t *roundkey)
{
    for(int i=0; i<6; i++)
    {
        state[i] = state[i] ^ roundkey[i];
    }
}

void SubBox(uint32_t *state)
{
    uint32_t temp[6]={0,};

    temp[0] = ( state[3] & ~state[5]            ) | ( state[3] &  state[4] &  state[2]) | (~state[3] &  state[1] & state[0]) | ( state[5] &  state[4] &  state[1]);
    temp[1] = ( state[5] &  state[3] & ~state[2]) | (~state[5] &  state[3] & ~state[4]) | ( state[5] &  state[2] & state[0]) | (~state[3] & ~state[0] &  state[1]);
    temp[2] = (~state[3] &  state[0] &  state[4]) | ( state[3] &  state[0] &  state[1]) | (~state[3] & ~state[4] & state[2]) | (~state[0] & ~state[2] & ~state[5]);
    temp[3] = (~state[0] &  state[2] & ~state[3]) | ( state[0] &  state[2] &  state[4]) | ( state[0] & ~state[2] & state[5]) | (~state[0] &  state[3] &  state[1]);
    temp[4] = ( state[0] & ~state[3]            ) | ( state[0] & ~state[4] & ~state[2]) | (~state[0] &  state[4] & state[5]) | (~state[4] & ~state[2] &  state[1]);
    temp[5] = ( state[2] &  state[5]            ) | (~state[2] & ~state[1] &  state[4]) | ( state[2] &  state[1] & state[0]) | (~state[1] &  state[0] &  state[3]);
    
    state[0] = temp[0];
    state[1] = temp[1];
    state[2] = temp[2];
    state[3] = temp[3];
    state[4] = temp[4];
    state[5] = temp[5];
}

#define ROL32(y, t) ( (y << t) | (y >> (32-t) ))

void ShiftColumns(uint32_t *state)
{
    state[1] = ROL32(state[1], 1);
    state[2] = ROL32(state[2], 2);
    state[3] = ROL32(state[3], 3);
    state[4] = ROL32(state[4], 4);
    state[5] = ROL32(state[5], 5);
}

void MixColumnsAddRoundKeyAddRoundConstant(uint32_t *state, uint32_t *roundkeyxorroundconstant)
{
    const int alphas[] = {1, 5, 9, 15, 21, 26};
    uint32_t temp[6]={0,};
    for (int i=0; i<6; i++)
    {
        temp[i] = state[i] ;
    }
    for (int i=0; i<6; i++)
    {
        for (int j=0 ; j<6; j++)
        {
            state[i] ^= ROL32(temp[i], alphas[j]);
        }
        state[i] ^= roundkeyxorroundconstant[i];
    }
}


void Encrypt(uint32_t *Plaintext, uint32_t *Key, uint32_t *Ciphertext)
{
    uint32_t RoundKeysXORConstants[Rounds+1][6] = {{0}};
    uint32_t packRoundKeysXORConstants[Rounds+1][6];
    uint32_t RoundState[6] = {0,};
    
    prepare_round_keys(Key, RoundKeysXORConstants);

    for(int i=0;i<Rounds+1;i++)
    {
        transpose(RoundKeysXORConstants[i],packRoundKeysXORConstants[i]);
    }
    transpose(Plaintext, RoundState);
    AddRoundKey(RoundState, packRoundKeysXORConstants[0]);
    
    for(int i=1; i<Rounds; i++)
    {
        SubBox(RoundState);
        ShiftColumns(RoundState);
        SubBox(RoundState);
        ShiftColumns(RoundState);
        MixColumnsAddRoundKeyAddRoundConstant(RoundState, packRoundKeysXORConstants[i]);
    }
    SubBox(RoundState);
    ShiftColumns(RoundState);
    SubBox(RoundState);
    AddRoundKey(RoundState, packRoundKeysXORConstants[Rounds]);
    untranspose(RoundState, Ciphertext);
    
}


int main()
{
    uint32_t Key[6] = {0x764C4F62, 0x54E1BFF2, 0x08E95862, 0x428FAED0, 0x1584F420, 0x7A7E8477};
    uint32_t Plaintext[6]= {0xA13A6324, 0x51070E43, 0x82A27F26, 0xA40682F3,0xFE9FF680, 0x28D24FDB};
    uint32_t Ciphertext[6];

    Encrypt(Plaintext, Key, Ciphertext);
    
    return 0;
}
