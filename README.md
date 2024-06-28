
# Lexer and Parser Installation and Execution Guide

This guide covers how to install Flex and Bison, compile Flex and Bison files (`lexer.l` and `parser.y`), and execute the generated program on a Linux operating system.

### Installing Flex and Bison

**Linux**: Use your distribution's package manager. For Ubuntu/Debian-based systems, run:
  ```sh
  sudo apt-get update
  sudo apt-get install flex
  sudo apt-get install bison
  
  
### Compiling the Lexer and Parser

Navigate to the directory containing your lexer.l, parser.y, and main.cpp file.
```sh
bison -d parser.y
flex lexer.l
g++ -o parser_program parser.tab.c lex.yy.c main.cpp
```

This generates an executable named 'parser_program'.

### Executing the Parser Program

To run the parser program:
```sh
./parser_program
```

To process a file, redirect the file's contents as input:
```sh
../parser_program < inputfile.txt
```

## Note

- This (“ ”)  will be considered invalid as the lexer only identifies the (" "). That is the the curly quotation marks are not recognized only the straight quotations are identified. So please change all curly quotations to straight quotations to avoid any invalid statements. 
