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
    string head()
    {
        return _head;
    }
    void head(string exp)
    {
        _head += exp + "\n";
    }
    string tail()
    {
        return _tail;
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
 
%token DEF IF ELSE FOR RETURN CONTINUE BREAK CASE
%token STRING INT FLOAT ID COMMENT THREEDOT
%token EQOP PWREQ 
%token OR AND EQ NE LEQ GEQ SHR SHL INC DEC PWR
 
%right EQOP PWREQ '='
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
Program: Program SingleBlock        { cout << $2 << endl; }
    | Program Function              { cout << $2 << endl; }
    | error 
    | 
    ;

SingleBlock: '{' Blocks '}'
    | Single ';'
    | Condition
    | Loop
    ;

Blocks: SingleBlock Blocks 
    |
    ;

    /*---------------------------------_ 
     |              Singles             |
     *----------------------------------*/ 

Single: Break       
    | Expression 
    |
    ; 

Break: BREAK
    | BREAK INT
    | CONTINUE
    | RETURN Expression
    ;

    /*---------------------------------_ 
     |           Loops                  |
     *----------------------------------*/ 
Loop: FOR '(' Expression ')' SingleBlock 
    ;

    /*---------------------------------_ 
     |           Conditions             |
     *----------------------------------*/ 
Condition: IF '{' SwitchBlock '}'
    | IF Var '{' SwitchBlock '}'
    ;

SwitchBlock: CaseBlock SwitchBlock
    | CaseBlock
    ;

CaseBlock: Expression ':' SingleBlock
    ;

    /*---------------------------------_ 
     |     Arrays and FunctionCall      |
     *----------------------------------*/ 
Array: '[' ArrayVal ']' 
    ;

ArrayVal: ArrayElem
    |
    ;

ArrayElem: Expression
    | Expression ',' ArrayElem
    ;

FunctionCall: ID '(' ArrayVal ')' 
    ; 
    
    /*---------------------------------_ 
     |           Function               |
     *----------------------------------*/ 
Function: DEF ID '(' Arguments ')' '{' Blocks '}'
    ;

Arguments: ArgNames
    |
    ;

ArgNames: ID ',' ArgNames
    | ID
    ; 

    /*---------------------------------_ 
     |           Expression             |
     *----------------------------------*/ 

Expression:                 { init(); } 
        Assign              { $$ = head() + tail() + "val: " + $2; clear(); }
    ;

Assign: Var '=' Assign      { $$ = $1; head($1 + "=" + $3); }
    | Var EQOP Assign       { $$ = $1; head($1 + $2 + $3); } 
    | Var PWREQ Assign      { $$ = $1; head($1 + "=power(" + $1 + "," + $3 + ")"); }
    | Boolean               { $$ = $1; }
    ;
 
Boolean: Bits OR Boolean    { $$ = tmp(); head($$ + "=" + $1 + "||" + $3); }
    | Bits AND Boolean      { $$ = tmp(); head($$ + "=" + $1 + "&&" + $3); }
    | Bits                  { $$ = $1; } 
    ;

Bits: Compare '|' Bits      { $$ = tmp(); head($$ + "=" + $1 + "|" + $3); }
    | Compare '&' Bits      { $$ = tmp(); head($$ + "=" + $1 + "&" + $3); }
    | Compare '^' Bits      { $$ = tmp(); head($$ + "=" + $1 + "^" + $3); }
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

Value: Math SHL Value       { $$ = tmp(); head($$ + "=" + $1 + "<<" + $3); }
    | Math SHR Value        { $$ = tmp(); head($$ + "=" + $1 + ">>" + $3); }
    | Math                  { $$ = $1; }
    ;

Math: Factor '+' Math       { $$ = tmp(); head($$ + "=" + $1 + "+" + $3); }
    | Factor '-' Math       { $$ = tmp(); head($$ + "=" + $1 + "-" + $3); }
    | Factor                { $$ = $1; }
    ; 

Factor: Unary '*' Factor    { $$ = tmp(); head($$ + "=" + $1 + "*" + $3); }
    | Unary '/' Factor      { $$ = tmp(); head($$ + "=" + $1 + "/" + $3); }
    | Unary '%' Factor      { $$ = tmp(); head($$ + "=" + $1 + "%" + $3); }
    | Unary PWR Factor      { $$ = tmp(); head($$ + "=power(" + $1 + "," + $3 + ")"); }
    | Unary                 { $$ = $1; }
    ;

Unary: '!' Unary            { $$ = tmp(); head($$ + "=!" + $2); }
    | '~' Unary             { $$ = tmp(); head($$ + "=~" + $2); }
    | '-' Unary             { $$ = tmp(); head($$ + "=-" + $2); }
    | '+' Unary             { $$ = $2; }
    | Term                  { $$ = $1; }
    ;

Term: '(' Assign ')'        { $$ = $2; } 
    | Var INC               { $$ = $1; tail($1 + "=" + $1 + "+1"); }
    | Var DEC               { $$ = $1; tail($1 + "=" + $1 + "-1"); }
    | INC Var               { $$ = $2; head($2 + "=" + $2 + "+1"); }
    | DEC Var               { $$ = $2; head($2 + "=" + $2 + "-1"); }
    | FunctionCall          { $$ = $1; } 
    | Var                   { $$ = $1; }
    | Data                  { $$ = $1; }
    ; 
    
    /*---------------------------------_ 
     |           Primitives             |
     *----------------------------------*/ 

Data: Number                { $$ = $1; }
    | Array                 { $$ = $1; }
    | String                { $$ = $1; }
    ;
    
Number: INT                 { $$ = $1; }
    | FLOAT                 { $$ = $1; }
    ;

String: STRING              { $$ = $1; }
    ;

Var: ID                     { $$ = var($1); }
    ;

%% 

int main(int argc, char** argv)
{ 
    return MainFunction(argc, argv);
}
