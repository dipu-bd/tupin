#include "Number.h"

#ifndef __TUPIN_FLOAT__
#define __TUPIN_FLOAT__ 1

class Float : public Number<double>
{
  public:
    double cast(const char *s) const
    {
        return std::strtod(data(), NULL);
    }
};

#endif