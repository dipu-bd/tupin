#include <bits/stdc++.h>
#include "Token.hpp";
using namespace std;

union LVal 
{
    Token token;
}

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef LVal YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

int yylex (void);
int yyparse(void);

void yyerror(const char *msg);
void yyerror(const char *msg, int line, int col, const char* file = "");

void init(int argc, char** argv);  
int MainFunction(int argc, char** argv);
