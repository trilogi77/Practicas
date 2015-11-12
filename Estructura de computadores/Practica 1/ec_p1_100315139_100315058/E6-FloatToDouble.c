/*
 *
 * E6-FloatToDouble.c
 *
 * <Javier Bautista Rosell   -  Alejandro Blanco Samaniego>
 *
 * <Date>
 *
 */

#include <stdio.h>		/* printf header  */
#include <stdlib.h>		/* exit header */
#include <math.h>		/* pow header */
#include "Bit-Library.h"	/* bit libray header */

int FloatToDouble(float number, int number64[]);


int main(int argc, char *argv[])
{
    int num[SIZE_DOUBLE];
    float value = 0;
    
    
    if(parseFloatArgument(argc, argv, &value))
    {
        printf("Not a formatted number.\n");	/* Return error */
        exit(-1);
    }
    
    printf("Value: %'.16f\n", value);	/* Printing value */
    
    FloatToDouble(value, num);
    
    printDoubleNumber(num);
    
    return 0;	/* Return success */
}

int FloatToDouble(float number, int number64[])
{
    double x;
    x= number;
    
    //JAVI, NO SE SI FLOAT NUMBER ES EL VECTOR EN IEEE 32 O UN DECIMAL. CREO QUE ESTO ESTA MAL, EN EL ENUNCIADO PIDEN IEE. AQUI LO INTERPRETO COMO SI ESTUVIERA EN IEE
    int posicion, exponente, auxentero,entauxnumb,auxexponente;// inicializamos las variables
    exponente=0;
    double auxnumber;
    
    // Bit de signo
    if (x>=0){
        number64[0]=0;
        
    }
    else{
        number64[0]=1;
        x*= -1;// lo multiplico por -1 para luego trabajar con él en positivo
    }
    
    //exponente
    int entero= (int) x;
    x=x-entero;
    auxentero=entero;
    auxnumber=x;
    entauxnumb=(int)auxnumber;
    
    if (auxentero!=0){// este if sirve para sacar el valor del exponente siempre y cuando sea mayor que 1
        while(auxentero>=2){
            auxentero=auxentero/2;
            exponente=exponente+1;
        }
    }
    else{// igual que el if pero menor que 1
        while(entauxnumb!=1){
            auxnumber=auxnumber*2;
            entauxnumb=(int)auxnumber;
            auxnumber=auxnumber-entauxnumb;
            exponente=exponente-1;
        }
        
    }
    printf("\n exponente = %i\n" ,exponente);// me fuerza mi compañero a comentarte que aqui imprimo el valor del exponente por pantalla
    auxexponente=exponente;
    
    //HASTA AQUI ESTA PERFECTO
    
    //exponente en el IEE754
    
    posicion=11;// en la posicion 8 del vector acaba el exponente por tanto empiezo a poner los restos por alli
    
    exponente=exponente+1023;
    
    for (posicion=11; posicion>=1; posicion--){//relleno el vector con los bits del exponente
        number64[posicion]=exponente%2;
        exponente=exponente/2;
        
        
    }
    
    
    
    
    
    
    
    //POR AHORA PARECE QUE FURRULA
    //TOMAAAAAA
    
    //pasar a binario
    
    posicion=11+auxexponente; //para colocarme en la mantisa
    
    
    while (posicion>11){// while de la parte entera en binario
        number64[posicion]=entero%2;
        entero=entero/2;
        posicion=posicion-1;
    }
    if(auxexponente>=0){
        posicion=12+auxexponente;}   //arreglo para que cuando es 0,... no se me cuele la mantisa al exponente
    else{
        while(entero!=1){
            posicion=12;
           x=x*2;
            entero=(int)x;
           x=x-entero;
        }
    }
    
    while(posicion<=63){// while de la parte decimal en binario
        x=x*2;
        number64[posicion]=(int)x;
        entero=(int)x;
        x=x-entero;
        posicion=posicion+1;
    }
    
    
    
    //EPIC WIN VIVAAAAA (TRAS UNAS 24 HORAS DE TRABAJO EN EL MISMO EJERCICIO)
    
    
    
    /* INSERT YOUR CODE HERE */
    
    return 0;	/* Return success */
    

    
    
    
}