%{       
    #include "commons.hpp"
    #include "Parser.hpp"
    #include "LexerHelper.hpp"
%}

%option warn
%option noyywrap
%option yylineno

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

    /*********** Initialization **********/       
    __INITIALIZE;
    
    /*********** Whitespaces **********/
{SPACE}		        /* skip whitespace */

    /*********** Comments **********/
<INITIAL>"/*"       { BEGIN(comment); }
<comment>{
    [^*\n]*         /* eat anything that's not a '*' */
    "*"+[^*/\n]*    /* eat up '*'s not followed by '/'s  */ 
    "*/"            { BEGIN(INITIAL); }
}
"//"[^\n]*          /* eat up single line comment */

    /*********** Strings **********/ 
<INITIAL>"\'"       { BEGIN(sqstr); token.val = "\""; }
<INITIAL>"\""       { BEGIN(dqstr); token.val = yytext; }
<sqstr,dqstr>{
    {ESCAPE}        { token.val += yytext; }
    {BADESC}        { token.val += (yytext + 1);
                      __ERROR("Unrecognized escape sequence"); }    
}
<sqstr>[^\\']*\'    { token.val += yytext; }
<sqstr>\'           { BEGIN(INITIAL); token.val += "\"";  __RETURN(STRING);  }
<dqstr>[^\\"]*\"    { BEGIN(INITIAL); token.val += yytext; __RETURN(STRING); } 

    /*********** Operators **********/
"..."               { __RETURN_VAL(THREEDOT); }
"**="               { __RETURN_VAL(PWREQ); }
"&&"                { __RETURN_VAL(AND); }
"||"                { __RETURN_VAL(OR); }
"=="                { __RETURN_VAL(EQ); }
"!="                { __RETURN_VAL(NEQ); }
"<="                { __RETURN_VAL(LEQ); }
">="                { __RETURN_VAL(GEQ); }
"**"                { __RETURN_VAL(PWR); }
"<>"                { token.val="!="; __RETURN(NEQ); }
{OP_EQ}|{OP_DBL}    { __RETURN_VAL(OP); }
{OP_SNGL}           { __RETURN(yytext[0]); }


    /*********** Numbers **********/    
{BIN}               { token.val = toNumber(yytext + 2, 2); __RETURN(INT); }
{OCTA}              { token.val = toNumber(yytext + 2, 8); __RETURN(INT); }      
{HEXA}              { token.val = toNumber(yytext + 2, 16); __RETURN(INT); }   
{EFLOAT}            { token.val = toNumber(yytext, 0); __RETURN(FLOAT); }       
{FLOAT}             { token.val = toNumber(yytext, 0); __RETURN(FLOAT); }      
{INT}               { token.val = toNumber(yytext, 10); __RETURN(INT);  } 
{INVALID_NUMBER}    { __ERROR("Invalid number"); }

    /*********** Keywords **********/
"true"|"false"      { token.val = toNumber(yytext + 2, 2); __RETURN(INT); }
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
{IDENTIFIER}        { token.val = yytext; __RETURN(ID); }

.                   { __ERROR("Unrecognized Character"); }
<*>\n              { __NEWLINE; } 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
