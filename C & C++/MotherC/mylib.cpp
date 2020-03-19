#include <iostream.h>
#include <stdlib.h>

//Jaut�t, vai lietot�js grib atkartot programmu
char izvelne() {
/*
      P�c piekt� darba uzdevuma p�rveidot mas�vu par dinamisko. j�b�t iesp�jai:
      1.1. Izveidot mas�vu no jauna (ja jau eksist� - tad s�kum� atbr�vot atmi�u);
      1.2. Aizpild�t autom�tiski;
      1.3. Aizpild�t manu�li.
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
T�l�k j�b�t iesp�jai p�c lietot�ja izv�les (cikl�):
      2.1. Izpild�t individu�lo uzdevumu;
      2.2. Izmain�t mas�va izm�ru, saglab�jot mas�v� iepriek��j�s v�rt�bas (ja par�d�s jauni elementi,
         tad j�aizpilda manu�li tikai tie);
      2.3. S�kt programmu no s�kuma;
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

