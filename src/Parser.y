%{ 
    #include "commons.hpp"     
    #include "ParserHelper.hpp"    
%}

%verbose  
%debug
 
%token DEF IF ELIF ELSE FOR RETURN CONTINUE BREAK TO BY
%token STRING INT FLOAT ID COMMENT
%token PWREQ SHRE SHLE EQOP 
%token EQ NE LEQ GEQ OR AND SHR SHL INC DEC PWR

%%
    /*---------------------------------_ 
     |            Start Point           |
     *----------------------------------*/    
Program: Program Expression ';'        { cout << $2 << endl; }
    | error
    | 
    ;

    /*---------------------------------_ 
     |           Expressions            |
     *----------------------------------*/ 

Expression: Expression '+' Unary       
    | Expression '-' Unary   
    | Expression '|' Unary   
    | Unary      
    ; 

Unary: '-' Factor 
    | '~' Factor
    | Factor 
    ;

Factor: Factor '*' Modulus 
    | Factor '/' Modulus
    | Factor '&' Modulus 
    | Modulus 
    ;

Modulus: Modulus '%' Power
    | Power
    ;

Power: Power PWR 
    | Power '^' 
    ;


    
Bool: Bool OR Not
    | Not 
    ;

Not: '!' BoolAnd
    | BoolAnd
    ;

BoolAnd: BoolAnd AND Compare
    | Compare
    ;

Compare: Compare '<' BoolVal
    | Compare '>' BoolVal
    | Compare LEQ BoolVal
    | Compare GEQ BoolVal
    | Compare EQ BoolVal
    | Compare NE BoolVal
    ;

BoolVal: '(' Expression ')'   
    | 
    
Number: INT     { $$ = $1; }
    | FLOAT     { $$ = $1; }
    ;

%% 

int main(int argc, char** argv)
{ 
    return MainFunction(argc, argv);
}
