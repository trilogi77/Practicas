/*
 *
 * E2-IntToBinaryComp.c
 *
 * Javier Bautista Rosell, Alejandro Blanco Samaniego
 *
 * <Date>
 *
 */

#include <stdio.h>		/* printf header  */
#include <stdlib.h>		/* exit header */
#include "Bit-Library.h"	/* bit libray header */

int intToBinary(int number, int num[]);
int intToComp1(int number, int num[]);
int intToComp2(int number, int num[]);

int main(int argc, char *argv[])
{
    int num[SIZE_INT];
    int value = 0;
    
    if(parseArgument(argc, argv, &value))
    {
        printf("Not a formatted number.\n");	/* Return error */
        exit(-1);
    }
    
    printf("Value: %d\n", value);	/* Printing value */
    
    printf("Binary: ");
    intToBinary(value, num);
    printNumber(num);
    
    printf("Comp1: ");
    intToComp1(value, num);
    printNumber(num);
    
    printf("Comp2: ");
    intToComp2(value, num);
    printNumber(num);
    
    
    return 0;	/* Return success */
}

int intToBinary(int number, int num[])
{
    int i, j, c;//introducimos variables
    if (number<256 && number>=0){//nos deshacemos de lo que no nos interesa
        c=7;//van del 0 al 7
        j=0;//para colocar en orden los bits
        i=number;//para trabajar con el numero sin modificarlo
        while (i>=1){//bucle que genera los bits del vector
            if (i%2==1){//selector, si es resto 1, bit 1
                num[c-j]=1;
            }
            else {//selector, si es resto 0, bit 0
                num[c-j]=0;
            }
            i=i/2;//se modifica el entero, a la mitad sin decimal
            j++;//para pasar a otra posicion del vector
        }
        
    }else {//en caso de que se introduzca algo que no nos interesa, este mensaje aparece.
        printf("Este numero no es representable en binario natural con 8 bits");
    }
    
    return 0;
}

int intToComp1(int number, int num[])
{
    int i, j, c;//introducimos variables
    if (number<128 && number>-128){//nos deshacemos de lo que no nos interesa
        int aux=number;//para no perder el valor de number, y usar positivo
        if(number<0){
            number*=-1;//pasamos a positivo number para trabajar con el en binario
        }
        
        c=7;//van del 0 al 7
        j=0;//para colocar en orden los bits
        i=number;//para trabajar con el numero sin modificarlo
        while (i>=1){//bucle que genera los bits del vector
            if (i%2==1){//selector, si es resto 1, bit 1
                num[c-j]=1;
            }
            else {//selector, si es resto 0, bit 0
                num[c-j]=0;
            }
            i=i/2;//se modifica el entero, a la mitad sin decimal
            j++;//para pasar a otra posicion del vector
        }
      
        number=aux;//recuperamos nuestro numero, sea o no negativo
        if(number<0){//selecciono si es negativo
            
            for (i=0; i<8; i++){//bucle que cambia 0 por 1 y 1 por 0
                if (num[i]==1){//cambio 1 por 0
                    num[i]=0;
                }
                else{//cambio 0 por 1
                    num[i]=1;
                }
            }
            
        }
    }else {//me encargo de los que no nos interesan
        printf("Este numero no es representable en complemento A1 con 8 bits");
    }
    return 0;	/* Return success */
}

int intToComp2(int number, int num[])
{
    int i, j, c;//introducimos variables
    if (number<128 && number>=-128){//nos deshacemos de lo que no nos interesa
        int aux=number;//para no perder el valor de number, y usar positivo
        if(number<0){
            number*=-1;
        }
        
        c=7;//van del 0 al 7
        j=0;//para colocar en orden los bits
        i=number;//para trabajar con el numero sin modificarlo
        while (i>=1){//bucle que genera los bits del vector
            if (i%2==1){//selector, si es resto 1, bit 1
                num[c-j]=1;
            }
            else {//selector, si es resto 0, bit 0
                num[c-j]=0;
            }
            i=i/2;//se modifica el entero, a la mitad sin decimal
            j++;//para pasar a otra posiciÛn del vector
        }
        for (j; j<8;j++){//bucle que se encarga de poner ceros necesarios a la derecha
            num[c-j]=0;
        }
        number=aux;//recuperamos nuestro numero, sea o no negativo
       
        if(number<0){//selecciono si es negativo
            
            for (i=0; i<8; i++){//bucle que cambia 0 por 1 y 1 por 0
                if (num[i]==1){//cambio 1 por 0
                    num[i]=0;
                }
                else{//cambio 0 por 1
                    num[i]=1;
                }
            }
            for (i=7;i>=0;i--){//le sumo 1 logico
                if (num[i]==0){
                    num[i]=1;
                    break;
                }else{
                    num[i]=0;
                }
            }
           
        }else{//selecciono si es positivo
           
        }
    }else {//me encargo de los que no nos interesan
        printf("Este numero no es representable en complemento A2 con 8 bits");
    }
    
    return 0;	/* Return success */
}

