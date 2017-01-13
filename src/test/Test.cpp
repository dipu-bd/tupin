#include <bits/stdc++.h>
#include "../lib/data/Integer.hpp"

void testInteger()
{
    Integer it(2);
    printf("Integer: %s\n", it.toString().data());
}

void testData()
{
    testInteger();
}

int main(int argc, char **argv)
{
    testData();
    return 0;
}