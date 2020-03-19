#include <stdio.h>
#include <conio.h>
// 1. Piemērs - Hello world
void main()
{
	int g = 2017;
	printf("\nSveika, pasaule!\n");
	printf("\nPa'slaik ir %d. gads\n", g); // %d is the position for the variable g in the output
	getch();
}

#include <iostream.h>
#include <conio.h>
// 2. Piemērs - Hello world, alternative way to output data using libary <iostream.h> with command cout<<. Dirrect push to console.
void main()
{
	int g = 2017;
	cout<<"\nSveika, pasaule!\n"
	cout<<"\nPa'slaik ir %d. gads\n"
	getch();
}

// 3. Piemērs - 
#include <stdio.h>
#include <conio.h>
int main()
{
	float x, kvadr;
	printf("%f",&x);
	kvadr = x * x; //make function for x^y
	clrscr;
	printf("\nSkaitlis %8.2f kvadrātā = %.2f", x, kvadr);
	getch();
	return 0;
}

// 4. Piemērs -
#include <stdio.h>
#include <conio.h>
int main()
{
	float x;
	cout<<"\nIevadiet skaitli, kura kvadr'atu atrast: ";
	cin>>x;
	clrscr;
	cout<<"\nSkaitlis " <<x <<" kvadrātā ir " <<x * x;
	getch();
	return 0;
}

#include <iostream.h>
void main(int argc, char const *argv[])
{
	double x;
	cout<<"\nIevadiet pozitīvo skaitli\t";
	cin>>x;
	if (x>0)
	{
		cout<<
	}
	return 0;
}

#include <iostream.h>
void main(int argc, char const *argv[])
{
	int a = 2, b = 40, x;
	cout<<"Ievadiet skaitli x:\t";
	cin>>x;
	if ((x>=))
	{
		/* code */
	}
	else if (/* condition */)
	{
		/* code */
	}; //<--------------- important!!!
	else
	return 0;
}