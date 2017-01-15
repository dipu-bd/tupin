using namespace std;

int MainFunction(int argc, char** argv)
{
    auto begin = std::chrono::high_resolution_clock::now();
    init(argc, argv);    

    int res = yyparse();

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>(end-begin).count();
    fprintf(stderr, "\n\nExited with status %d\nRuntime: %f ms.\n", res, duration / 1e6);

    return res;
}

void yyerror(const char *msg, int line, int col, const char* file = "")
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
    for(int i = 0; i < siz; ++i)
    {
        spaces.push_back(' ');
    }

    std::string nval = spaces;
    for(char ch : val)
    {
        nval.push_back(ch);
        if(ch == '\n') nval += spaces;
    }    
    return nval; 
}