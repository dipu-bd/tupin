#include <bits/stdc++.h>

int colno;
    
void yyerror(const char *s) 
{
    fprintf(stderr, "# ERROR:%d:%d: %s %s\n", yylineno, colno, s, yytext);
}

void number(const char *s, int base = 10) 
{
    if(base >= 2) {
        long long n = std::strtoll(s, 0, base);
        printf("~ INTEGER: %lld [base=%d] \"%s\"\n", n, base, yytext);
    }
    else {
        double n = std::strtod(s, NULL);
        printf("~ FLOAT: %g \"%s\"\n", n, yytext);
    }
}

void identifier(const char *s) 
{
    printf("~ ID: %s\n", s);
}











