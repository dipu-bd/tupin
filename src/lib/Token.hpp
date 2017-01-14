#include <iostream> 
using namespace std;

struct Token
{
    string file;
    string outfile;
    int type;
    string val;
    int line;
    int column;

    Token() : line(0), 
              column(0), 
              file(""), 
              outfile(""), 
              val(""), 
              type(0) 
    { 

    }

    void clear() 
    {
        column = 0;
    } 
    void update(int _line, int len)
    {
        column += len;
        line = _line;
    }    

    Token copy()
    {
        Token tok;
        tok.val = val.data();
        tok.type = type;
        tok.line = line;
        tok.column = column;
        tok.file = file.data();
        tok.outfile = outfile.data();
        return tok;
    }
};
