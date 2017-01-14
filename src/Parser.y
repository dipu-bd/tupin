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
    /*---------------------------------_ 
    |            Start Point            |
     *----------------------------------*/    
Program: Program Block 
    | Program Function
    |
    ;

    /*---------------------------------_ 
    |       Functoin Definition         |
     *----------------------------------*/    
Function: DEF ID '(' Arguments ')' '{' Block '}'
    ;    

Arguments:  /* can be empty */
    | ArgVarList 
    ;

ArgVarList: ID
    | ArgVarList ',' ID
    ; 
    
    /*---------------------------------_ 
    |        Block's Definition         |
     *----------------------------------*/     
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

    /*---------------------------------_ 
    |             Declarations          |
     *----------------------------------*/    

Declaration: ID '=' Expression
    ;

Array: '{' ParamList '}'
    ;

    /*---------------------------------_ 
    |         Print Statement           |
     *----------------------------------*/    
PrintStmnt: '[' PrintSequence ']'
    ;

PrintSequence: /* can be empty */
    | STRING
    | Expression
    | PrintSequence STRING
    | PrintSequence Expression
    ;

    /*---------------------------------_ 
    |          Control Block            |
     *----------------------------------*/    
Condition:
    ;

Loop: 
    ;

    /*---------------------------------_ 
    |         Function Call             |
     *----------------------------------*/    
FunctionCall: 
    ;

ParamList:
    ;

    /*---------------------------------_ 
    |            Expression             |
     *----------------------------------*/    
Expression: Literal
    | Number
    | ID 
    | 
    ;
    
Literal: Number
    | STRING
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