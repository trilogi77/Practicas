/*
 *
 * Bit-Library.h v2.0
 *
 * Carlos Gómez Carrasco
 *
 * 22/09/2014
 *
 * DO NOT MODIFY THIS FILE
 */

#define SIZE_INT 8
#define SIZE_SIGN 1
#define SIZE_EXPONENT 8
#define SIZE_EXPONENT_DOUBLE 11
#define SIZE_SIGNIFICAND 23
#define SIZE_SIGNIFICAND_DOUBLE 52
#define SIZE_FLOAT (SIZE_SIGN+SIZE_EXPONENT+SIZE_SIGNIFICAND)
#define SIZE_DOUBLE (SIZE_SIGN+SIZE_EXPONENT_DOUBLE+SIZE_SIGNIFICAND_DOUBLE)

int parseArgument(int argc, char *argv[], int* number);
void printNumber(int number[]);

int parseFloatArgument(int argc, char *argv[], float* number);
int parseBinaryFloatArgument(int argc, char *argv[], int number[]);
void printFloatNumber(int number[]);
void printDoubleNumber(int number[]);

int parseTwoFloatArguments(int argc, char *argv[], float* number1, float* number2);
