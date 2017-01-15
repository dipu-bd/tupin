using namespace std;

/* Predefined actions */
#define YY_USER_ACTION token.update(yylineno, yyleng);

#define __RETURN(x) return retToken(x,#x)
#define __ERROR(x)  yyerror(x, token.line, token.column, token.file)

#define __NEWLINE token.newline(); // printf("\n%3d. ", yylineno); 
#define __INITIALIZE token.update(0, 0); // printf("%3d. ", yylineno);

/* Creating instance of YYToken */
YYToken token;

/* Debuggin and token returns */
int retToken(int type, const char *str)
{ 
    #ifdef DEBUG
    printf("~%s:%d:%d:%s %s\n", 
        token.file,
        token.line, 
        token.column, 
        str, 
        token.val.data());
    #endif

    if(yylval.token) delete yylval.token;
    yylval.token = new Token(type, token);
    return type;
} 

/* Function definitions for parser*/
void init(int argc, char** argv)
{ 
    if(argc >= 1) {
        token.file = argv[1];
        yyin = fopen(argv[1], "r");
    }
    if(argc >= 2) {
        token.outfile = argv[2];
        yyout = fopen(argv[2], "w");	
    }
}

/* Function definitions for lexer*/
std::string toNumber(const char *s, int base = 10)
{ 
    char out[50] = { };
    if (base >= 2)
    {
        long long n = std::strtoll(s, NULL, base);
        sprintf(out, "%lld", n);
    }
    else if(base == 1) 
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

