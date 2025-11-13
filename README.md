# Python Parser

A basic Python 3.x Parser. TODO: Flesh out description

## Requirements/Dependencies

- [ANTLR](https://www.antlr.org/download/antlr-4.13.2-complete.jar)
- Python 3.x
- Python ANTLR runtime
  - Can be downloaded with `pip install antlr4-python3-runtime`
- ANTLR tools(for plotting the parser tree)
  - Can be downloaded with `pip install antlr4-tools`

## How to Use

1. Cd into the grammar directory
1. Create parser using `antlr4 -Dlanguage=Python3 PythonSubset.g4`, or use the [PowerShell script](./create_parser.ps1).
1. Run `main.py` with `python main.py`
1. A syntax tree should be printed as text.
1. Alternatively, use the provided [PowerShell script](./parser_tree.ps1)

## Demo

TODO: embed video demo into README

## Team Members

- Khuram Choudhry
- Alon Barzilay
- Pablo Lasarte
- Hipolito Sanchez
- Evan Schreiner
