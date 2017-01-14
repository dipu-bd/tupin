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

    /**
    @description 
        Convert escaped sequence to actual character.
        It assumes the input will always be syntactically correct.
        Can handle: Hexadecimal, Octal, and "abfnrtv".
    @return 
        The escaped character on success. A negative value on failure.
    */
    friend int escapeToChar(const char *str)
    {
        int p = str[1];
        if (str[1] == 'x' || str[1] == 'X')
        {
            p = std::strtol(str + 2, 0, 16);
        }
        else if (isdigit(str[1]))
        {
            p = std::strtol(str + 1, 0, 8);
        }
        else
        {
            const char *real = "abfnrtv";
            const char *rplc = "\a\b\f\n\r\t\v";
            for (int i = strlen(real) - 1; i >= 0; --i)
            {
                if (p == real[i])
                {
                    p = rplc[i];
                    break;
                }
            }
        }

        if (p < 0 || p > 255)
            return -1;
        return p;
    }
};
