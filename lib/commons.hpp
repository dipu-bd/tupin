#include <bits/stdc++.h> 
#include "FileSystem.h"
#include "artifacts.h"

#define YYDEBUG 1

int yylex (void);
int yyparse(void);

void yyerror(const char *msg);
void yyerror(const char *msg, int line, int col, const char* file);

void init(int argc, char** argv);  
int MainFunction(int argc, char** argv);
 
int retToken(int type, const char *str); 

std::string getFileName(const char *file)
{
    if(!file) return "";
    string str = file;
    size_t found = str.find_last_of("/\\");
    string folder = str.substr(0,found);
    string file = str.substr(found + 1);
    strnig cur = 
}