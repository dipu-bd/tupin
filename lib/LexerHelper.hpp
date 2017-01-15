using namespace std;

/* Predefined actions */
#define __NEWLINE newLine(); // printf("\n%3d. ", yylineno);
#define __INITIALIZE         // printf("%3d. ", yylineno);

#define __ERROR(x) yyerror(x, line, column, env.sourceFile().data());

#define YY_USER_ACTION updateColumn(yyleng);

#define __RETURN(x) return retToken(x, #x);
#define __RETURN_VAL(x) \
    token = yytext;     \
    return retToken(x, #x);

/* Creating instance of YYToken */
string token;
int line = 0;
int column = 0;
FileSystem env;

void newLine()
{
    line++;
    column = 0;
}

void updateColumn(int len)
{
    column += len;
}

/* Debuggin and token returns */
int retToken(int type, const char *str)
{
#ifdef YYDEBUG
    printf("~%s:", env.sourceFile().data());
    printf("%d:%d:%s ", line, column, str);
    printf("%s\n", token.data());
#endif
 
    yylval = token;
    return type;
}

/* Function definitions for lexer*/
std::string toNumber(const char *s, int base = 10)
{
    char out[50] = {};
    if (base >= 2)
    {
        long long n = std::strtoll(s, NULL, base);
        sprintf(out, "%lld", n);
    }
    else if (base == 1)
    {
        bool b = strcmp(s, "false");
        sprintf(out, "%d", (int)b);
    }
    else
    {
        double d = std::strtod(s, NULL);
        sprintf(out, "%f", d);
    }
    return out;
}
