/*
 *
 * E4-IEEE754ToFloat.c
 *
 * <Javier Bautista Rosell  -  Alejandro Blanco Samaniego>
 *
 * <Date>
 *
 */

#include <stdio.h>		/* printf header  */
#include <stdlib.h>		/* exit header */
#include <math.h>		/* pow header */
#include "Bit-Library.h"	/* bit libray header */

float IEEE754ToFloat(int num[]);


int main(int argc, char *argv[])
{
    int num[SIZE_FLOAT];
    float value = 0;
    
    
    if(parseBinaryFloatArgument(argc, argv, num))
    {
        printf("Not a formatted number.\n");	/* Return error */
        exit(-1);
    }
    
    printFloatNumber(num);
    
    value = IEEE754ToFloat(num);
    
    printf("Value: %'.16f\n", value);	/* Printing value */
    
    return 0;	/* Return success */
}


float IEEE754ToFloat(int num[])
{
    int posicion, exponente,  auxiposic, auxexponente;  // inicializamos variables////////
    float numero, auxnumero,k;
    
    //Exponente
    exponente=0;
    posicion=8;//para empezar a leer el vector en la posición 8
    k=1;// contador para multiplicar por potencias de 2
    while(posicion>=1){//multiplico por potencias de 2
        auxexponente=num[posicion]*k;
        exponente+=auxexponente;
        
        k=k*2;
        posicion-=1;
    }
    
    exponente=exponente; // ES TOTALMENTE NECESARIO Y MUY UTIL ;);) codo codo
    exponente=exponente-127;// el exponente tiene un exceso de 127
    printf("exponente = %i\n" ,exponente);
    
    //Numero
    posicion=8+exponente;//para colocarme en la posición que debo
   
    if(posicion>=9){// para si el exponente es positivo
        k=1;
        auxiposic=posicion;
        while (posicion>=9){ //saco el valor de la parte entera
           auxnumero=num[posicion]*k;
            numero+=auxnumero;
            k=k*2;
            posicion=posicion-1;
           
        }
      numero+=k;
        posicion=auxiposic+1;
        k=auxiposic-posicion;
        printf(" %f\n" ,k);
      
        //parte decimal
        while (posicion<=31){
           posicion=posicion+1;
            if(num[posicion]==1){
                auxnumero=pow(2,k);
                numero+=auxnumero;}
            k=auxiposic-posicion;
            
           
        }
        
    }
    
    else{// si el exponente es negativo
   
        
        auxiposic=posicion;
        posicion=9;// lo coloco en la posición 9
        k=auxiposic-posicion;
        numero=pow(2,k+1);
        while (posicion<=31){// saco el number
            posicion=posicion+1;
            if(num[posicion]==1){
                auxnumero=pow(2,k);
                numero+=auxnumero;}
            k=auxiposic-posicion;
            
    
        }}
    if(num[0]==1){// miro el signo
        numero*=-1;
    }
        
    
   printf("el valor es = %f\n\n\n" ,numero);
    
    //imprimo por pantalla numero
    
    
    
    /* INSERT YOUR CODE HERE */
    
    return 0;   // Y YA ESTA BIEEEEEN!!!!!!!        /* Return float value */
    
    
    /* ********************* */
    }
