#include <iostream>

#ifndef __TUPIN_YYTOKEN__
#define __TUPIN_YYTOKEN__

class YYToken
{
  public:
    int line;
    int column;
    int type;
    std::string val;
    std::string file;
    std::string outfile;

    YYToken()
        : line(0), column(0),
          val(""), type(-1),
          file(""), outfile("")
    {
    }

    void newline()
    {
        column = 0;
    }
    void update(int _line, int _len)
    {
        line = _line;
        column += _len;
    }
};

#endif