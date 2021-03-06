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
IDF             [_$A-Za-z]([_$A-Za-z0-9])*
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
<INITIAL>{SPACE}		        /* skip whitespace */

    /*********** Comments **********/
<INITIAL>"/*"       { /*"*/ BEGIN(comment); token = yytext; }
<comment>{
[^*\n]*             { token += yytext; }
"*"+[^*/\n]*        { token += yytext; }
"*/"                { BEGIN(INITIAL); token += yytext; /*__RETURN(COMMENT); */ }
}
<INITIAL>"//"[^\n]* { token += yytext; /*__RETURN(COMMENT); */}

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
<INITIAL>{
"..."               { __RETURN_VAL(THREEDOT); }

"**="               { __RETURN_VAL(PWREQ); } 
">>="               { __RETURN_VAL(EQOP); }
"<<="               { __RETURN_VAL(EQOP); }
[-+*/%|&^~]=        { __RETURN_VAL(EQOP); }

"=="                { __RETURN_VAL(EQ); }
"!="                { __RETURN_VAL(NE); }
"<>"                { token="!="; __RETURN(NE); }
"<="                { __RETURN_VAL(LEQ); }
">="                { __RETURN_VAL(GEQ); }
"||"                { __RETURN_VAL(OR); }
"&&"                { __RETURN_VAL(AND); }

"**"                { __RETURN_VAL(PWR); }
">>"                { __RETURN_VAL(SHR); }
"<<"                { __RETURN_VAL(SHL); }
"++"                { __RETURN_VAL(INC); }
"--"                { __RETURN_VAL(DEC); }

[-+*/%<>=!&^~]      { __RETURN_VAL(yytext[0]); }
[.,;:?(){|}\[\]\\]  { __RETURN_VAL(yytext[0]); } 

"and"               { token="&&"; __RETURN(AND); }
"or"                { token="||";__RETURN(OR); }
"not"               { __RETURN_VAL('!'); }
"xor"               { __RETURN_VAL('^'); }

}

    /*********** Numbers **********/    
<INITIAL>{
{BIN}               { token = toNumber(yytext + 2, 2); __RETURN(INT); }
{OCTA}              { token = toNumber(yytext + 2, 8); __RETURN(INT); }      
{HEXA}              { token = toNumber(yytext + 2, 16); __RETURN(INT); }   
{EFLOAT}            { token = toNumber(yytext, 0); __RETURN(FLOAT); }       
{FLOAT}             { token = toNumber(yytext, 0); __RETURN(FLOAT); }      
{INT}               { token = toNumber(yytext, 10); __RETURN(INT);  } 
{INVALID_NUMBER}    { __ERROR("Invalid number"); }
}

    /*********** Keywords **********/
<INITIAL>{
"continue"          { __RETURN_VAL(CONTINUE); }
"return"            { __RETURN_VAL(RETURN); }
"break"             { __RETURN_VAL(BREAK); }
"case"              { __RETURN_VAL(CASE); } 
"else"              { __RETURN_VAL(ELSE); } 
"false"             { token = "0"; __RETURN(INT); }
"true"              { token = "1"; __RETURN(INT); }
"def"               { __RETURN_VAL(DEF); }
"for"               { __RETURN_VAL(FOR); }
"if"                { __RETURN_VAL(IF); }
}

    /*********** Identifier **********/
<INITIAL>{IDF}      { __RETURN_VAL(ID); }

    /*********** Newlines **********/
<*>\n               { __NEWLINE; }

    /*********** Others **********/
.                   { __ERROR("Unrecognized Character"); }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
