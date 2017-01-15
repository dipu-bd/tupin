#include <iostream>
#include "Pos.h"
#include "YYToken.h"

#ifndef __TUPIN_TOKEN__
#define __TUPIN_TOKEN__

class Token
{
public:
    Pos pos;
    int type;
    std::string val;    
    const char *file;

    Token(int _type, const Token& tok, const char* _file)
    {
        file = _file;
        pos = tok.pos;
        val = tok.val;
        type = tok.type;
    }

    friend std::ostream &operator<<(std::ostream &o, const Token &t)
    {
        return o << "~" << t.file << ":" << t.pos << ": " << t.val;
    }
};

#endif