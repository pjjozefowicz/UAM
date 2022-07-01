#include <stdio.h>
#include <math.h>

float delta(float a, float b, float c)
{
	return b*b-4*a*c;
}

float jednRozw(float a,float b)
{
	return -b/(2*a);
}

float pierwX1(float  a, float  b, float  delta)
{
	return (-b+sqrt(delta))/(2*a);
}

float pierwX2(float  a, float  b, float  delta)
{
	return (-b-sqrt(delta))/(2*a);
}
float rLiniowe(float b, float c)
{
	return -c/b;
}

int main ()
{

	float a,b,c,d;

	printf("Rownanie kwadratowe: a*x*x+b*x+c=0 \n");
	printf("Podaj a: ");
	scanf("%f", &a);
	printf("Podaj b: ");
	scanf("%f", &b);
	printf("Podaj c: ");
	scanf("%f", &c);

	if(a==0)	
		printf("x jest rowne: %g\n", rLiniowe(b,c));
	else {
		d = delta(a,b,c);
		printf("Delta rownania wynosi: %g\n", d);
		if (d < 0)
			printf("Rownanie nie ma rozwiazan\n");
		else if (d == 0) 
			printf("Jest tylko jedno rozwiazanie:\n x = %g\n",jednRozw(a,b));
		else if (d > 0)
			printf("Sa dwa rozwiazania rowne:\nx1=%g\nx2=%g\n",pierwX1(a,b,d), pierwX2(a,b,d));
	}
	return 0;
}
