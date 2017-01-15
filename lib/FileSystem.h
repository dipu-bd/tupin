#include <iostream>
#include <cstdio>
#include <cstdlib>

#ifndef __TUPIN_FILE_SYSTEM__
#define __TUPIN_FILE_SYSTEM__ 1

class FileSystem
{
public:
    std::string curfile; 
    std::string infile;
    std::string outfile;

    FileSystem(int argc = 0, char** argv = 0)         
    {
        if(argc > 0 && argv[0]) {
            curFile = argv[0];
        }
        if(argc > 1 && argv[1]) {
            inFile = argv[1];
        }
        if(argc > 2 && argv[2]) {
            outFile = argv[2];
        }
    }

    std::string sourceFile() 
    {
        return getFile(file).data();
    }

    std::string currentPath() 
    {
        return getDir(file).data();
    }
    
    friend std::string getDir(std::string fullPath) {

        size_t found = fullPath.find_last_of("/\\");
        if(found <= 0) return ""; 
        return fullPath.substr(0,found);
    }

    friend std::string getFile(std::string fullPath) 
    {
        size_t found = fullPath.find_last_of("/\\");
        if(found <= 0) return ""; 
        return fullPath.substr(found + 1);
    }

}

#endif
