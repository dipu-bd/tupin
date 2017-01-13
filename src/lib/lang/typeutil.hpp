namespace tupin
{

// %[flags][width][.precision][length]specifier 

map<string, const char*> __PRINTF_FORMAT;

{
    __PRINTF_FORMAT[typeid(int)]            = "d";
    __PRINTF_FORMAT[typeid(signed char)]    = "dhh";
    __PRINTF_FORMAT[typeid(short int)]      = "dh";
    __PRINTF_FORMAT[typeid(long int)]       = "dl";
    __PRINTF_FORMAT[typeid(long long int)]  = "dll";
    __PRINTF_FORMAT[typeid(intmax_t)]       = "dj";
    __PRINTF_FORMAT[typeid(size_t)]         = "dz";
    __PRINTF_FORMAT[typeid(ptrdiff_t)]      = "dt";

    __PRINTF_FORMAT[typeid(unsigned int)]           = "u";
    __PRINTF_FORMAT[typeid(unsigned char)]          = "uhh";
    __PRINTF_FORMAT[typeid(unsigned short int)]     = "uh";
    __PRINTF_FORMAT[typeid(unsigned long int)]      = "ul";
    __PRINTF_FORMAT[typeid(unsigned long long int)] = "u";
    __PRINTF_FORMAT[typeid(uintmax_t)]              = "uj";
} 


// end of file
};