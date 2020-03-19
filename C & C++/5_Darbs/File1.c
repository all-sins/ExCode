#pragma hdrstop
#pragma argsused

#include <stdio.h>
#include <conio.h>
#include <iostream.h>

/*
Izveidot masivu. Masiva maksimalais izmers ir 100 elementi.
Nedrikst izmantot otru masivu! Izmainam janotiek taja pasa masiva!
Lietotajam jabut iespejams izmainit cik elementus velas ievadit masiva!
Kad programma pabeigta, prasa vai atkartot.

Arturs Alsins P1-3
21. Variants
Masivs no N elementiem satur latinu alfabeta burtus.
Noteikt cik reizes masiva ir sastopams katrs burts.
*/

void main()
{
	// Mainigie
	int i, n = 0;
	char ievade[100];

	printf("Uzmanibu!\nMaksimalais ir 100!\nCik burti?\n");
	scanf("%u", &n);
	clrscr();

	for (i = 0; i <= n; i++) {
		char c;
		printf("Ievadiet %u. elementu!",i+1);
		cin >> c;
		//scanf("%c",c);
		ievade[i] = c;
		clrscr();
	}

	/*printf("Starting program!");
		for (0; i; i++) {
			printf("ASCII %c: %d \n", i,i);
		}
	*/
	// Beigas
	getch();
}
