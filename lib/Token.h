#include <iostream>
#include "Pos.h"

#ifndef __TUPIN_TOKEN__
#define __TUPIN_TOKEN__ 1

class Token : public Pos
{ 
  public:
    int type;
    std::string val;

    Token(int _type = 0,
          int _line = -1,
          int _col = -1,
          const char *_val = "") : Pos(_line, _col),
                                   type(_type),
                                   val(_val)
    {
    }

    const char* data() const
    {
        return val.data();
    }
 
    Token& operator = (const std::string& s)
    {
        val = s;
        return *this;
    }

    std::string tab(int siz = 4)
    {
        std::string nval = "";
        for(char ch : val)
        {
            nval.push_back(ch);
            if(ch == '\n')
            {
                for(int i = 0; i < siz; ++i)
                {
                    nval.push_back(' ');
                }
            }
        }    
        return nval; 
    }
};

#endif