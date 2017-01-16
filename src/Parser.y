%{ 
    #include "commons.hpp"     
    #include "ParserHelper.hpp"    
%}

%verbose  
 
%token DEF IF ELIF ELSE FOR RETURN CONTINUE BREAK TO BY
%token STRING INT FLOAT ID COMMENT
%token OP PWR OPEQ PWREQ THREEDOT
 
%right "=" OPEQ PWREQ '~' '!' 
%left OP '<' '>' '&' '^' '|' '+' '-' '*' '/'  '%' PWR

%%
    /*---------------------------------_ 
     |            Start Point           |
     *----------------------------------*/    
Program: Whole     { saveProgram($1); }
    ;
    
Whole: Whole Function  { $$ = $1 + "\n" + $2 + "\n"; }  
    | Whole Blocks     { $$ = $1 + "\n{\n" + tab($2) + "\n}\n"; /*"*/}
    | /* empty program */   { $$ = ""; }
    ;

    /*---------------------------------_ 
     |        Block's Definition        |
     *----------------------------------*/     

Blocks: Blocks SingleBlock { $$ = $1 + "\n" + $2; }
    | { $$ = ""; }
    ;

SingleBlock: Loop       { $$ = $1; }
    | Condition         { $$ = $1; }
    | Single ';'        { $$ = $1 + ";" }
    | '{' Blocks '}'    { $$ = "{\n" + tab($2) + "\n}"; /*"*/ }
    ;

Single: Print           { $$ = $1; }
    | Expression        { $$ = $1; }
    | Declaration       { $$ = $1; }
    | BREAK             { $$ = "break"; }
    | CONTINUE          { $$ = "continue"; }
    | RETURN Expression { $$ = "return " + $2; }
    | { $$ = ""; }
    ;

    /*---------------------------------_ 
     |         Print Statement          |
     *----------------------------------*/    
Print: '[' PrintSequence ']'   { $$ = "cout << " + $2; }
    | '[' ']'        {$$ = "cout << \"\\n\""; }
    ;

PrintSequence: PrintSequence PrintVar { $$ = $1 + " << " + $2; }
    | PrintVar { $$ = $1; }
    ;

PrintVar: STRING  { $$ = $1; }
    | Expression  { $$ = "(" + $1 + ")"; }
    ;

    /*---------------------------------_ 
     |       Variable  and Array        |
     *----------------------------------*/    

Declaration: ID '=' Expression      { $$ = "auto " + $1 + " = " + $3; }
    | Declaration ',' Declaration   { $$ = $1 + ";\n" + $2; }
    ; 
    
ArrayUsage: ID '[' CommaIndex ']'             { $$ = $1 + $3; }
    ;

CommaIndex: Expression              { $$ = "[" + $1 + "]"; }
    | CommaIndex ',' Expression     { $$ = $1 + "[" + $3 + "]"; }
    ;

    /*---------------------------------_ 
     |            Conditions            |
     *----------------------------------*/         
Condition: IF '(' Expression ')' SingleBlock ElseBlock 
         { $$ = "if (" + $3 + ") " + $5 + $6; }
    | IF '[' ID ']' '{' CaseBlock '}' 
         {$$ = "switch (" + $3 + ") {\n" + tab($6) + "\n}"; /*"*/ } 
    ;

ElseBlock: ELSE SingleBlock { $$ = "\nelse " + $2; }
    | /* can be empty */ {$$ = "";}
    ;

CaseBlock: Case CaseBlock { $$ = $1 + "\n" + $2; }  
    | Case  { $$ = $1; }  
    ;

Case: Literal ':' Blocks     { $$ = "case " + $1 + ":\n" + tab($3,2); }
    ;

    /*---------------------------------_ 
     |              Looping             |
     *----------------------------------*/    
Loop: FOR '(' Expression ')' SingleBlock
        { $$ = "while (" + $3 + ") " + $5; }
    | FOR '(' Single ';' Expression ';' Single ')' SingleBlock
        { $$ = "for (" + $3 + "; " + $5 + "; " + $7 + ") " + $9; }    
    | FOR LoopIterator SingleBlock 
        { $$ = "for (auto $__index$ : " + $2 + ") " + $3; }
    | FOR ID ':' LoopIterator SingleBlock 
            { $$ = "for (auto " + $2 + " : " + $4 + ") " + $5; }
    ;

LoopIterator: Number TO Number       { $$ = "range(" + $1 + ", " + $3 +")"; }
    | Number TO Number BY Number     { $$ = "range(" + $1 + ", " + $3 + ", " + $5 +")"; }
    | Expression                     { $$ = "(" + $1 + ")"; }
    ;


    /*---------------------------------_ 
     |           Expressions            |
     *----------------------------------*/ 

Expression: Expression OP Unary { $$ = $1 + $2 + $3; }    
    | Expression PWR Unary { $$ = "power(" + $1 + ", " + $3 + ")"; }  
    | ID OPEQ Expression  { $$ = $1 + $2 + $3; }
    | ID PWREQ Expression   { $$ = $1 + "=power(" + $1 + "," + $3 + ")"; }
    | ID '=' Expression { $$ = $1 + "=" + $3; }
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
     |       Functoin Definition        |
     *----------------------------------*/    
Function: DEF ID '(' Arguments ')' '{' Blocks '}' 
         { $$ = defFunction($2, $4, $7); }
    ; 

Arguments: ArgList { $$ = $1; } 
    | { $$ = ""; } /* can be empty */     
    ;

ArgList: ArgList ',' ID { $$ = $1 + "\n" + $3; }
    | ID  { $$ = $1; }
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