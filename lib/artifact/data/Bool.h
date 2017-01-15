#include "Number.h"

#ifndef __TUPIN_BOOL__
#define __TUPIN_BOOL__ 1

class Bool : public Number<bool>
{
  public:
    bool cast(const char *s) const
    {
        return (val != "false") || std::strtol(data(), NULL, 0);
    } 
};

#endif