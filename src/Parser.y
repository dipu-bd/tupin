%{
    #include <bits/stdc++.h> 
    #include "lib/Token.hpp"

    int yylex (void);
    void init(int, char**);  
    void yyerror(const char *);
%}
 
/*%locations*/

%token OP PWR PWREQ
%token STRING INT FLOAT ID 
%token DEF RETURN IF ELIF ELSE FOR CONTINUE BREAK AND OR NOT XOR TO BY

%%

program: ; /* empty statement */

%% 

void yyerror(const char *msg, int line, int col, const char* file = "")
{
    fprintf(stderr, "%4s:%d:%d: %s\n", file, line, col, msg);
}

void yyerror(const char *msg)
{
    yyerror(msg, -1, -1);
}

int main(int argc, char *argv[])
{
    auto begin = std::chrono::high_resolution_clock::now();
    init(argc, argv);    

    int res = yyparse();

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>(end-begin).count();
    fprintf(stderr, "\n\nExited with status %d.\nRuntime: %f ms\n", res, duration / 1e6);
    return 0;
}

/*
https://github.com/rabishah/Mini-C-Compiler-using-Flex-And-Yacc/blob/master/c.y
*/