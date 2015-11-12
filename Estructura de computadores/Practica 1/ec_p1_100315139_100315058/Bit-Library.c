/*
 *
 * Bit-Library.c v2.0
 *
 * Carlos Gómez Carrasco
 *
 * 22/09/2014
 *
 * DO NOT MODIFY THIS FILE
 */

#include <stdio.h>		/* printf header  */
#include <string.h>		/* strlen header */
#include <stdlib.h>
#include "Bit-Library.h"


/*
 * Parses the command arguments to a bit array.
 */
int parseArgument(int argc, char *argv[], int* number)
{
	int i;
	if(argc != 2)
	{
		return -1;
	}

	i = atoi(argv[1]);

	if(i > 127 || i < -128)
	{
		return -1;
	}
	*number = i;	
	return 0;
}

/*
 * Parses the command arguments to a bit array.
 */
int parseFloatArgument(int argc, char *argv[], float* number)
{
	float i;
	if(argc == 2)
	{
		i = (float)atof(argv[1]);
	}
	else
	{
		return -1;
	}
	*number = i;
	return 0;
}

/*
 * Parses the command arguments to a bit array.
 */
int parseBinaryFloatArgument(int argc, char *argv[], int number[])
{
	int i;

	if(argc == 2)
	{
		if(strlen(argv[1]) != SIZE_FLOAT)
		{
			return -1;
		}

		for(i=0; i<SIZE_FLOAT; i++)
		{
			if(argv[1][i] == '1')
			{
				number[i] = 1;
			}
			else if(argv[1][i] == '0')
			{
				number[i] = 0;
			}
			else
			{
				return -1;
			}
		}
	}
	else if (argc == 4)
	{
		if(strlen(argv[1]) != SIZE_SIGN || strlen(argv[2]) != SIZE_EXPONENT || strlen(argv[3]) != SIZE_SIGNIFICAND)
		{
			return -1;
		}

		for(i=0; i<SIZE_SIGN; i++)
		{
			if(argv[1][i] == '1')
			{
				number[i] = 1;
			}
			else if(argv[1][i] == '0')
			{
				number[i] = 0;
			}
			else
			{
				return -1;
			}
		}

		for(i=0; i<SIZE_EXPONENT; i++)
		{
			if(argv[2][i] == '1')
			{
				number[i + SIZE_SIGN] = 1;
			}
			else if(argv[2][i] == '0')
			{
				number[i + SIZE_SIGN] = 0;
			}
			else
			{
				return -1;
			}
		}

		for(i=0; i<SIZE_SIGNIFICAND; i++)
		{
			if(argv[3][i] == '1')
			{
				number[i + SIZE_SIGN + SIZE_EXPONENT] = 1;
			}
			else if(argv[3][i] == '0')
			{
				number[i + SIZE_SIGN + SIZE_EXPONENT] = 0;
			}
			else
			{
				return -1;
			}
		}
	}
	else
	{
		return -1;
	}
	
	return 0;
}


/*
 * Print a bit array.
 */
void printNumber(int number[])
{
	int i;
	for(i=0; i<SIZE_INT; i++)
	{
		if(number[i])
		{
			printf("%c", '1');
		}
		else 
		{
			printf("%c", '0');
		}
	}

	printf("\n");
}

/*
 * Print a bit array.
 */
void printFloatNumber(int number[])
{
	int i;
	for(i=0; i<SIZE_FLOAT; i++)
	{
		if( i == SIZE_SIGN || i == (SIZE_SIGN + SIZE_EXPONENT))
			printf(" ");

		if(number[i])
		{
			printf("%c", '1');
		}
		else 
		{
			printf("%c", '0');
		}
	}

	printf("\n");
}

void printDoubleNumber(int number[])
{
	int i;
	for(i=0; i<SIZE_DOUBLE; i++)
	{
		if( i == SIZE_SIGN || i == (SIZE_SIGN + SIZE_EXPONENT_DOUBLE))
			printf(" ");

		if(number[i])
		{
			printf("%c", '1');
		}
		else 
		{
			printf("%c", '0');
		}
	}

	printf("\n");
}

/*
 * Parses the command arguments to two bit arrays.
 */
int parseTwoFloatArguments(int argc, char *argv[], float* number1, float* number2)
{
	float f1,f2;
	if(argc != 3)
	{
		return -1;
	}
	
	f1 = (float)atof(argv[1]);
	f2 = (float)atof(argv[2]);
	
	*number1 = f1;
	*number2 = f2;

	return 0;
}
