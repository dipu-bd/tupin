%{
    #include <bits/stdc++.h>
%}

%option noyywrap main

DIGIT   [0-9]
INT     [-]?{DIGIT}+
FLOAT   {INT}+"."{DIGIT}*
EFLOAT  {INT}+("."{DIGIT}*)?[eE]{INT}
HEXA    [-]?0[hH][0-9A-Fa-f]+
OCTA    [-]?0[oO][0-7]+
BIN     [-]?0[bB][01]+

ID      [_$A-Za-z][_$0-9A-Za-z]*

%%

{BIN}       { printf("BINARY: %s\n", yytext); }
{OCTA}      { printf("OCTAL: %s\n", yytext); }    
{HEXA}      { printf("HEXA: %s\n", yytext); }    
{EFLOAT}    { printf("EFLOAT: %s\n", yytext); }       
{FLOAT}     { printf("EFLOAT: %s\n", yytext); }       
{INT}       { printf("INTEGER: %s\n", yytext); } 

{ID}        { printf("ID: %s\n", yytext); }

.           /* ignore */
\n          ECHO;

%%
