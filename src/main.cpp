// Save this as src/main.cpp
#include <iostream>
#include "antlr4-runtime.h" // Main ANTLR runtime header
#include "Python3Lexer.h"   // Header generated from your grammar
#include "Python3Parser.h"  // Header generated from your grammar

// Note: The Makefile's -I flags let us include these
// without "generated/" in the path.

using namespace antlr4;

int main(int argc, const char* argv[]) {
    // 1. Create a stream that reads from standard input (cin)
    ANTLRInputStream input(std::cin);

    // 2. Create a lexer that feeds off the input stream
    Python3Lexer lexer(&input);

    // 3. Create a buffer of tokens pulled from the lexer
    CommonTokenStream tokens(&lexer);

    // 4. Create a parser that feeds off the tokens buffer
    Python3Parser parser(&tokens);

    // 5. Begin parsing at the 'program' rule
    //    This line is the one that actually runs the parser.
    tree::ParseTree* tree = parser.program();

    // 6. Print the parse tree in LISP-style format
    //    (This is the text-based tree your assignment mentioned)
    std::cout << std::endl << "Parse Tree:" << std::endl;
    std::cout << tree->toStringTree(&parser) << std::endl;

    return 0;
}