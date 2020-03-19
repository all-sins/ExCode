Failu virsrasti C++

Virsrasta failu nosauumu vietā C++ valodā tie izmantoti standarta identifiatori. Tiem nevajag norādīt .h .
	#include <iostream>

C++ standarta bibliotēas tiek definētas savā lokālajā nosaukumu telpā std

Tās metodēm jalieto telpas vārds
	std::cout <<"Sveika, pasaule!";

Ertākai izmantošanai jālieto
	using namespace std;


Vairāku failu programmas

Klašu apraksts - .h failos
Klašu metožu definīcijas - .cpp failos
Funkcija "main()" - citā .cpp failā


Triangle.h

class Triangle
{
	public:
		float a, b, c; // malas
		float getArea();
		float getPerimeter();
}

#include <math.h>
#include "Triangle.h"

float Triangle::getArea()
{
	float p;
	p = (a + b + c) / 2;
	return sqrt(p * (p - a) * (p - b) * (p - c));  // Herona formula
}

float Triangle::getPerimeter()
{
	return (a + b + c);
}


TestTriangle.cpp

#include <iostream>
#include "Triangle.cpp"
using namespace std;

void main()
{
	Triangle tr;
	tr.a = 50;
	tr.b = 60;
	tr.c = 35;

	float trArea(); //definē mainīgo, kas saglabās trijstūra laukuma
	cout << "Area of triangle is " << trArea << '\n';
	cout << "Perimeter of triangle is " << tr.getPerimeter() << endl;
}