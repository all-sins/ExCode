#pragma hdrstop
#pragma argsused

#include <stdio.h>
#include <conio.h>
#include <iostream.h>
#include <stdlib.h>

/*
 1. PARBAUDES
 2. PARBAUDES
 3. PRECIZEJUMS PIE IZVADES

 Izveidot masivu. Masiva maksimalais izmers ir 100 elementi.
 Nedrikst izmantot otru masivu! Izmainam janotiek taja pasa masiva!
 Lietotajam jabut iespejams izmainit cik elementus velas ievadit masiva!
 Kad programma pabeigta, prasa vai atkartot.

 Arturs Alsins P1-3
 21. Variants
 Masivs no N elementiem satur latinu alfabeta burtus.
 Noteikt cik reizes masiva ir sastopams katrs burts.
 */

int main() {
	// Mainigie
	int i, n, j, lielieBurti, mazieBurti, currentCharCount, forOutputFormating, forAdditionalOutputFormating;
	i = n = j = lielieBurti = mazieBurti = currentCharCount = forOutputFormating = forAdditionalOutputFormating = 0;
	char ievade[100];
	char c, c2, REPEAT, currentChar;

	do {
		do {

			// Teksta krasa - sarkana
			system("COLOR F");
			system("cls");

			// Nosacijumu pieteiksana
			printf("Ludzu nemiet vera, ka TIKAI vertibas,");
			printf(" \nkas pieder skaitlu intervalam no 1 lidz 100 ieskaitot tiks pienemtas.");
			printf("\nNepareizas ievades gadijuma programma atkartos vaicajumu.\n");

			// Elementu skaita ievade
			printf("\nLudzu ievadiet cik burtus velaties ievadit...\n\n");
			scanf("%u", &n);
			system("cls");
			if ((n <= 0) || (n > 100)) {

				// Teksta krasa - sarkana
				system("COLOR C");
				system("cls");

                // CONTINUE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				// c = atoi(n);
				// sprintf(c, "%d", n);
				printf("n = %c\n", n);
				printf("\t\t!!! Kluda !!!\n %c nepieder pie veselo skaitlu intervala [1 - 100]!", n);
				getch();
			}
		}
		while ((n <= 0) || (n > 100));

		// Programa skaita no 0-ta elementa.
		n -= 1;

		system("COLOR F");
		system("cls");

		for (i = 0; i <= n; i++) {

			// Char mainigais lietotaja ievades uzglabasanai
			char c;

			// Lietotajs skaita no 1 lidz n.
			// Izvade pieskaita viens, lai saglabatu logiku
			do {
				printf("Ievadiet %u. elementu!\n", i + 1);
				cin >> c2;
				system("cls");
			} while ( !( (c2 >= 'A') && (c2 <= 'Z')   || (c2 >= 'a') && (c2 <= 'z') ) );

				ievade[i] = c2;

			// Lielo un mazo burtu uzskaite
			if ((ievade[i] >= 'A') && (ievade[i] <= 'Z')) {
				lielieBurti++;

				/* ![=]! FOR DEBUGGING ![=]!
				printf("%c ir lielais burts!\n", ievade[i]);
				printf("Lielo burtu skaits = %u\n", lielieBurti);
				getch();
				system("cls");
				*/

			}
			else if ((ievade[i] >= 'a') && (ievade[i] <= 'z')) {
				mazieBurti++;

				/* ![=]! FOR DEBUGGING ![=]!
				printf("%c ir mazais burts!\n", ievade[i]);
				printf("Mazo burtu skaits = %u\n", mazieBurti);
				getch();
				system("cls");
				*/

			}
		};

		for (i = 0; i <= n; i++) {

			if (ievade[i] != ievade[i + 1]) {
			// if () There probably is a way to fix the doubles,
			// but I can only think of a way with another array

				forOutputFormating++;
				currentChar = ievade[i];
				currentCharCount = 0;

				for (j = 0; j <= n; j++) {

					/* ![=]! FOR DEBUGGING ![=]!
					 system("cls");
					 printf("CycleCounter = %d\n", j);
					 printf("%d %c's counted so far!\n", currentCharCount, currentChar);
					 printf("%c = %c ?\n\n", ievade[j], currentChar);
					 getch();
					 */

					if (ievade[j] == currentChar) {

						/* ![=]! FOR DEBUGGING ![=]!
						 printf("%c = %c\nIncreasing currentCharCount!\n\n", ievade[j], currentChar);
						 */

						currentCharCount++;
					}
				}

				/* ![=]! FOR DEBUGGING ![=]!
				 } else {
				 printf("%c != %c\nDoing nothing!\n\n", ievade[j], currentChar);
				 }
				 */

				if (i == 0) {
					printf("\t\t\tBurti un to skaits\n\n");
				};

				if (forOutputFormating % 5 == 0) {
					printf("%c = %d\n", currentChar, currentCharCount);
					forAdditionalOutputFormating = 1;
				}
				else {
					printf("%c = %d\t", currentChar, currentCharCount);
					forAdditionalOutputFormating = 0;
				}
			}
		};

		// Masiva elementu vertibu izdruka
		/*
		 for (i = 0; i <= n; i++) {
		 printf("%u. elementa vertiba = %c\n", i+1, ievade[i]);
		 }
		 */

		// Krasas nomainisana, mazo un lielo burtu skaita izdruka
		printf("\n\nMazie burti = %u\n", mazieBurti);
		printf("Lielie burti = %u\n", lielieBurti);

		// Vaicajums lietotajam vai velas atkartot programmu
		printf("\n\n\t\tVai velaties atkartot programmu?\n");
		printf("\n\"Ja\" vai \"ja\"\t-\tJa, atkartot programmu.");
		printf("\nJebkas cits\t-\tNe, aizvert programmu.\n\n");
		cin >> REPEAT;
	}
	while ((REPEAT == 'y') || (REPEAT == 'Y'));
}
