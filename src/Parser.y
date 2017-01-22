%{ 
    #include "commons.hpp"     
    #include "ParserHelper.hpp"    
%}

%verbose   
 
%token DEF IF ELIF ELSE FOR RETURN CONTINUE BREAK TO BY
%token STRING INT FLOAT ID COMMENT THREEDOT
%token OR AND EQ NE LEQ GEQ SHR SHL INC DEC PWR
%token ANDE XORE ORE NOTE MNSE PLSE MULE DIVE MODE SHLE SHRE PWREQ 
 
%right ANDE XORE ORE NOTE MNSE PLSE MULE DIVE MODE SHLE SHRE PWREQ 
%left OR 
%left AND
%left '|'
%left '^'
%left '&'
%right '!'
%right '~'
%left EQ NE 
%left '<' LEQ '>' GEQ
%left SHL SHR
%left '+' '-'
%left '*' '/' '%'

%%
    /*---------------------------------_ 
     |            Start Point           |
     *----------------------------------*/    
Program: Program Assignment ';'        { cout << $2 << endl; }
    | error
    | 
    ;

    /*---------------------------------_ 
     |           Assignment             |
     *----------------------------------*/ 

Assignment: ID '=' Boolean  
    | ID PWREQ Boolean
    | ID SHRE Boolean
    | ID SHLE Boolean
    | ID MODE Boolean
    | ID DIVE Boolean
    | ID MULE Boolean
    | ID PLSE Boolean
    | ID MNSE Boolean
    | ID ANDE Boolean
    | ID XORE Boolean
    | ID ORE Boolean
    | Boolean
    ;
 
Boolean: Boolean OR Bits 
    | Boolean AND Bits
    | Bits 
    ;

Bits: Bits '|' Compare
    | Bits '&' Compare
    | Bits '^' Compare
    | Compare
    ; 

Compare: Expression EQ Expression 
    | Expression NE Expression
    | Expression LEQ Expression
    | Expression GEQ Expression
    | Expression '<' Expression
    | Expression '>' Expression
    | Expression
    ;

    /*---------------------------------_ 
     |           Expression             |
     *----------------------------------*/ 

Expression: Expression SHL Arithmatic
    | Expression SHR Arithmatic
    | Arithmatic    
    ;

Arithmatic: Arithmatic '+' Factor
    | Arithmatic '-' Factor
    | Factor
    ; 

Factor: Factor '*' Unary 
    | Factor '/' Unary
    | Factor '%' Unary
    | Unary
    ;

Unary: '!' Unary
    | '~' Unary
    | '-' Unary
    | '+' Unary
    | Term
    ;

Term: '(' Assignment ')'
    | Number
    | INC ID
    | DEC ID
    | ID INC     
    | ID DEC
 /*
    | FunctionCall
    | MemberAccess
    */
    ;

Number: INT 
    | FLOAT
    ;

%% 

int main(int argc, char** argv)
{ 
    return MainFunction(argc, argv);
}
