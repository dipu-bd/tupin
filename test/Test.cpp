#include <bits/stdc++.h>
#include <execinfo.h>
#include "../lib/tupin.h"
#include "Data.hpp"

#define FAILE_SAFE_MODE false

typedef void (*FUNCTION)(void);
typedef pair<FUNCTION, const char*> PFS;

void runTests(bool failSafe, PFS all_tests[])
{
    int pass = 0, fail = 0;
    for (int i = 0; all_tests[i].first; i++)
    {
        FUNCTION f = all_tests[i].first;
        if (!failSafe)
        {
            f();
            ++pass;
            printf("%s -- passed.", all_tests[i].second);
        }
        else
        {
            try
            {
                f();
                ++pass;
                printf("%s -- passed.", all_tests[i].second);
            }
            catch (...)
            {
                ++fail;
                printf("%s -- failed.", all_tests[i].second);
            }
        }
        puts("");
    }

    printf("\n-- Test Over: %d passed. %d failed.\n", pass, fail);
}

int main(int argc, char **argv)
{
    PFS all_tests[] = {
        {&testNumber, "testNumber"},
        {&testBool, "testBool"},
        {&testString, "testString"},
        {0, "null"},
    };
    runTests(FAILE_SAFE_MODE, all_tests);

    return 0;
}