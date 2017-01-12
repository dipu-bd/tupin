#include "utils.hpp"

struct StringBuilder
{
    int len;
    char str[1];

    void init() 
    {
        len = 0;
        str[0] = 0; 
    }

    void append(const char* src, int n) {
        strncat(str, src, n);
        len += n;
    }

    bool escaped(const char* src) {
        int p = escapeToChar(src);
        if(p < 0) return false;
        // append string
        char s[2];
        s[0] = (char)p;
        s[1] = 0;
        append(s, 1);
        return true;
    }
};

