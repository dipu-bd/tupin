#include <bits/stdc++.h>
#include "Environment.h"

typedef string YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1

#ifdef DEBUG
    int dbgToken(int tok, const char *s)
    {
        printf("token %s\n", s);
        return tok;
    }
    int dbgTokenValue(int tok, const char *s)
    {
        printf("token %s = %s\n", s, yylval);
        return tok;
    }
    #define __RETURN(x) return dbgToken(x, #x)
    #define __RETURN_VAL(x) return dbgTokenValue(x, #x)
#else
    #define __RETURN(x) return (x)
    #define __RETURN_VAL(x) return (x)
#endif

///////////////////////////////////////////////////////////////////////////////////////

Environment env;    

void yyerror(const char *msg)
{
    fprintf(stderr, "%s:%d:%d: %s\n", 
        env.input(),
        yylloc.last_line,
        yylloc.last_column,
        msg);
}

/* Convert string to number and again revert to string */
string toNumber(const char *s, int base = 10)
{
    const char out[50];
    if (base >= 2)
    {
        long long n = std::strtoll(s, NULL, base);
        sprintf(out, "%lld", n);
    }
    else if(base == 1) {
        bool b = strcmp(s, "false");
        sprintf(out, "%d", b);
    }
    else
    {
        double d = std::strtod(s, NULL);
        sprintf(out, "%g", d);
    }
    return out;
} 
 
