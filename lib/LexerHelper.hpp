using namespace std;

/* Predefined actions */
#define __NEWLINE newLine(); // printf("\n%3d. ", yylineno);
#define __INITIALIZE         // printf("%3d. ", yylineno);

#define __ERROR(x) yyerror(x, line, column, env.sourceFile());

#define YY_USER_ACTION updateColumn(yyleng);

#define __RETURN(x) return retToken(x, #x);
#define __RETURN_VAL(x) \
    token = yytext;     \
    return retToken(x, #x);

/* Creating instance of YYToken */
string token;
int line = 0;
int column = 0;
Environment env;

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
    printf("~%s:%d:%d:%s %s\n",
           env.sourceFile(),
           line,
           column,
           str,
           token.data());
#endif

    if (yylval.token)
        delete yylval.token;
    yylval.token = new Token(type, line, col, token, env.sourceFile());
    return type;
}

/* Function definitions for parser*/
void init(int argc, char **argv)
{
    env = Environment(argc, argv);
    if (argc > 1 && argv[1])
    {
        yyin = fopen(argv[1], "r");
    }
    if (argc > 2 && argv[2])
    {
        yyout = fopen(argv[2], "w");
    }
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
