#include <iostream>

#ifndef __YYTOKEN__
#define __YYTOKEN__

class YYToken
{
  public:
    int line;
    int column;
    int type;
    std::string val;
    const char *file;
    const char *outfile;

    YYToken()
        : line(0), column(0),
          file("~"), outfile("~"),
          val(""), type(-1)
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