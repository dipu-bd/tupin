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
    |      Variable  Declarations       |
     *----------------------------------*/    

Declaration: ID '=' Expression
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
    |             Conditions            |
     *----------------------------------*/         
Condition: IF '(' Expression ')' Block Branch
    | IF '[' ID ']' '{' Switch '}' 
    ;

Branch: /* can be empty */
    | ELSE Block
    | ELIF '(' Expression ')' Block Branch
    ;

Switch: Choice
    | Switch ',' Choice
    ;

Choice: Literal ':' '{' Block '}' 
    ;

    /*---------------------------------_ 
    |               Looping             |
     *----------------------------------*/    
Loop: FOR '(' Expression ')' '{' Block '}'
    | FOR '(' Declaration ';' Expression ';' Expression ')' '{' Block '}'
    | FOR '[' LoopIterator ']' '{' Block '}'
    | FOR '[' ID LoopIterator ']' '{' Block '}'
    ;

LoopIterator: 
    | Literal TO Literal
    | Literal TO Literal BY Literal
    | Expression
    ;

    /*---------------------------------_ 
    |         Function Call             |
     *----------------------------------*/    
FunctionCall: ID '(' ParamList ')'
    ;

ParamList: /* can be empty */
    | Params
    ;

Params: Expression
    | Params ',' Expression
    ;

    /*---------------------------------_ 
    |        Array Definition           |
     *----------------------------------*/    

Array: '{' ParamList '}'
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