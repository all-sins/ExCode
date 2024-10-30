#include <iostream.h>
#include <stdlib.h>

//Jautât, vai lietotâjs grib atkartot programmu
char izvelne() {
/*
      Pçc piektâ darba uzdevuma pârveidot masîvu par dinamisko. jâbût iespçjai:
      1.1. Izveidot masîvu no jauna (ja jau eksistç - tad sâkumâ atbrîvot atmiòu);
      1.2. Aizpildît automâtiski;
      1.3. Aizpildît manuâli.
*/
    //lietotaja atbilde
    char atb;

    cout << "\nIzvelies: \n";

    cout << "1 - Aizpildit masivu automatiski\n";
    cout << "2 - Aizpildit masivu manuali\n";
    cout << "\n$ ";

    cin >> atb;

    return atb;
}

char izvelne2() {
/*
Tâlâk jâbût iespçjai pçc lietotâja izvçles (ciklâ):
      2.1. Izpildît individuâlo uzdevumu;
      2.2. Izmainît masîva izmçru, saglabâjot masîvâ iepriekðçjâs vçrtîbas (ja parâdâs jauni elementi,
         tad jâaizpilda manuâli tikai tie);
      2.3. Sâkt programmu no sâkuma;
      2.4. Beigt darbu
*/
    //lietotaja atbilde
    char atb;

    cout << "\nIzvelies: \n";

    cout << "1 - Izpildit individualo uzdevumu\n";
    cout << "2 - Izmainit masiva izmeru saglabajot ieprieksejas vertibas\n";
    cout << "3 - Sakt programmu no sakuma\n";
    cout << "4 - Beigt darbu\n";
    cout << "\n$ ";

    cin >> atb;

    return atb;
}

int jautat_izmeru() {
    //masiva izmers
    int n;

    do {
        cout << "Ievadi masiva izmeru (jabut > 0): ";
        cin >> n;
    } while (n < 1);

    return n;
}

int skaitit_lvs(double *arr, int n) {
    //LIS - Largest Increasing Subsequence (visgaraka augosa apaksvirkne)
    //LIS garums
    int lis_length = 1;
    //vieta masiva kur sakas LIS
    int lis_start = 0;
    //satur augosas apaksvirknes garumu for iteracija
    int is = 1;
    int i = 0;

    // atrod LIS sakumu un garumu
    for (i = 0; i < n; i++) {
        if (i != 0){
            if (arr[i] > arr[i-1]) {
                is++;

                if (is >= lis_length) {
                    lis_length = is;
                    lis_start = i - lis_length;
                }
            } else {
                is = 1;
            }
        }
    }

    lis_start++;

    if (lis_length == 1) {
        cout << "\nNav Visgaraka Augosa Apaksvirkne.\n";
    } else {
        cout << "\n\nVisgaraka Augosa Apaksvirkne: \n";

        for (i = lis_start; i < lis_start + lis_length; i++)
            cout << arr[i] << "\t";\

        cout << "\n\n";
        cout << "Garums: " << lis_length << "\n";

    }

    return 0;
}

void print_double_arr(double *arr, int n) {
    int i = 0;

    cout << "\nMasiva vertiba: \n";

    for (i = 0; i < n; i++)
        cout << arr[i] << "\t";
}

