%{
    #include "lib/Lexer.hpp"
    #define YY_USER_ACTION { loc.col += (int)yyleng; loc.line = yylineno; }
%}
 
%option noyywrap
%option yylineno
%option warn 

%x comment
%x string
%x regex

DIGIT           [0-9]
INT             [-]?{DIGIT}+
FLOAT           {INT}"."{DIGIT}*  
EFLOAT          ({FLOAT}|{INT})[eE][+-]?{DIGIT}+
HEXA            [-]?0[xX][0-9A-Fa-f]+
OCTA            [-]?0[oO][0-7]+
BIN             [-]?0[bB][01]+
INVALID_NUMBER  ({BIN}|{OCTA}|{HEXA}|{EFLOAT}|{FLOAT}|{INT})[[:alnum:]]+

ESC1            [^xX0-7]
ESC2            [0-7]{1,3}
ESC3            [xX][0-9A-Fa-f]{1,2}
ESC             \\({ESC1}|{ESC2}|{ESC3})
BADESC          \\([0-9]+|[xX])

IDENTIFIER      [_$A-Za-z][_$0-9A-Za-z]*

%%
    /*********** Declarations **********/ 
    StringBuilder __builder;
    printf("%3d. ", yylineno);
    
    /*********** Whitespaces **********/
[ \t\r]+		    /* skip whitespace */

    /*********** Comments **********/
"//"[^\n]*          /* single line comment */
<INITIAL>"/*"       { BEGIN(comment); }
<comment>{
    [^*\n]*         /* eat anything that's not a '*' */
    "*"+[^*/\n]*    /* eat up '*'s not followed by '/'s  */ 
    "*/"            { BEGIN(INITIAL); }
}

    /*********** Strings **********/ 
<INITIAL>\"         { BEGIN(string); __builder.init(); }
<string>{ 
    {ESC}           { if(!__builder.escaped(yytext)) 
                            yyerror("Bad escape sequence"); 
                    }
    {BADESC}        { yyerror("Unrecognized escape sequence"); }
    [^\\\"]*        { __builder.append(yytext, yyleng); }
    "\""            { BEGIN(INITIAL); 
                      __builder.append(yytext, yyleng - 1); 
                      checkString(__builder.str); 
                    }
}

    /*********** Regex **********/


    /*********** Numbers **********/    
{BIN}               { checkNumber(yytext + 2, 2); }
{OCTA}              { checkNumber(yytext + 2, 8); }      
{HEXA}              { checkNumber(yytext + 2, 16); }   
{EFLOAT}            { checkNumber(yytext, 0); }       
{FLOAT}             { checkNumber(yytext, 0); }      
{INT}               { checkNumber(yytext, 10); } 
{INVALID_NUMBER}    { yyerror("Invalid number"); }

    /*********** Identifier **********/
{IDENTIFIER}        { checkIdentifier(yytext); }

.                   { yyerror("Unrecognized Character"); }
<*>\n               { loc.col = 0; printf("\n%3d. ", yylineno); }

%% 

int main(int argc, char** argv) 
{ 
    /* Open input and output files for testing */
    env = Environment(argc, argv);  
    FILE* fin = env.input();
    FILE* fout = env.output();
    if(fin) yyin = fin;
    if(fout) yyout = fout;
    
    /* start lexer */
    yylex();

    return 0;
} 







