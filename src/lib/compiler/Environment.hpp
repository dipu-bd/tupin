
auto begin = std::chrono::high_resolution_clock::now();

struct Environment
{
    int argc;
    char **argv;    

    Environment(int c = 0, char **v = 0) : argc(c), argv(v) {         
    } 

    int count() const
    {
        return argc;
    }
    const char *cur() const
    {
        return argv[0];
    }
    const char* input() const
    {
        if(argc >= 1)
        {
            return argv[1];
        }
        return "";
    }
    FILE* openInput() const
    {
        if (argc >= 1)
        {
            return fopen(argv[1], "r");
        }
        return 0;
    }
    FILE* openOutput() const
    {
        if (argc >= 2)
        {
            return fopen(argv[2], "w");
        }
        return 0;
    }
    
    void showTime() const
    { 
        auto end = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>(end-begin).count();
        printf("\n\nRuntime: %f ms\n", duration / 1e6);
    }
};