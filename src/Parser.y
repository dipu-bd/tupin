%{ 
    #include "commons.hpp"    
    #include "ParserHelper.hpp"    
%}

%verbose 
 
%token DEF RETURN IF ELIF ELSE FOR CONTINUE BREAK TO BY
%token STRING INT FLOAT ID 
%token AND OR NOT XOR
%token EQ NEQ LEQ GEQ
%token OP PWR PWREQ THREEDOT
 
%union 
{
    Token* token;
}

%type <token> STRING INT FLOAT ID

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
Condition: IF '(' Boolean ')' Block Branch
    | IF '[' ID ']' '{' Switch '}' 
    ;

Branch: ELIF '(' Boolean ')' Block Branch
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
     |       Variable  and Array        |
     *----------------------------------*/    

Declaration: ID '=' Expression
    | ID '=' ArrayDef
    ; 
 
ArrayDef: '{' ParamList '}'
    ;
    
ArrayUsage: ID '[' Expression ']'

    /*---------------------------------_ 
     |           Expressions            |
     *----------------------------------*/ 

Expression: Expression '+' Term
    | Expression '-' Term
    | Term
    ;

Term: Term '*' Unary 
    | Term '/' Unary 
    | Unary
    ;

Unary: '~' Unary 
    | '-' Unary 
    | Factor
    ;

Factor: '(' Boolean ')' 
    | Literal 
    | Location    
    ;
 
Boolean: Boolean OR Join 
    | Join 
    ;

Join: Join AND UnaryBoolean
    | UnaryBoolean 
    ;
UnaryBoolean: '!' Equality 
    | Equality  
    ;

Equality: Equality EQ Relation
    | Equality NEQ Relation
    | Relation 
    ;

Relation: Expression '<' Expression
    | Expression LEQ  Expression 
    | Expression GEQ Expression
    | Expression '>' Expression
    | Expression 
    ;

Location: ID   
    | ArrayUsage
    | FunctionCall  
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