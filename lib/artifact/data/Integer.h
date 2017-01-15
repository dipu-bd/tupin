#include "Number.h"

#ifndef __TUPIN_INTEGER__
#define __TUPIN_INTEGER__ 1

class Integer : public Number<long long>
{
  public:
    long long cast(const char *s) const
    {
        std::strtoll(s, NULL, 0);
    }
};

#endif