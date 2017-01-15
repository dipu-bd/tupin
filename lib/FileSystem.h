#include <iostream>

#ifndef __TUPIN_FILE_SYSTEM__
#define __TUPIN_FILE_SYSTEM__ 1

class FileSystem
{
  protected:
    std::string curFile;
    std::string inFile;
    std::string outFile;

  public:
    FileSystem(int argc = 0, char **argv = 0)
    {
        if (argc > 0 && argv[0])
        {
            curFile = argv[0];
        }
        if (argc > 1 && argv[1])
        {
            inFile = argv[1];
        }
        if (argc > 2 && argv[2])
        {
            outFile = argv[2];
        }
    }

    std::string currentPath() const
    {
        return getDir(curFile).data();
    }

    std::string sourceFile() const
    {
        return getFile(inFile).data();
    }

    std::string outputFile() const
    {
        return getFile(outFile).data();
    }

    static std::string getDir(std::string fullPath)
    {
        size_t found = fullPath.find_last_of("/\\");
        if (found <= 0)
            return "";
        return fullPath.substr(0, found);
    }

    static std::string getFile(std::string fullPath)
    {
        size_t found = fullPath.find_last_of("/\\");
        if (found <= 0)
            return "";
        return fullPath.substr(found + 1);
    }
};

#endif
