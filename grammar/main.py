from antlr4 import InputStream, CommonTokenStream
from pathlib import Path
import sys
import os

from PythonSubsetLexer import PythonSubsetLexer
from PythonSubsetParser import PythonSubsetParser

deliverable_path = os.path.join("../deliverables/project_deliverable_3.py")

def main():

    if len(sys.argv) > 1:
        input_file_path = Path(sys.argv[1])
        print(f"Parsing file: {input_file_path}")

    else:
        print("No file provided. Using default deliverable 3.")
        input_file_path = deliverable_path

    try:
        input_stream = InputStream(input_file_path.read_text())
    except FileNotFoundError:
        print(f"Error: Could not find file {input_file_path}")
        return

    stream = InputStream(input_file_path.read_text())
    lexer = PythonSubsetLexer(stream)
    tokens = CommonTokenStream(lexer)
    parser = PythonSubsetParser(tokens)
    tree = parser.start()

    if parser.getNumberOfSyntaxErrors() > 0:
        print("Nonzero amounts of parsing errors")
    else:
        print(tree.toStringTree(recog=parser)) # very unreadable, but it does print
    

if __name__ == "__main__":
    main()

        