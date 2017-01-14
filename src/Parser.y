%{
    #include <bits/stdc++.h>
    #include "lib/compiler/Parser.hpp"
    Location loc;
    Environment env;
%}

%token BOOL INT FLOAT
%token FOR CONTINUE BREAK
%token IF ELIF ELSE
%token ID 
%token DEF
%token DOT
%token STRING

%right '='
%left AND OR
%left '<' '>' LE GE EQ NE LT GT
%%

%%

int main(int argc, char *argv[])
{
    env = Environment(argc, argv);
	yyin = env.openInput();
    yyout = env.openOutput();
	
    int res = yyparse();
	
	fclose(yyin);
    fclose(yyout);

    return 0;
}
          

/*
https://github.com/rabishah/Mini-C-Compiler-using-Flex-And-Yacc/blob/master/c.y
*/