/*
 *
 * E1-Series.c
 *
 * <Javier Bautista Rosell, Alejandro Blanco Samaniego>
 *
 * <11 octubre 2014>
 *
 *
 */

#include <stdio.h>		/* printf header */


void executeIEEE754Series();	/* Prototypes */
void executeIntegerSeries();



int main(int argc, char *argv[])
{
    executeIEEE754Series();
    
    executeIntegerSeries();
    
    return 0;		/* Return success */
}


void executeIEEE754Series()
{
    printf("Executing IEEE 754 series..\n");
    
    
    double x,y,k;// x es la suma de Sn, y es el siguiente dato de Sn, K es el dato de la suma anterior
    float s,t,v;// s es la suma de Sn, t es el siguiente dato de Sn, v es el dato de la suma anterior
    int n,r;// n es el numero de la posicion que toca de la sucesion (cuando la variable es double, r es cuando la variable es float
    s=0;
    x=0;
    r=1;
    n=1;
    v=s;
    k=x;
    t=1;
    y=1;//inicializo todas las variables
    s=+t;// es igual que s= s+t
    x=+y;// es igual que x= x+y
    
    while (k!=x){// mientras x sea distinto que k se va repitiendo el while en el que se suma 1 a n cada vez para seguir la sucesion
        n=n+1;
        y=y/2;
        k=x;
        x=x+y;
        
    }
    while (v!=s){ // mientras v sea distinto de s se repite while igual que en el caso anterior sustituyendo n por r
        r=r+1;
        t=t/2;
        v=s;
        s=s+t;
        
    }
    printf("\nel valor de la serie no varia a partir del Sn donde n= %i si la variable es double\nsi la variable fuera float n seria=%i\n\n" ,n,r);
}

void executeIntegerSeries()
{
    printf("Executing integer series..\n");
    
    int l,m;// inicializo variables
    l=2;
    m=1;
    
    while(l>0){//while para ver hasta que numero de bits llega el int
        l=l*2;
        m=m+1;
        
    }
    printf("la variable int tiene %i bits\n",m+1);//imprimimos el numero de bits que tiene int
    
    long c;
    int b;
    c=2;
    b=1;
    while(c>0){// while para ver hasta el numero de bits de la variable long (sale 64 bits dado que lo he hecho en un compilador de 64 bits.
        c=c*2;
        b=b+1;
       
        
    }
    printf("la variable long tiene %i bits\n", b+1);//imprimimos el numero de bits de long
}
