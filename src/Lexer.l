%{
    #include "lib/Lexer.h"
    #define YY_USER_ACTION colno += (int)yyleng;
%}
 
%option noyywrap
%option yylineno
%option warn
%option main 

%x string comment

DIGIT   [0-9]
INT     [-]?{DIGIT}+
FLOAT   {INT}"."{DIGIT}*  
EFLOAT  ({FLOAT}|{INT})[eE][+-]?{DIGIT}+
HEXA    [-]?0[xX][0-9A-Fa-f]+
OCTA    [-]?0[oO][0-7]+
BIN     [-]?0[bB][01]+

ID      [_$A-Za-z][_$0-9A-Za-z]*

%%
    /* Row and column tracker */
    colno = 0; 
    printf("%3d. ", yylineno);
    
    /* Whitespaces */
[ \t]+		/* skip whitespace */

    /* Comments */

    /* Numbers */    
{BIN}/[^[:alpha:]]       { number(yytext + 2, 2); }
{OCTA}/[^[:alpha:]]      { number(yytext + 2, 8); }      
{HEXA}/[^[:alpha:]]      { number(yytext + 2, 16); }   
{EFLOAT}/[^[:alpha:]]    { number(yytext, 0); }       
{FLOAT}/[^[:alpha:]]     { number(yytext, 0); }      
{INT}/[^[:alpha:]]       { number(yytext, 10); } 

    /* Identifier */
{ID}        { identifier(yytext); }

.           { yyerror("Unrecognized Character"); }
\n          { colno = 0; printf("\n%3d. ", yylineno); }

%% 
 







