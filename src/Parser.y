%{ 
    #include "lib/ParserHelper.hpp"
%}
 
%token OP PWR PWREQ THREEDOT
%token STRING INT FLOAT ID 
%token DEF RETURN IF ELIF ELSE FOR CONTINUE BREAK AND OR NOT XOR TO BY

%%
Program: Program Block 
    | Program Function
    |
    ;

Block : Loop
    | Condition
    | Statement 
    ;

Function: DEF ID '(' Arguments ')' '{' block '}'
    ;    

Arguments:  /* can be empty */
    | ArgVarList 
    | ArgAsnList
    | ArgVarList ',' ArgAsnList
    ;

ArgVarList: Variable
    | ArgVarList ',' Variable
    ;

ArgAsnList: Variable '=' Literal
    | ArgAsnList ',' Variable '=' Literal
    ;

Variable: ID
    ;

Literal: INT
    | FLOAT
    | STRING 
    | Array
    ;


%% 

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