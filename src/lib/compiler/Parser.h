#include <bits/stdc++.h>
#include "lib/compiler/Environment.h"

#ifdef DEBUG
    int dbgToken(int tok, const char *s)
    {
        printf("token %s\n", s);
        return tok;
    }
    int dbgTokenValue(int tok, const char *s)
    {
        printf("token %s\n", s);
        return tok;
    }
    #define RETURN(x) return dbgToken(x, #x)
    #define RETURN_value(x) return dbgTokenvalue(x, #x)
#else
    #define RETURN(x) return (x)
    #define RETURN_value(x) return (x)
#endif
    
Environment env;    

void yyerror(const char *msg)
{
    fprintf(stderr, "%s:%d:%d: %s\n", 
        env.input(),
        yylloc.last_line,
        yylloc.last_column,
        msg);
}
