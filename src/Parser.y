%{ 
    #include "commons.hpp"     
    #include "ParserHelper.hpp"  

    int _t_index = 0;
    string _head, _tail;

    string tmp()
    {        
        return to_string(_t_index++);
    }
    void head(string exp)
    {
        _head += exp + "\n";
    }
    void tail(string exp)
    {
        _tail = exp + "\n" + _tail;
    }
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
Program: Program Assignment ';'        { cout << _head << "\n" << $2 << "\n" << _tail << "\n"; }
    | error
    | 
    ;

    /*---------------------------------_ 
     |           Assignment             |
     *----------------------------------*/ 

Assignment: ID '=' Assignment  
    | ID PWREQ Assignment
    | ID SHRE Assignment
    | ID SHLE Assignment
    | ID MODE Assignment
    | ID DIVE Assignment
    | ID MULE Assignment
    | ID PLSE Assignment
    | ID MNSE Assignment
    | ID ANDE Assignment
    | ID XORE Assignment
    | ID ORE Assignment
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

Compare: Value EQ Value 
    | Value NE Value
    | Value LEQ Value
    | Value GEQ Value
    | Value '<' Value
    | Value '>' Value
    | Value
    ;

    /*---------------------------------_ 
     |           Expression             |
     *----------------------------------*/ 

Value: Value SHL Arithmatic
    | Value SHR Arithmatic
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

Term: '(' Assignment ')'    { $$ = tmp(); head($$ + "=" + $2); } 
    | Number                { $$ = $1; }
    | INC ID                { $$ = $2; head($2 + "=" + $2 + "+1"); }
    | DEC ID                { $$ = $2; head($2 + "=" + $2 + "-1");}
    | ID INC                { $$ = $1; tail($2 + "=" + $2 + "+1");}
    | ID DEC                { $$ = $1; tail($2 + "=" + $2 + "-1");}
    | ID                    { $$ = $1; }
 /*
    | FunctionCall
    | MemberAccess
    */
    ;

Number: INT         { $$ = $1; }
    | FLOAT         { $$ = $1; }
    ;

%% 

int main(int argc, char** argv)
{ 
    return MainFunction(argc, argv);
}
