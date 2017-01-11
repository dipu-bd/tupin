rm -rf "build/" && 
rm "Program" && 
mkdir "build" && 
flex -o"build/Lexer.cpp" Lexer.l && 
gcc -Wall -o "Program" "build/Lexer.cpp" 
