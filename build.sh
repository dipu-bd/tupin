rm -rf "build/" &&
mkdir "build" && 
cp -R "lib/" "build/" &&
flex -o"build/Lexer.cpp" "src/Lexer.l" && 
g++ -std=gnu++11 -o "build/Program" "build/Lexer.cpp"
