%{ 
    #include "lib/ParserHelper.hpp"
%}

 
%token OP PWR PWREQ THREEDOT
%token STRING INT FLOAT ID 
%token DEF RETURN IF ELIF ELSE FOR CONTINUE BREAK AND OR NOT XOR TO BY

%union
{
    Token token
}

%%
Program: Program Block 
    | Program Function
    |
    ;

Function: DEF ID '(' Arguments ')' '{' Block '}'
    ;    

Arguments:  /* can be empty */
    | ArgVarList 
    ;

ArgVarList: ID
    | ArgVarList ',' ID
    ; 

Block : Loop
    | Condition
    | Statement 
    ;

Statement: SingleStmnt ';' 
    | '{' Block '}'
    ;

SingleStmnt: Declaration
    | PrintStmnt
    | Expression
    ;

Declaration: ID '=' Expression
    ;

PrintStmnt: '[' PrintSequence ']'
    ;

PrintSequence: /* can be empty */
    | STRING
    | Expression
    | PrintSequence STRING
    | PrintSequence Expression
    ;

Condition:
    ;

Loop: 
    ;

Array: '{' ParamList '}'
    ;

Expression:
    ;
    
Variable: ID
    ;

Literal: Number
    | STRING 
    | Array
    | ID
    ;

Number: INT
    | FLOAT
    ;

%% 

int main(int argc, char** argv)
{
    return MainFunction(argc, argv);
}

/*
https://github.com/rabishah/Mini-C-Compiler-using-Flex-And-Yacc/blob/master/c.y
*/