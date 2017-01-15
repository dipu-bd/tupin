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
<INITIAL>"/*"       { /*"*/ BEGIN(comment); token = yytext; }
<comment>{
    [^*\n]*         { token += yytext; }
    "*"+[^*/\n]*    { token += yytext; }
    "*/"            { BEGIN(INITIAL); token += yytext; __RETURN(COMMENT); }
}
"//"[^\n]*          { token = yytext; __RETURN(COMMENT); }

    /*********** Strings **********/ 
<INITIAL>"\'"       { BEGIN(sqstr); token = "\""; }
<INITIAL>"\""       { BEGIN(dqstr); token = yytext; }
<sqstr,dqstr>{
    {ESCAPE}        { token += yytext; }
    {BADESC}        { token += (yytext + 1);
                      __ERROR("Unrecognized escape sequence"); }    
}
<sqstr>[^\\']*      { token += yytext; }
<sqstr>\'           { BEGIN(INITIAL); token += "\"";  __RETURN(STRING);  }
<dqstr>[^\\"]*\"    { BEGIN(INITIAL); token += yytext; __RETURN(STRING); } 

    /*********** Operators **********/
"..."               { __RETURN_VAL(THREEDOT); }
"**="               { __RETURN_VAL(PWREQ); } 
{OP_EQ}             { __RETURN_VAL(OPEQ); }
{OP_DBL}            { __RETURN_VAL(OP); }
"**"                { __RETURN_VAL(PWR); }
"<>"                { token="!="; __RETURN(OP); }
{OP_SNGL}           { __RETURN_VAL(yytext[0]); }

"and"               { token="&&"; __RETURN(OP); }
"or"                { token="||";__RETURN(OP); }
"not"               { __RETURN_VAL('!'); }
"xor"               { __RETURN_VAL('^'); }


    /*********** Numbers **********/    
{BIN}               { token = toNumber(yytext + 2, 2); __RETURN(INT); }
{OCTA}              { token = toNumber(yytext + 2, 8); __RETURN(INT); }      
{HEXA}              { token = toNumber(yytext + 2, 16); __RETURN(INT); }   
{EFLOAT}            { token = toNumber(yytext, 0); __RETURN(FLOAT); }       
{FLOAT}             { token = toNumber(yytext, 0); __RETURN(FLOAT); }      
{INT}               { token = toNumber(yytext, 10); __RETURN(INT);  } 
{INVALID_NUMBER}    { __ERROR("Invalid number"); }

    /*********** Keywords **********/
"true"|"false"      { token = toNumber(yytext + 2, 2); __RETURN(INT); }
"def"               { __RETURN_VAL(DEF); }
"if"                { __RETURN_VAL(IF); }
"elif"              { __RETURN_VAL(ELIF); }
"else"              { __RETURN_VAL(ELSE); }
"for"               { __RETURN_VAL(FOR); }
"to"                { __RETURN_VAL(TO); }
"by"                { __RETURN_VAL(BY); } 

"return"            { __RETURN_VAL(RETURN); }
"continue"          { __RETURN_VAL(CONTINUE); }
"break"             { __RETURN_VAL(BREAK); }

    /*********** Identifier **********/
{IDENTIFIER}        { __RETURN_VAL(ID); }

.                   { __ERROR("Unrecognized Character"); }
<*>\n               { token += "\n"; __NEWLINE; } 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
