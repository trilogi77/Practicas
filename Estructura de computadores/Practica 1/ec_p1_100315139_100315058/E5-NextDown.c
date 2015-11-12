/*
 *
 * E5-NextDown.c
 *
 * <Author names>
 *
 * <Date>
 *
 */

#include <stdio.h>		/* printf header  */
#include <stdlib.h>		/* exit header */
#include "Bit-Library.h"	/* bit libray header */

int nextDown(int num[], int nextDown[]);
float IEEE754ToFloat(int num[]);

int main(int argc, char *argv[])
{
    int num[SIZE_FLOAT];
    int nextD[SIZE_FLOAT];
    float value = 0;
    
    if(parseBinaryFloatArgument(argc, argv, num))
    {
        printf("Not a formatted number.\n");	/* Return error */
        exit(-1);
    }
    
    printf("Number\n");
    
    printFloatNumber(num);
    
    value = IEEE754ToFloat(num);
    
    printf("Value: %'.16f\n\n", value);	/* Printing value */
    
    nextDown(num, nextD);
    
    
    printf("NextDown number\n");
    
    printFloatNumber(nextD);
    
    value = IEEE754ToFloat(nextD);
    
    printf("Value: %'.16f\n", value);	/* Printing value */
    
    return 0;	/* Return success */
}



float IEEE754ToFloat(int num[])
{
    {
        int posicion, exponente,  auxiposic, auxexponente;
        float numero, auxnumero,k;
        
        //Exponente
        exponente=0;
        posicion=8;
        k=1;
        while(posicion>=1){
            auxexponente=num[posicion]*k;
            exponente+=auxexponente;
            
            k=k*2;
            posicion-=1;
        }
        
        exponente=exponente;
        exponente=exponente-127;
        printf("exponente = %i\n" ,exponente);
        
        //Numero
        posicion=8+exponente;
        
        if(posicion>=9){
            k=1;
            auxiposic=posicion;
            while (posicion>=9){
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
        
        else{
            
            
            auxiposic=posicion;
            posicion=9;
            k=auxiposic-posicion;
            numero=pow(2,k+1);
            while (posicion<=31){
                posicion=posicion+1;
                if(num[posicion]==1){
                    auxnumero=pow(2,k);
                    numero+=auxnumero;}
                k=auxiposic-posicion;
                
                
            }}
        if(num[0]==1){
            numero*=-1;
        }
        
        
        printf("%f" ,numero);
        
        /* INSERT YOUR CODE HERE */
        
        return 0;
        
        
        /* ********************* */
    }
    
    int nextDown(int num[], int nextDown[]){
        /* INSERT YOUR CODE HERE */
        
        int i, j, k, nan, nnn, inf;//inicializo variables
        j=0;//j es para averiguar si el n˙mero es 0
        k=0;//k es para averiguar si el exponente es 0 o 255
        nan=0;//not a number
        nnn=0;//numero no normalizado
        inf=0;//infinito o -infinito
        for(i=0; i<SIZE_FLOAT; i++)//bucle dado para igualar los vectores
        {
            nextDown[i] = num[i];
        }
        for (i=1; i<9; i++){
            if (nextDown[i]==1){
                k++;
            }
        }
        for(i=9; i<SIZE_FLOAT; i++)//bucle para comprobar si es 0 la mantisa
        {
            if (nextDown[i]==1){//si en algun momento no es 0, j nos lo indica
                j=1;
                break;
            }
            
        }
        if (k==0){	//si el exponente es 0
            if (j==0){//si la mantisa es 0, lo convertimos, lo haya sido o no a -0, para trabajar con negativos.
                nextDown[0]=1
            }
            else{
                nnn=1;//numero no normalizado
            }
        }
        if (k==8){//si el exponente es 255
            if(j!=0){//si la mantisa es 0
                nan=1//NAN not a number
            }
            else if(nextDown[0]==0){//si la mantisa no es 0, y el signo es positivo
                inf=1;
            }
            else {//si por el contrario el signo es negativo
                inf=-1;
            }
        }
        if (nnn!=1 && nan!=1 && inf==0){//si el n˙mero no es un caso especial, est· normalizado, continuamos 
            
            if(nextDown[0]==0){//seleccionamos si es positivo
                for(i=SIZE_FLOAT; i>0; i--)//este bucle resta un bit logico
                {
                    if ()nextDown[i] == 1) {
                        nextDown[i]=0;
                        break;
                    }
                    else{
                        nextDown[i]=1;
                    }
                }	
            }
            else{//seleccionamos si es negativo
                for(i=SIZE_FLOAT; i>0; i--)//este bucle suma un bit logico
                {
                    if ()nextDown[i] == 0) {
                        nextDown[i]=1;
                        break;
                    }
                    else{
                        nextDown[i]=0;
                    }
                }
            }
        }
    }
        /* ********************* */
        
        return 0;	/* Return success */
    
    
}
