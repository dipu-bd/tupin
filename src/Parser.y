%{ 
    #include "commons.hpp"     
    #include "ParserHelper.hpp"  

    int _t_index = 0;
    string _head, _tail;

    string tmp()
    {        
        return "$" + to_string(_t_index++);
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

Assignment: ID '=' Assignment   { $$ = $1; head($1 + "=" + $3); }
    | ID PWREQ Assignment       { $$ = $1; head($1 + "=power(" + $1 + "," + $3 + ")"); }
    | ID MODE Assignment        { $$ = $1; head($1 + "=" + $1 + "%" + $3); }
    | ID DIVE Assignment        { $$ = $1; head($1 + "=" + $1 + "/" + $3); }
    | ID MULE Assignment        { $$ = $1; head($1 + "=" + $1 + "*" + $3); }
    | ID PLSE Assignment        { $$ = $1; head($1 + "=" + $1 + "+" + $3); }
    | ID MNSE Assignment        { $$ = $1; head($1 + "=" + $1 + "-" + $3); }
    | ID ANDE Assignment        { $$ = $1; head($1 + "=" + $1 + "&" + $3); }
    | ID XORE Assignment        { $$ = $1; head($1 + "=" + $1 + "^" + $3); }
    | ID ORE Assignment         { $$ = $1; head($1 + "=" + $1 + "|" + $3); }
    | ID SHRE Assignment        { $$ = $1; head($1 + "=" + $1 + ">>" + $3); }
    | ID SHLE Assignment        { $$ = $1; head($1 + "=" + $1 + "<<" + $3); }
    | Boolean                   { $$ = $1; }
    ;
 
Boolean: Boolean OR Bits    { $$ = tmp(); head($$ + "=" + $1 + "||" + $3); }
    | Boolean AND Bits      { $$ = tmp(); head($$ + "=" + $1 + "&&" + $3); }
    | Bits                  { $$ = $1; } 
    ;

Bits: Bits '|' Compare      { $$ = tmp(); head($$ + "=" + $1 + "|" + $3); }
    | Bits '&' Compare      { $$ = tmp(); head($$ + "=" + $1 + "&" + $3); }
    | Bits '^' Compare      { $$ = tmp(); head($$ + "=" + $1 + "^" + $3); }
    | Compare               { $$ = $1; }
    ; 

Compare: Value EQ Value     { $$ = tmp(); head($$ + "=" + $1 + "==" + $3); } 
    | Value NE Value        { $$ = tmp(); head($$ + "=" + $1 + "!=" + $3); }
    | Value LEQ Value       { $$ = tmp(); head($$ + "=" + $1 + "<=" + $3); }
    | Value GEQ Value       { $$ = tmp(); head($$ + "=" + $1 + ">=" + $3); }
    | Value '<' Value       { $$ = tmp(); head($$ + "=" + $1 + "<" + $3); }
    | Value '>' Value       { $$ = tmp(); head($$ + "=" + $1 + "<" + $3); }
    | Value                 { $$ = $1; }
    ;

    /*---------------------------------_ 
     |           Expression             |
     *----------------------------------*/ 

Value: Value SHL Arithmatic         { $$ = tmp(); head($$ + "=" + $1 + "<<" + $3); }
    | Value SHR Arithmatic          { $$ = tmp(); head($$ + "=" + $1 + ">>" + $3); }
    | Arithmatic                    { $$ = $1; }
    ;

Arithmatic: Arithmatic '+' Factor   { $$ = tmp(); head($$ + "=" + $1 + "+" + $3); }
    | Arithmatic '-' Factor         { $$ = tmp(); head($$ + "=" + $1 + "-" + $3); }
    | Factor                        { $$ = $1; }
    ; 

Factor: Factor '*' Unary    { $$ = tmp(); head($$ + "=" + $1 + "*" + $3); }
    | Factor '/' Unary      { $$ = tmp(); head($$ + "=" + $1 + "/" + $3); }
    | Factor '%' Unary      { $$ = tmp(); head($$ + "=" + $1 + "%" + $3); }
    | Factor PWR Unary      { $$ = tmp(); head($$ + "=power(" + $1 + "," + $3 + ")"); }
    | Unary                 { $$ = $1; }
    ;

Unary: '!' Unary            { $$ = tmp(); head($$ + "=!" + $2); }
    | '~' Unary             { $$ = tmp(); head($$ + "=~" + $2); }
    | '-' Unary             { $$ = tmp(); head($$ + "=-" + $2); }
    | '+' Unary             { $$ = $2; }
    | Term                  { $$ = $1; }
    ;

Term: '(' Assignment ')'    { $$ = tmp(); head($$ + "=" + $2); } 
    | Number                { $$ = $1; }
    | ID                    { $$ = $1; }
    | ID INC                { $$ = $1; tail($1 + "=" + $1 + "+1"); }
    | ID DEC                { $$ = $1; tail($1 + "=" + $1 + "-1"); }
    | INC ID                { $$ = $2; head($2 + "=" + $2 + "+1"); }
    | DEC ID                { $$ = $2; head($2 + "=" + $2 + "-1"); }
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
