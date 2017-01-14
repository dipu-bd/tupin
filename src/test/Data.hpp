
using namespace tupin;
using namespace std;

void testString()
{ /*
    const char* ca = "Hello";
    const char* cb = "World";
 
    String a(ca);
    String b = cb;
    String c("News");

    a = ca;    
    b = cb;
    
    assert(a != b);
    assert(a < b);
    assert(a <= b);
    assert(!(a == b));
    assert(!(a > b));
    assert(!(a >= b));

    assert(a == "Hello");
    assert(a <= "Hello");
    assert("Hello" >= a);
    assert("Hellos" != a);
    assert("Hellos" < b);
    assert(b > "Hellos");
 
    assert(a == ca);
    assert(a <= ca);
    assert(ca >= a);
    assert(ca != b);
    assert(ca < b);
    assert(b > ca); 
    
    assert(strlen("Hello") == a.size());
    assert(strlen("World") == b.size());
    assert("Hello World" == a + " " + b);

    assert(String("a") * 3 == "aaa");
    assert(String("ab") * 2 == "abab");
    assert(String("abc") * 1 == "abc");
    assert(String("ab") * 5 == "ababababab");

    puts(String("ab") * 10);

    for(int i = 0; i < a.size(); ++i)
    {
        putchar(a[i]);
    }
    puts(""); */
}

void testBool()
{
    Bool a(true);
    Bool b(false);
    
    assert(a);
    assert(!b);

    assert(a != b);
    assert(a || b);
    assert(!(a && b));
    
    assert("true" == string(a));
    assert("false" == string(b));
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

    assert(a < b);
    assert(a <= b);
    assert(!(a > b));
    assert(!(a >= b));
    assert(!(a == b));    
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

    a = oa;  
    ob = b;
    assert(a == 20);
    assert(ob == 22);
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