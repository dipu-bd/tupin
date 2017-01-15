using namespace std;

extern FileSystem env;
extern FILE *yyin, *yyout;

/* Function definitions for parser*/
void init(int argc, char **argv)
{
    env = FileSystem(argc, argv);

    if (argc > 1 && argv[1])
    {
        freopen(argv[1], "r", stdin);
    }
    if (argc > 2 && argv[2])
    {
        freopen(argv[2], "w", stdout);
    }
}

int MainFunction(int argc, char **argv)
{
    auto begin = std::chrono::high_resolution_clock::now();
    init(argc, argv);

    int res = yyparse();

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin).count();
    fprintf(stderr, "\n\nExited with status %d\nRuntime: %f ms.\n", res, duration / 1e6);

    return res;
}

void yyerror(const char *msg, int line, int col, const char *file = "")
{
    fprintf(stderr, "~%4s:%d:%d: %s\n", file, line, col, msg);
}

void yyerror(const char *msg)
{
    yyerror(msg, -1, -1);
}

std::string tab(std::string val, int siz = 4)
{
    std::string spaces = "";
    for (int i = 0; i < siz; ++i)
    {
        spaces.push_back(' ');
    }

    std::string nval = spaces;
    for (char ch : val)
    {
        nval.push_back(ch);
        if (ch == '\n')
            nval += spaces;
    }
    return nval;
}

void saveProgram(string val)
{
    cout << "#include \"tupin.hpp\"\n"
         << "using namespace std;\n"
         << "using namespace tupin;\n"
         << "\n"
         << val
         << "\n"
         << "\nint main() {\n"
         << tab("return 0;")
         << "\n}\n\n";
}