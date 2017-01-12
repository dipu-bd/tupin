
struct Environment
{
    int argc;
    char **argv;

    Environment(int c = 0, char **v = 0) : argc(c), argv(v)
    {
    }
    int count()
    {
        return argc;
    }
    char *cur()
    {
        return argv[0];
    }
    FILE *input()
    {
        if (argc >= 1)
        {
            return fopen(argv[1], "r");
        }
        return 0;
    }
    FILE *output()
    {
        if (argc >= 1)
        {
            return fopen(argv[2], "w");
        }
        return 0;
    }
};