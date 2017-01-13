#include <bits/stdc++.h>
#include "Location.hpp"
#include "Environment.hpp"
#include "StringBuilder.hpp"

Location loc;
Environment env;

void yyerror(const char *s)
{
    fprintf(stderr, "# %s:%d:%d: %s %s\n", env.input(), loc.line, loc.col, s, yytext);
}

void checkNumber(const char *s, int base = 10)
{
    if (base >= 2)
    {
        long long n = std::strtoll(s, NULL, base);
        printf("~ INTEGER: %lld [base=%d] \"%s\"\n", n, base, yytext);
    }
    else
    {
        double n = std::strtod(s, NULL);
        printf("~ FLOAT: %g \"%s\"\n", n, yytext);
    }
}

void checkString(const char *s)
{
    printf("~ STRING: %s\n", s);
}

void checkIdentifier(const char *s)
{
    printf("~ ID: %s\n", s);
}

void checkOperator(const char *s)
{
    printf("~ OP: %s\n", s);
}

void checkKeyword(const char *s)
{
    printf("~ KEYWORD: %s\n", s);
}