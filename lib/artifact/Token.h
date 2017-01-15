#include <iostream>
#include "Pos.h"

#ifndef __TUPIN_TOKEN__
#define __TUPIN_TOKEN__ 1

class Token : public Pos
{
  protected:
    int type;
    std::string val;

  public:
    Token(int _type = 0,
          int _line = -1,
          int _col = -1,
          const char *_val = "") : Pos(_line, _col),
                                   type(_type),
                                   val(_val)
    {
    }

    std::string data() const
    {
        return val;
    }

    friend std::ostream &operator<<(std::ostream &o, const Token &t)
    {
        return o << t.line << ":" << t.col << ": " << t.val;
    }
};

#endif