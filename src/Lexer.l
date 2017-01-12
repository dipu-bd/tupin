%{
    #include "lib/Lexer.h"
    #define YY_USER_ACTION colno += (int)yyleng;
%}
 
%option noyywrap
%option yylineno
%option warn
%option main 

%x string comment

DIGIT           [0-9]
INT             [-]?{DIGIT}+
FLOAT           {INT}"."{DIGIT}*  
EFLOAT          ({FLOAT}|{INT})[eE][+-]?{DIGIT}+
HEXA            [-]?0[xX][0-9A-Fa-f]+
OCTA            [-]?0[oO][0-7]+
BIN             [-]?0[bB][01]+
INVALID_NUMBER  ({BIN}|{OCTA}|{HEXA}|{EFLOAT}|{FLOAT}|{INT})[[:alnum:]]+

IDENTIFIER      [_$A-Za-z][_$0-9A-Za-z]*

%%
    /* Row and column tracker */
    colno = 0; 
    printf("%3d. ", yylineno);
    
    /* Whitespaces */
[ \t]+		            /* skip whitespace */

    /* Comments */
"//"[^\n]*              /* single line comment */
<INITIAL>"/*"           { BEGIN(comment); }
<comment>[^*\n]*        /* eat anything that's not a '*'' */
<comment>"*"+[^*/\n]*   /* eat up '*'s not followed by '/'s  */ 
<comment>"*/"           { BEGIN(INITIAL); }

    /* Strings */
    

    /* Numbers */    
{BIN}               { number(yytext + 2, 2); }
{OCTA}              { number(yytext + 2, 8); }      
{HEXA}              { number(yytext + 2, 16); }   
{EFLOAT}            { number(yytext, 0); }       
{FLOAT}             { number(yytext, 0); }      
{INT}               { number(yytext, 10); } 
{INVALID_NUMBER}    { yyerror("Invalid number"); }

    /* Identifier */
{IDENTIFIER}        { identifier(yytext); }

.                   { yyerror("Unrecognized Character"); }
<*>\n               { colno = 0; printf("\n%3d. ", yylineno); }

%% 
 







