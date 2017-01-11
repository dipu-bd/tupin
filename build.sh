rm -rf "build/" &&
rm -f "Program" &&
mkdir "build" && 
flex -o"build/Lexer.cpp" Lexer.l && 
cp "Lexer.h" "build/" &&
g++ -std=c++11 -o "Program" "build/Lexer.cpp" 
