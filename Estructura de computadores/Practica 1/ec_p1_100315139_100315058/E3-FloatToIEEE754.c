/*
 *
 * E3-FloatToIEEE754.c
 *
 * <Javier Bautista Rosell  - Alejandro Blanco Samaniego>
 *
 * <Date>
 *
 */

#include <stdio.h>		/* printf header  */
#include <stdlib.h>		/* exit header */
#include <math.h>		/* pow header */
#include "Bit-Library.h"	/* bit libray header */

int FloatToIEEE754(float number, int numberIEEE754[]);


int main(int argc, char *argv[])
{
    int num[SIZE_FLOAT];
    float value = 0;
    
    
    if(parseFloatArgument(argc, argv, &value))
    {
        printf("Not a formatted number.\n");	/* Return error */
        exit(-1);
    }
    
    printf("Value: %'.16f\n", value);	/* Printing value */
    
    FloatToIEEE754(value, num);
    
    printFloatNumber(num);
    
    return 0;	/* Return success */
}

int FloatToIEEE754(float number, int numberIEEE754[])
{
    int posicion, exponente, auxentero,entauxnumb,auxexponente;// inicializamos las variables
    exponente=0;
    float auxnumber;
    
    // Bit de signo
    if (number>=0){
        numberIEEE754[0]=0;
        
    }
    else{
        numberIEEE754[0]=1;
        number*= -1;// lo multiplico por -1 para luego trabajar con él en positivo
    }
    
    //exponente
    int entero= (int) number;
    number=number-entero;
    auxentero=entero;
    auxnumber=number;
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
    
    posicion=8;// en la posicion 8 del vector acaba el exponente por tanto empiezo a poner los restos por alli
    
        exponente=exponente+127;
   
    for (posicion=8; posicion>=1; posicion--){//relleno el vector con los bits del exponente
            numberIEEE754[posicion]=exponente%2;
            exponente=exponente/2;
        
        
        }
        
   
  
    
    
    
    
    //POR AHORA PARECE QUE FURRULA
    //TOMAAAAAA
    
    //pasar a binario
    
    posicion=8+auxexponente; //para colocarme en la mantisa
    

    while (posicion>8){// while de la parte entera en binario
        numberIEEE754[posicion]=entero%2;
        entero=entero/2;
        posicion=posicion-1;
    }
    if(auxexponente>=0){
        posicion=9+auxexponente;}   //arreglo para que cuando es 0,... no se me cuele la mantisa al exponente
    else{
        while(entero!=1){
        posicion=9;
        number=number*2;
        entero=(int)number;
        number=number-entero;
        }
    }
    
    while(posicion<=31){// while de la parte decimal en binario
        number=number*2;
        numberIEEE754[posicion]=(int)number;
        entero=(int)number;
        number=number-entero;
        posicion=posicion+1;
    }
    
    
   
    //EPIC WIN VIVAAAAA (TRAS UNAS 24 HORAS DE TRABAJO EN EL MISMO EJERCICIO)

    
    
    /* INSERT YOUR CODE HERE */
    
    return 0;	/* Return success */
    
}
