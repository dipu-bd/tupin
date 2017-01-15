#include <iostream>
#include "Pos.h"

#ifndef __TUPIN_TOKEN__
#define __TUPIN_TOKEN__ 1

class Token : public Pos
{
  protected:
    int type;
    std::string val;
    const char *file;

  public:
    Token(int _type = 0,
          int _line = -1,
          int _col = -1,
          std::string _val = "",
          const char *_file = 0) : Pos(_line, _col),
                                   type(_type),
                                   val(_val),
                                   file(_file)
    {
    }

    std::string value()
    {
        return val;
    }

    friend std::ostream &operator<<(std::ostream &o, const Token &t)
    {
        return o << "~" << t.file << ":" << t.line << ":" << t.col << ": " << t.value();
    }
};

#endif