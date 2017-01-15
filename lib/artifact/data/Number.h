#include "../Token.h"

#ifndef __TUPIN_NUMBER__
#define __TUPIN_NUMBER__ 1

template <typename T>
class Number : public Token 
{
protected:
    T nval;

public:
    Number(const Token& tok): Token(tok)
    {
        nval = convert(data());
    }

    virtual T cast(const char *) const;

    operator T() const { return nval; }
};

#endif