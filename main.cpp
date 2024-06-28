#include <iostream>
#include <fstream>
#include "parser.tab.h"

extern "C" FILE *yyin;

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <filename>\n";
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        std::cerr << "Could not open file: " << argv[1] << std::endl;
        return 1;
    }

    // Set Flex to read from it instead of defaulting to STDIN
    yyin = file;

    // Parse through the file provided by user
    int parse_result = yyparse();
    fclose(file);

    if (parse_result == 0) {
        std::cout << "Parsing completed successfully." << std::endl;
    } else {
        std::cout << "Parsing failed." << std::endl;
    }

    return parse_result;
}

