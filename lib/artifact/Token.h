#include <iostream>
#include "Pos.h"
#include "YYToken.h"

#ifndef __TOKEN__
#define __TOKEN__

class Token
{
public:
    Pos pos;
    int type;
    std::string val;    
    const char *file;

    Token(int _type, const YYToken& tok)
    {
        type = _type;
        val = tok.val;
        pos = Pos(tok.line, tok.column);
    }

    friend std::ostream &operator<<(std::ostream &o, const Token &t)
    {
        return o << "~" << t.file << ":" << t.pos << ":Token " << t.val;
    }
};

#endif