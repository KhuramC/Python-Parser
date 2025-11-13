from antlr4 import InputStream, CommonTokenStream
from pathlib import Path

from PythonSubsetLexer import PythonSubsetLexer
from PythonSubsetParser import PythonSubsetParser

deliverable_path = Path("../deliverables")

current_deliverable = deliverable_path / "project_deliverable_1.py"

def main():


    stream = InputStream(current_deliverable.read_text())
    lexer = PythonSubsetLexer(stream)
    tokens = CommonTokenStream(lexer)
    parser = PythonSubsetParser(tokens)
    tree = parser.start()

    if parser.getNumberOfSyntaxErrors() > 0:
        print("Nonzero amounts of errors")
    print(tree.toStringTree(recog=parser))
    

if __name__ == "__main__":
    main()

        