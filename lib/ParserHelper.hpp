using namespace std;

extern string token;
extern FileSystem env;
extern int line, column;
extern FILE *yyin, *yyout;

/* Function definitions for parser*/
void init(int argc, char **argv)
{
    env = FileSystem(argc, argv);

    if (argc > 1 && argv[1])
    {
        yyin = fopen(argv[1], "r");
    }
    if (argc > 2 && argv[2])
    {
        yyout = fopen(argv[2], "w");
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
    yyerror(msg, line, column, env.sourceFile().data());
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

string defFunction(string name, string args, string block)
{ 
    string retType = "__RET__";
    string argType = "__ARG";

    int cnt = 0;
    string arglist = "";
    string tmp = "typename " + retType;

    char delim = '\n';
    while (args.size())
    {
        size_t pos = args.find(delim);
        string arg = args;
        if (pos > 0)
        {
            arg = args.substr(0, pos);
            args = args.substr(pos + 1);
        }
        cnt++;
        string type = argType + to_string(cnt);
        tmp += ", typename " + type;
        if (cnt > 1) arglist += ", ";
        arglist += type + " " + arg;
    }

    string func = "template <" + tmp + "> \n";
    func += retType + " " + name + "(" + arglist + ") {\n";
    func += block;
    return func;
}

void saveProgram(string val)
{
    string out = "#include \"tupin.hpp\"\n";
    out += "using namespace std;\n";
    out += "using namespace tupin;\n";
    out += "\n";
    out += val;
    out += "\n";
    out += "\nint main() {\n";
    out += tab("return 0;");
    out += "\n}\n";
    fprintf(yyout, "%s", out.data());
}