%{
    #include <bits/stdc++.h>
    #include "lib/compiler/Parser.hpp"    
    Environment env;    
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

%right '='
%left AND OR
%left '<' '>' LE GE EQ NE LT GT
%%

program: program '\n' { printf("ONE LINER\n"); }
    |   /* empty statement */
    ;

%% 

void yyerror(const char *msg)
{
    fprintf(stderr, "%s:%d:%d: %s\n", 
        env.input(),
        yylloc.last_line,
        yylloc.last_column,
        msg);
}

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