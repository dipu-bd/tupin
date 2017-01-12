# Building the Lexical Analyzer 

> Using `flex` ([Flex manual page](http://dinosaur.compilertools.net/flex/manpage.html))

### Whitespace
- Spaces
- Tabs 
- New lines
- Empty lines

### Comments
- Single line
- Multi-line

### Strings
- Single quote
- Double quote

### Operators  
- one char: [!%&()*+,\-./:;<=>?\[\\\]^{|}~]
- multi char: *handle it on yacc* 
  
### Numbers
- Integers
- Floats
- Scientific
- Binary
- Octal
- Hexadecimal

### Keywords
- def return
- if elif else
- for continue break
- and or not xor 

### Identifier
- [_$A-Za-z][_$0-9A-Za-z]*



