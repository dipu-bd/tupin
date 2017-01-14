%{
    #include <bits/stdc++.h>
    #include "lib/compiler/Parser.hpp"
%}

%define api.pure
%locations

%token BOOL INT FLOAT
%token FOR CONTINUE BREAK
%token IF ELIF ELSE
%token ID 
%token DEF
%token DOT
%token STRING


    /* EQ NE LE GE OR AND SHL SHR INC DEC PE ME CE DE MDE PWR SHLE SHRE PWRE RAND OE XE AE */
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%%

program: program '\n' { printf("ONE LINER\n"); }
    |   /* empty statement */
    ;

%% 

int main(int argc, char *argv[])
{
    env = Environment(argc, argv);
	yyin = env.openInput();
    yyout = env.openOutput();
	
    int res = yyparse();
	
	fclose(yyin);
    fclose(yyout);

    env.showTime();

    return 0;
}
          

/*
https://github.com/rabishah/Mini-C-Compiler-using-Flex-And-Yacc/blob/master/c.y
*/