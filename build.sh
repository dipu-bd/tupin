rm -rf "build/" && 
rm "Program" && 
mkdir "build" && 
flex -o"build/Lexer.cpp" Lexer.l && 
g++ -Wall -o "Program" "build/Lexer.cpp"
