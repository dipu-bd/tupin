%{
    #include "Lexer.h"        
%}

%option noyywrap main yylineno

%x STRING COMMENT

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
[ \t]       ++colno; /* skip whitespace */
    /* Comments */

    /* Numbers */    
{BIN}       { number(yytext + 2, 2);    colno += yyleng; }
{OCTA}      { number(yytext + 2, 8);    colno += yyleng; }      
{HEXA}      { number(yytext + 2, 16);   colno += yyleng; }   
{EFLOAT}    { number(yytext, 0);        colno += yyleng; }       
{FLOAT}     { number(yytext, 0);        colno += yyleng; }      
{INT}       { number(yytext, 10);       colno += yyleng; } 

    /* Identifier */
{ID}        { identifier(yytext);       colno += yyleng; }

.           { yyerror("Unrecognized Character");  colno += yyleng; }
\n          { colno = 0; printf("\n%3d. ", yylineno); }

%% 
 







