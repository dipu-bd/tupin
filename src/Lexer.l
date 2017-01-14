%{     
    #include "lib/Util.h"
    #include "Parser.h"

    void yyerror(const char *msg);

    offset_t offset;
    extern YYLTYPE yylloc;

    #define YY_USER_ACTION \
        offset += yyleng; \
        yylloc->last_line = yylineno; \
        yylloc->last_column = offset;
%}

%option warn
%option noyywrap
%option yylineno
%option bison-locations 

%x comment
%x sqstr dqstr

    /* Whitespace */
SPACE           [ \t\r\v\f]
    /* Numbers and Digits */
DIGIT           [0-9] 
XDIGIT          [A-Fa-f0-9]
    /* Identifier */
IDENTIFIER      [_$A-Za-z]([_$A-Za-z0-9])*
    /* Number system */
INT             {DIGIT}+
FLOAT           {INT}"."{DIGIT}*  
EFLOAT          ({FLOAT}|{INT})[eE][+-]?{DIGIT}+
HEXA            0[xX]{XDIGIT}+
OCTA            0[oO][0-7]+
BIN             0[bB][01]+
INVALID_NUMBER  ({BIN}|{OCTA}|{HEXA}|{EFLOAT}|{FLOAT}|{INT})[A-Za-z]+
    /* Valid operators */
OP_EQ           (">>"|"<<"|[-+*/%<>!|^&])=
OP_DBL          "=="|"||"|"&&"|">>"|"<<"|"++"|"--"
OP_SNGL         [!%&()*+,\-./:;<=>?^{|}~\[\]\\]
    /* Escape sequence */
ESC1            [abtnvfre\"'?\\]
ESC2            [0-7]{1,3}
ESC3            [xX]{XDIGIT}+
ESC4            u{XDIGIT}{4}
ESC5            U{XDIGIT}{8}
ESCAPE          \\({ESC1}|{ESC2}|{ESC3}|{ESC4}|{ESC5})
BADESC          \\([^0-9]|{DIGIT}+)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    /*********** Declarations **********/ 
    offset = 0; 
    //printf("%3d. ", yylineno);
    
    /*********** Whitespaces **********/
{SPACE}		        /* skip whitespace */

    /*********** Comments **********/
"//"[^\n]*          /* eat up single line comment */
<INITIAL>"/*"       { BEGIN(comment); }
<comment>{
    [^*\n]*         /* eat anything that's not a '*' */
    "*"+[^*/\n]*    /* eat up '*'s not followed by '/'s  */ 
    "*/"            { BEGIN(INITIAL); }
}

    /*********** Strings **********/ 
<INITIAL>"\'"       { BEGIN(sqstr); yylval = yytext; }
<INITIAL>"\""       { BEGIN(dqstr); yylval = yytext; }
<sqstr,dqstr>{
    {ESCAPE}        { yylval += yytext; }
    {BADESC}        { yylval += (yytext + 1);
                      yyerror("Unrecognized escape sequence"); }    
}
<dqstr>[^\\"]*\"    { BEGIN(INITIAL); yylval += yytext; __RETURN_VAL(STRING); } 
<sqstr>[^\\']*\'    { yylval += yytext; yylval[0] = yylval[yyleng-1] = '"';  
                      BEGIN(INITIAL); __RETURN_VAL(STRING);  }

    /*********** Operators **********/
"**="               { __RETURN(PWREQ); }
{OP_EQ}|{OP_DBL}    { yylval = yytext; __RETURN_VAL(OP); }
"**"                { __RETURN(PWR); }
"<>"                { yylval = "!="; __RETURN_VAL(OP); }
{OP_SNGL}           { __RETURN(yytext[0]); }


    /*********** Numbers **********/    
{BIN}               { yylval = toNumber(yytext + 2, 2); __RETURN_VAL(INT); }
{OCTA}              { yylval = toNumber(yytext + 2, 8); __RETURN_VAL(INT); }      
{HEXA}              { yylval = toNumber(yytext + 2, 16); __RETURN_VAL(INT); }   
{EFLOAT}            { yylval = toNumber(yytext, 0); __RETURN_VAL(FLOAT); }       
{FLOAT}             { yylval = toNumber(yytext, 0); __RETURN_VAL(FLOAT); }      
{INT}               { yylval = toNumber(yytext, 10); __RETURN_VAL(INT);  } 
{INVALID_NUMBER}    { yyerror("Invalid number"); }

    /*********** Keywords **********/
"true"|"false"      { yylval = toNumber(yytext + 2, 2); __RETURN_VAL(INT); }
"def"               { __RETURN(DEF); }
"return"            { __RETURN(RETURN); }
"if"                { __RETURN(IF); }
"elif"              { __RETURN(ELIF); }
"else"              { __RETURN(ELSE); }
"for"               { __RETURN(FOR); }
"continue"          { __RETURN(CONTINUE); }
"break"             { __RETURN(BREAK); }
"and"               { __RETURN(AND); }
"or"                { __RETURN(OR); }
"not"               { __RETURN(NOT); }
"xor"               { __RETURN(XOR); }
"to"                { __RETURN(TO); }
"by"                { __RETURN(BY); } 

    /*********** Identifier **********/
{IDENTIFIER}        { yylval = yytext; __RETURN_VAL(ID); }

.                   { yyerror("Unrecognized Character"); }
<*>\n               { offset = 0; } //printf("\n%3d. ", yylineno); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 





