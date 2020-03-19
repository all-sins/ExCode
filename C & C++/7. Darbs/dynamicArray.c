#pragma hdrstop
#pragma argsused

#include <stdio.h>
#include <tchar.h>

/*
Pēc piektā darba uzdevuma pārveidot masīvu par dinamisko. jābūt iespējai:
		1.1. Izveidot masīvu no jauna (ja jau eksistē - tad sākumā atbrīvot atmiņu);
		1.2. Aizpildīt automātiski;
		1.3. Aizpildīt manuali. Tālāk jābūt iespējai pēc lietotāja izvēles (ciklā):

		2.1. Izpildit individualo uzdevumu;
		2.2. Izmainit masiva izmēru, saglabājot masīvā iepriekšējās vērtības
			 (ja parādās jauni elementi, tad jāaizpilda manuāli tikai tie);
		2.3. Sakt programmu no sakuma;
		2.4. Beigt darbu

Piekta darba uzdevums: Izveidot masivu. Masiva maksimalais izmers ir 100 elementi.
Darba sakuma lietotajam tiek pieprasits ievadit pasreizejo izmeru N. Lietotajam
jadod iespeja pasam aizpildit masivu. Kad programma izpilda visas darbibas, lietotajam
tiek piedavats atkartot darbibas ar citu masiva izmeru vai beigt darbu.

Masivs no N elementiem satur realus skaitlus. Atrast apaksvirkni no 3 skaitliem
ar lielako elementu summu.

inputArray = (int*)malloc(garums * sizeof(int));
//  Declare array length

inputArray = (int*)realloc(inputArray, garums * sizeof(int));
// Resize array

integer = (int)floats;
// Convert data trype

*/

// Dinamiska masiva
int *inputArray;

// Ciklu skaititaji
int i;

void main()
{

	// Declaring array with user specified amout
	inputArray = (int*)malloc(length * sizeof(int));

	for (int i = 0; i !== 10; i++)
	{
		printf("%d", inputArray[i]);
	}

	printf("End of program...");
	getch();

}

