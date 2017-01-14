%{ 
    #include "commons.hpp"    
    #include "ParserHelper.hpp"    
%}
 
%token OP PWR PWREQ THREEDOT
%token STRING INT FLOAT ID 
%token DEF RETURN IF ELIF ELSE FOR CONTINUE BREAK AND OR NOT XOR TO BY
 
%%
    /*---------------------------------_ 
     |            Start Point           |
     *----------------------------------*/    
Program: Program Block 
    | Program Function
    |   /* NULL */
    ;

    /*---------------------------------_ 
     |       Functoin Definition        |
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
     |        Block's Definition        |
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
     |      Variable  Declarations      |
     *----------------------------------*/    

Declaration: ID '=' Expression
    ;

    /*---------------------------------_ 
     |         Print Statement          |
     *----------------------------------*/    
PrintStmnt: '[' PrintSequence ']'
    ;

PrintSequence: 
      PrintSequence STRING
    | PrintSequence Expression
    | STRING
    | Expression
    |   /* can be empty */
    ;

    /*---------------------------------_ 
     |            Conditions            |
     *----------------------------------*/         
Condition: IF '(' Expression ')' Block Branch
    | IF '[' ID ']' '{' Switch '}' 
    ;

Branch: ELIF '(' Expression ')' Block Branch
    | ELSE Block
    | /* can be empty */
    ;

Switch: Choice
    | Switch ',' Choice
    ;

Choice: Literal ':' '{' Block '}' 
    ;

    /*---------------------------------_ 
     |              Looping             |
     *----------------------------------*/    
Loop: FOR '(' Expression ')' '{' Block '}'
    | FOR '(' Declaration ';' Expression ';' Expression ')' '{' Block '}'
    | FOR '[' LoopIterator ']' '{' Block '}'
    | FOR '[' ID ':' LoopIterator ']' '{' Block '}'
    ;

LoopIterator: 
    | Literal TO Literal
    | Literal TO Literal BY Literal
    | Expression
    ;

    /*---------------------------------_ 
     |         Function Call            |
     *----------------------------------*/    
FunctionCall: ID '(' ParamList ')'
    ;

ParamList: Params 
    |    /* can be empty */
    ;

Params: Expression
    | Params ',' Expression
    ;

    /*---------------------------------_ 
     |        Array Definition          |
     *----------------------------------*/    

Array: '{' ParamList '}'
    ;

    /*---------------------------------_ 
     |            Expression            |
     *----------------------------------*/    
Expression: Literal
    | Number
    | ID 
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