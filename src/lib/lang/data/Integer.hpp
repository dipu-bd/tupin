#include "Number.hpp"
using namespace std;

class Integer : public Number
{
    typedef long long _ll;

  public:
    Integer() : val(0) {}

    string toString(const char *fmt) const
    {
        char out[20];
        sprintf(out, fmt, val);
        return out;
    }
    string toString(const char *fmt) const
    {
        return toString("%lld");
    }

    _ll value() const
    {
        return val;
    }
    Integer& value(_ll v)
    {
        val = v;
        return *this;
    }

  private:
    _ll val;
}