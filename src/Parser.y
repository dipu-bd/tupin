%{ 
    #include "commons.hpp"     
    #include "ParserHelper.hpp"  

    int _t_index = 0;
    string _head, _tail;
    map<string, string> _var;
    stack<int> _stk;

    void init()
    {
        _stk.push(_t_index);
    }
    void clear()
    {
        _head = "";
        _tail = "";
        _var.clear();
        _t_index = _stk.top();
        _stk.pop();
    }
    void head(string exp)
    {
        _head += exp + "\n";
    }
    void tail(string exp)
    {
        _tail = exp + "\n" + _tail;
    }
    string var(string name)
    {
        string& id = _var[name];
        if(id.empty()) {
            id = "$" + to_string(_var.size());        
        }
        return id;
    }
    string tmp()
    {        
        return "$t" + to_string(_t_index++);
    }

%}

%verbose   
 
%token DEF IF ELIF ELSE FOR RETURN CONTINUE BREAK TO BY
%token STRING INT FLOAT ID COMMENT THREEDOT
%token EQOP PWREQ 
%token OR AND EQ NE LEQ GEQ SHR SHL INC DEC PWR
 
%right EQOP PWREQ 
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
Program: Program Expression ';' { cout << $2 << endl; }
    | error
    | 
    ;

Expression:         { init(); } 
        Assign      { $$ = _head + _tail + "Res = " + $2; clear(); }
    ;
    
    /*---------------------------------_ 
     |           Assignment             |
     *----------------------------------*/ 

Assign: Var '=' Assign      { $$ = $1; head($1 + "=" + $3); }
    | Var EQOP Assign       { $$ = $1; head($1 + $2 + $3); } 
    | Var PWREQ Assign      { $$ = $1; head($1 + "=power(" + $1 + "," + $3 + ")"); }
    | Boolean               { $$ = $1; }
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

Value: Value SHL Math       { $$ = tmp(); head($$ + "=" + $1 + "<<" + $3); }
    | Value SHR Math        { $$ = tmp(); head($$ + "=" + $1 + ">>" + $3); }
    | Math                  { $$ = $1; }
    ;

Math: Math '+' Factor       { $$ = tmp(); head($$ + "=" + $1 + "+" + $3); }
    | Math '-' Factor       { $$ = tmp(); head($$ + "=" + $1 + "-" + $3); }
    | Factor                { $$ = $1; }
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

Term: '(' Assign ')'        { $$ = $2; } 
    | Number                { $$ = $1; }
    | Var                   { $$ = $1; }
    | Var INC               { $$ = $1; tail($1 + "=" + $1 + "+1"); }
    | Var DEC               { $$ = $1; tail($1 + "=" + $1 + "-1"); }
    | INC Var               { $$ = $2; head($2 + "=" + $2 + "+1"); }
    | DEC Var               { $$ = $2; head($2 + "=" + $2 + "-1"); }
    /*
    | FunctionCall
    | MemberAccess
    */
    ;

Number: INT     { $$ = $1; }
    | FLOAT     { $$ = $1; }
    ;

Var: ID         { $$ = var($1); }
    ;

%% 

int main(int argc, char** argv)
{ 
    return MainFunction(argc, argv);
}
