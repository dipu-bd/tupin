#include "Type.hpp"
#include "Number.hpp"
using namespace std;

typedef long long _ll;

class Integer : public Number
{   
  protected:
    _ll val;

  public:
    Integer() : val(0) {}
    Integer(const _ll &v) : val(v) {}

    int __type() const { return Type::INTEGER; }

    string toString() const;
    string toString(const char *fmt) const;

    _ll value() const;
    Integer &value(_ll v);  
};

// Member function definitions
string Integer::toString() const
{
    return toString("%lld");
}
string Integer::toString(const char *fmt) const
{
    char out[20];
    sprintf(out, fmt, val);
    return out;
}

_ll Integer::value() const
{
    return val;
}

Integer &Integer::value(_ll v)
{
    val = v;
    return *this;
} 