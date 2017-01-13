#include <bits/stdc++.h>
#include "../lib/tupin.h"
using namespace tupin;
using namespace std;

void testData()
{
    Number a(20);
    Number b(22);
    Number r = a + b;
    assert(r == 42);
    assert(string(r) == "42");
}

void testTypes()
{

    cout << typeid(int).name() << endl;
    cout << typeid(signed char).name() << endl;
    cout << typeid(short int).name() << endl;
    cout << typeid(long int).name() << endl;
    cout << typeid(long long int).name() << endl;
    cout << typeid(intmax_t).name() << endl;
    cout << typeid(size_t).name() << endl;
    cout << typeid(ptrdiff_t).name() << endl;
    cout << endl;
    cout << typeid(unsigned int).name() << endl;
    cout << typeid(unsigned char).name() << endl;
    cout << typeid(unsigned short int).name() << endl;
    cout << typeid(unsigned long int).name() << endl;
    cout << typeid(unsigned long long int).name() << endl;
    cout << typeid(uintmax_t).name() << endl;
    cout << endl;
    cout << typeid(float).name() << endl;
    cout << typeid(double).name() << endl;
    cout << typeid(long double).name() << endl;
    cout << typeid(wint_t).name() << endl;
    cout << endl;
    cout << typeid(int *).name() << endl;
    cout << typeid(signed char *).name() << endl;
    cout << typeid(short int *).name() << endl;
    cout << typeid(long int *).name() << endl;
    cout << typeid(long long int *).name() << endl;
    cout << typeid(intmax_t *).name() << endl;
    cout << typeid(size_t *).name() << endl;
    cout << typeid(ptrdiff_t *).name() << endl;
    cout << typeid(float *).name() << endl;
    cout << typeid(double *).name() << endl;
    cout << typeid(long double *).name() << endl;
    cout << typeid(wint_t *).name() << endl;
}

int main(int argc, char **argv)
{
    testData();
    return 0;
}