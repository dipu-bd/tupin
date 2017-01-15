#include <iostream>

#ifndef __TUPIN_POS__
#define __TUPIN_POS__

class Pos
{
public:
    int col;
    int line;

    Pos(int l = -1, int c = -1)
        : line(l), col(c)
    {
    }

    friend std::ostream &operator<<(std::ostream &o, const Pos &p)
    {
        return o << p.line << ":" << p.col;
    }
};

#endif