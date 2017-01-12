#include "utils.hpp"

struct StringBuilder
{
    int len;
    char* str;

    ~StringBuilder() 
    {
        free(str);
    }

    void init() 
    {
        if(str) free(str);
        str = (char*)calloc(10, sizeof(char)); 
        len = 0;
    }

    void append(const char* src, int n) {
        str = (char*) realloc(str, (len + n + 5) * sizeof(char));
        strncpy(str + len, src, n);
        len += n; 
        str[len] = 0;
    }

    bool escaped(const char* src) {
        int p = escapeToChar(src);
        if(p < 0) return false;
        // append string
        char s[2] = {(char)p, 0};
        append(s, 1);
        return true;
    }
};

