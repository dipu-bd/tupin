%{ 
    #include "commons.hpp"     
    #include "ParserHelper.hpp"    
%}

%verbose 
 
%token DEF IF ELIF ELSE FOR RETURN CONTINUE BREAK TO BY
%token STRING INT FLOAT ID COMMENT
%token OP PWR OPEQ PWREQ THREEDOT

%right '=' 
%right OPEQ PWREQ
%left '<' '>'  
%left OP '&' '^' '|'
%left '+' '-' '*' '/' '%'
%left PWR

%%
    /*---------------------------------_ 
     |            Start Point           |
     *----------------------------------*/    
Program: Combined     { saveProgram($1); }
    ;
    
Combined: Combined Block    { $$ = $1 + "\n" + $2 + "\n"; }  
    | Combined Function     { $$ = $1 + "\n" + $2 + "\n"; }  
    | Combined CmpndStmnt   { $$ = $1 + "\n{\n" + tab($2) + "\n}\n"; /*"*/}
    | /* empty program */   { $$ = ""; }
    ;

    /*---------------------------------_ 
     |       Functoin Definition        |
     *----------------------------------*/    
Function: DEF ID '(' Arguments ')' Block  { $$ = defFunction($2, $4, $6); }
    ; 

Arguments: ArgVarList { $$ = $1; } 
    | { $$ = ""; } /* can be empty */     
    ;

ArgVarList: ArgVarList ',' ID { $$ = $1 + "\n" + $3; }
    | ID  { $$ = $1; }
    ; 
    
    /*---------------------------------_ 
     |        Block's Definition        |
     *----------------------------------*/     

Block: '{' CmpndStmnt '}'  { $$ = "{\n" + tab($2) + "\n}"; } /*"*/ 
    | '{' '}'              { $$ = "" } /* empty block */ 
    ;

CmpndStmnt: CmpndStmnt SingleStmnt    { $$ = $1 + "\n" + $2; }
    | CmpndStmnt Block          { $$ = $1 + "\n" + $2; }
    | Block               { $$ = $1; }
    | SingleStmnt               { $$ = $1; }
    ;

SingleStmnt: Statement ';'  { $$ = $1 + ";" }
    | Loop                  { $$ = $1; }
    | Condition             { $$ = $1; } 
    ;

Statement: Declaration      { $$ = $1; }
    | PrintStmnt            { $$ = $1; }
    | Expression            { $$ = $1; }     
    | RETURN Expression     { $$ = $1 + $2; }
    | CONTINUE              { $$ = $1; }
    | BREAK                 { $$ = $1; } 
    |    /* NULL */         { $$ = ""; }
    ;

    /*---------------------------------_ 
     |         Print Statement          |
     *----------------------------------*/    
PrintStmnt: '[' PrintSequence ']'   { $$ = "cout << " + $2; }
    ;

PrintSequence: PrintSequence STRING      { $$ = $1 + " << " + $2; }
    | PrintSequence Expression  { $$ = $1 + " << (" + $2 + ")"; }
    | STRING                    { $$ = $1; }
    | Expression                { $$ = $1; }
    |  /* can be empty */       { $$ = ""; }  
    ;

    /*---------------------------------_ 
     |            Conditions            |
     *----------------------------------*/         
Condition: IF ConditionStmnt { $$ = "if " + $2; }
    | IF '[' ID ']' '{' Switch '}'  {$$ = "switch (" + $3 + ") {\n" + tab($6) + "\n}" /*"*/ } 
    ;

ConditionStmnt: 
        '(' Expression ')' SingleStmnt Branch   
                { $$ = "(" + $2 + ")\n" + tab($4) + ";\n" + $5; }  
        | '(' Expression ')' Block Branch   
                { $$ = "(" + $2 + ") {\n" + $4 + "\n" + $5; } 
    ;

Branch: ELIF ConditionStmnt { $$ = "else if " + $2; }
    | ELSE CmpndStmnt { $$ = "else \n" + tab($2); }
    | /* can be empty */ {$$ = "";}
    ;

Switch: Choice          { $$ = $1; } 
    | Switch Choice     { $$ = $1 + "\n" + $2; }
    ;

Choice: Choice ','          { $$ = $1 + "\n" + tab("break;"); }
    | Literal ':' Block     { $$ = "case " + $1 + ":\n" + tab($3,2); }
    ;

    /*---------------------------------_ 
     |              Looping             |
     *----------------------------------*/    
Loop: FOR '(' Expression ')' Block
            { $$ = "while (" + $3 + ")\n" + $5; }
    | FOR '(' Declaration ';' Expression ';' Expression ')' Block 
            { $$ = "for (" + $3 + "; " + $5 + "; " + $7 + ")\n" + $9; }
    | FOR LoopIterator Block
            { $$ = "for (auto __i : " + $2 + ")\n" + $3; }
    | FOR ID ':' LoopIterator Block 
            { $$ = "for (auto " + $2 + " : " + $4 + ")\n" +$5; }
    ;

LoopIterator: Literal TO Literal        { $$ = "range(" + $1 + ", " + $3 +")"; }
    | Literal TO Literal BY Literal     { $$ = "range(" + $1 + ", " + $3 + ", " + $5 +")"; }
    | Expression                        { $$ = "(" + $1 + ")"; }
    ;

    /*---------------------------------_ 
     |       Variable  and Array        |
     *----------------------------------*/    

Declaration: ID '=' Expression      { $$ = "auto " + $1 + " = " + $3; }
    | ID '=' ArrayDef               { $$ = "auto " + $1 + " = " + $3; }
    ; 

ArrayDef: '{' ParamList '}'         { $$ = "Array(" + $2 + ")"; }
    ;
    
ArrayUsage: ID '[' CommaIndex ']'             { $$ = $1 + $3; }
    ;

CommaIndex: Expression              { $$ = "[" + $1 + "]"; }
    | CommaIndex ',' Expression     { $$ = $1 + "[" + $3 + "]"; }
    ;

    /*---------------------------------_ 
     |           Expressions            |
     *----------------------------------*/ 

Expression: Expression OP Unary { $$ = $1 + $2 + $3; }    
    | Expression PWR Unary { $$ = "power(" + $1 + ", " + $3 + ")"; }  
    | ID OPEQ Expression  { $$ = $1 + $2 + $3; }
    | ID PWREQ Expression   { $$ = $1 + "=power(" + $1 + "," + $3 + ")"; }
    | ID '=' Expression { $$ = $1 + $2 + $3; }
    | Unary      { $$ = $1; }
    ; 

Unary: '~' Unary { $$ = "~" + $1; }
    | '-' Unary { $$ = "-" + $1; }
    | '!' Unary { $$ = "!" + $1; }
    | Factor { $$ = $1; }
    ;

Factor: '(' Expression ')'  { $$ = "(" + $2 + ")" ; } 
    | Literal               { $$ = $1; }
    | ArrayUsage            { $$ = $1; }
    | FunctionCall          { $$ = $1; }
    | ID                    { $$ = $1; }
    ;
 
Literal: Number { $$ = $1; }
    | STRING    { $$ = $1; }
    ;

Number: INT { $$ = $1; }
    | FLOAT { $$ = $1; }
    ;

    /*---------------------------------_ 
     |         Function Call            |
     *----------------------------------*/    
FunctionCall: ID '(' ParamList ')'      { $$ = $1 + "(" +  $3 + ")"; }
    ;

ParamList: Params               { $$ = $1; }
    |    /* can be empty */     { $$ = ""; }
    ;

Params: Expression              { $$ = $1; }
    | Params ',' Expression     { $$ = $1 + ", " + $3; }
    ;

%% 

int main(int argc, char** argv)
{ 
    return MainFunction(argc, argv);
}

/*
https://github.com/rabishah/Mini-C-Compiler-using-Flex-And-Yacc/blob/master/c.y
*/