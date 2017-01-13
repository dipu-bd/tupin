/**
    @description 
        Convert escaped sequence to actual character.
        It assumes the input will always be syntactically correct.
        Can handle: Hexadecimal, Octal, and "abfnrtv".
    @return 
        The escaped character on success. A negative value on failure.
*/
int escapeToChar(const char *str)
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
