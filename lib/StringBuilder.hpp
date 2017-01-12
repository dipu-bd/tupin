#include "utils.hpp"

struct StringBuilder
{
    int len;
    char *str;

    /* constructor */
    StringBuilder() : len(0), str(0) {}

    /* destructor */
    ~StringBuilder()
    {
        free(str);
    }

    /* methods */
    void init()
    {
        if (str)
            free(str);
        str = (char *)calloc(10, sizeof(char));
        len = 0;
    }

    void resize(int siz)
    {
        if (!str)
            init();
        int mini = siz * sizeof(char);
        int nsz = mini + 10 * sizeof(char);
        if (sizeof str <= mini)
        {
            str = (char *)realloc(str, nsz);
        }
    }

    void append(const char *src, int n)
    {
        resize(len + n);
        strncpy(str + len, src, n);
        len += n;
        str[len] = 0;
    }

    void append(const char ch)
    {
        resize(len + 1);
        str[len++] = ch;
        str[len] = 0;
    }

    bool escaped(const char *src)
    {
        int p = escapeToChar(src);
        if (p < 0)
            return false;
        append((char)p);
        return true;
    }

    const char *cstr() const
    {
        return str;
    }

    std::string toString() const
    {
        return str;
    }
};
