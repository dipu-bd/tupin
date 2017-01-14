#include <iostream> 
using namespace std;

struct Token
{
    string file;
    string outfile;
    
    int line;
    int column;

    int type;
    string val;

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
};
