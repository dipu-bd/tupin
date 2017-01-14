using namespace std;

/* Creating instance of Token */
Token token;

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

/* Debuggin and token returns */
int retToken(int tok, const char *s)
{ 
    yylval.token = token;
    #ifdef DEBUG
    printf("%s:%d:%d: %s\n", 
        token.file.data(),
        token.line, token.column, 
        s, token.val.data());
    #endif
    return tok;
} 

/* Function definitions for parser*/
void init(int argc, char** argv)
{ 
    if(argc >=1) {
        yyin = fopen(argv[1], "r");
        token.file = argv[1];
    }
    if(argc >= 2) {
        yyout = fopen(argv[2], "w");	
        token.outfile = argv[2];
    }
}

