%{    
    #include <bits/stdc++.h>
    #include "Parser.h"
    #include "lib/compiler/Lexer.h"
    #include "lib/compiler/StringBuilder.h"

    offset_t offset;
    extern YYLTYPE yylloc;

    #define YY_USER_ACTION \
        offset += yyleng; \
        yylloc.last_line = yylineno; \
        yylloc.last_column = offset;
%}

%option warn
%option noyywrap
%option yylineno
%option bison-locations 

%x comment
%x sqstr
%x dqstr

    /* Whitespace */
SPACE           [ \t\r\v\f]
    /* Numbers and Digits */
DIGIT           [0-9]
LETTER          [_$A-Za-z]
XDIGIT          [A-Fa-f0-9]
    /* Valid operators */
OPERATOR        [!%&()*+,\-./:;<=>?^{|}~\[\]\\]
    /* Escape sequence */
ESC1            [^xX0-7]
ESC2            [0-7]{1,3}
ESC3            [xX]{XDIGIT}{1,2}
ESCAPE          \\({ESC1}|{ESC2}|{ESC3})
BADESC          \\({DIGIT}+|[xX])
    /* Number system */
INT             {DIGIT}+
FLOAT           {INT}"."{DIGIT}*  
EFLOAT          ({FLOAT}|{INT})[eE][+-]?{DIGIT}+
HEXA            0[xX]{XDIGIT}+
OCTA            0[oO][0-7]+
BIN             0[bB][01]+
INVALID_NUMBER  ({BIN}|{OCTA}|{HEXA}|{EFLOAT}|{FLOAT}|{INT})[[:alnum:]]+
    /* Identifier */
IDENTIFIER      {LETTER}({LETTER}|{DIGIT})*
    /* Valid keywords */
KEYWORDS        "def"|"return"|"if"|"elif"|"else"|"for"|"continue"|"break"|"and"|"or"|"not"|"xor"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    /*********** Declarations **********/ 
    offset = 0;
    StringBuilder __builder;
    //printf("%3d. ", yylineno);
    
    /*********** Comments **********/
"//"[^\n]*          /* eat up single line comment */
<INITIAL>"/*"       { BEGIN(comment); }
<comment>{
    [^*\n]*         /* eat anything that's not a '*' */
    "*"+[^*/\n]*    /* eat up '*'s not followed by '/'s  */ 
    "*/"            { BEGIN(INITIAL); }
}

    /*********** Strings **********/ 
<INITIAL>"\'"       { BEGIN(sqstr); __builder.init(); }
<INITIAL>"\""       { BEGIN(dqstr); __builder.init(); }
<sqstr,dqstr>{
    {ESCAPE}        { if(!__builder.escaped(yytext)) 
                        yyerror("Bad escape sequence"); }
    {BADESC}        { yyerror("Unrecognized escape sequence"); 
                      __builder.append(yytext + 1, yyleng - 1); }    
}
<sqstr>{
    [^\\']*         { __builder.append(yytext, yyleng); }    
    "'"             { BEGIN(INITIAL); 
                      __builder.append(yytext, yyleng - 1); 
                      checkString(__builder.str);  }
}
<dqstr>{
    [^\\"]*         { __builder.append(yytext, yyleng); }    
    "\""            { BEGIN(INITIAL); 
                      __builder.append(yytext, yyleng - 1); 
                      checkString(__builder.str); }
}

    /*********** Whitespaces **********/
{SPACE}		        /* skip whitespace */

    /*********** Operators **********/
"=="                { RETURN(EQ); }
"!="|"<>"           { RETURN(NE); }
"<="                { RETURN(LE); }
">="                { RETURN(GE); }
"||"                { RETURN(OR); }
"&&"                { RETURN(AND); }
">>"                { RETURN(SHL); }
"<<"                { RETURN(SHR); }
"++"                { RETURN(INC); }
"--"                { RETURN(DEC); }
"+="                { RETURN(PE); }
"-="                { RETURN(ME); }
"*="                { RETURN(CE); }
"/="                { RETURN(DE); }
"%="                { RETURN(MDE); 
"**"                { RETURN(PWR); }}
">>="               { RETURN(SHLE); }
"<<="               { RETURN(SHRE); } 
"**="               { RETURN(PWRE); }
"#"                 { RETURN(RAND); }
"|="                { RETURN(OE); }
"^="                { RETURN(XE); }
"&="                { RETURN(AE); }
{OPERATOR}          { RETURN(yytext[0]); }

    /*********** Numbers **********/    
{BIN}               { checkNumber(yytext + 2, 2); }
{OCTA}              { checkNumber(yytext + 2, 8); }      
{HEXA}              { checkNumber(yytext + 2, 16); }   
{EFLOAT}            { checkNumber(yytext, 0); }       
{FLOAT}             { checkNumber(yytext, 0); }      
{INT}               { checkNumber(yytext, 10); } 
{INVALID_NUMBER}    { yyerror("Invalid number"); }

    /*********** Keywords **********/
"true"|"false"      { checkBool(yytext); }
{KEYWORDS}          { checkKeyword(yytext); }

    /*********** Identifier **********/
{IDENTIFIER}        { checkIdentifier(yytext); }

.                   { yyerror("Unrecognized Character"); }
<*>\n               { offset = 0; } //printf("\n%3d. ", yylineno); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







