#include <bits/stdc++.h> 
#include "artifacts.h"
#include "FileSystem.h"

#define YYDEBUG 1
#define YYSTYPE Token

int yylex (void);
int yyparse(void);

void yyerror(const char *msg);
void yyerror(const char *msg, int line, int col, const char* file);

void init(int argc, char** argv);  
int MainFunction(int argc, char** argv);
 
int retToken(int type, const char *str); 