%{
    #include <bits/stdc++.h>
    #include "lib/Util.h"
%}

%define api.pure
%locations

%token OP PWR PWREQ
%token STRING INT FLOAT ID 
%token DEF RETURN IF ELIF ELSE FOR CONTINUE BREAK AND OR NOT XOR TO BY

%%

program: program '\n' { printf("ONE LINER\n"); }
    |   /* empty statement */
    ;

%% 
#include "lib/Lexer.h"

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