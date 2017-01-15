#include <iostream>
#include "../Token.h" 
#include "Number.h"

#ifndef __TUPIN_STRING__
#define __TUPIN_STRING__ 1

class String : public Token
{
  public:
    operator std::string() const
    {
        return val;
    }

    template <typename T>
    operator Number<T>() const
    {
        return Number<T>(*this);
    }
};

#endif