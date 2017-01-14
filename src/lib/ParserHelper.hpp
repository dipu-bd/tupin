#include <bits/stdc++.h>
#include "Token.hpp"
using namespace std;

int yylex (void);
void init(int, char**);  
    
void yyerror(const char *msg, int line, int col, const char* file = "")
{
    fprintf(stderr, "%4s:%d:%d: %s\n", file, line, col, msg);
}

void yyerror(const char *msg)
{
    yyerror(msg, -1, -1);
}