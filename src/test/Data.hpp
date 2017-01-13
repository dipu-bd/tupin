
using namespace tupin;
using namespace std;

void testString()
{
    
}

void testNumber()
{
    int oa = 20;
    int ob = 22;
    Number a(oa);
    Number b(22);

    assert(a == oa);
    assert(ob == b);

    Number r = a + b;
    assert(r == 42);
    assert(string(r) == "42");

    assert(a != b);

    assert(-a == -oa);
    assert(a + b == oa + ob);
    assert(a - b == oa - ob);
    assert(a * b == oa * ob);
    assert(a / b == oa / ob);
    assert(a % b == oa % ob);

    assert(a + ob == oa + ob);
    assert(a - ob == oa - ob);
    assert(a * ob == oa * ob);
    assert(a / ob == oa / ob);
    assert(a % ob == oa % ob);

    assert((~a) == (~oa));
    assert((a | b) == (oa | ob));
    assert((a ^ b) == (oa ^ ob));
    assert((a & b) == (oa & ob));
    assert((a >> 3) == (oa >> 3));
    assert((a << 3) == (oa << 3));

    assert((oa | b) == (oa | ob));
    assert((oa ^ b) == (oa ^ ob));
    assert((oa & b) == (oa & ob));

    assert((!b) == (!ob));
    assert((a || b) == (oa || ob));
    assert((a && b) == (oa && ob));
    assert((oa || b) == (oa || ob));
    assert((a && ob) == (oa && ob));
        
    a += b;
    assert(a == oa + ob);
    assert((a -= b) == oa);
    assert((a *= b) == oa*ob);
    assert((a /= b) == oa);

    assert((r %= a) == (a + b) % oa);
    
    r = a; assert((r ^= b) == (oa ^ ob));
    r = a; assert((r |= b) == (oa | ob));
    r = a; assert((r &= b) == (oa & ob));
    r = a; assert((r >>= 3) == (oa >> 3));
    r = a; assert((r <<= 3) == (oa << 3));
}

void printTypes()
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