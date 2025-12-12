# Python Parser Project

https://github.com/KhuramC/Python-Parser

This project implements a parser for a subset of the Python 3.x language using ANTLR 4. The parser utilizes a Context-Free Grammar (CFG) to process Python source code, handling Python's indentation-sensitive rules, and outputs a parse tree structure.


## Supported Features
This parser supports the following Python 3.x features:

* **Arithmetic:** `+`, `-`, `*`, `/`, `%`
* **Assignment:** `=`, `+=`, `-=`, `*=`, `/=`
* **Control Flow:** `if`, `elif`, `else` blocks
* **Loops:** `while` and `for` loops
* **Conditionals:** `<`, `<=`, `>`, `>=`, `==`, `!=`, `and`, `or`, `not`
* **Data Types:** Integers, Floats, Strings (`"`, `'`), and Booleans (`True`, `False`)
* **Data Structures:** Arrays/Lists (e.g., `[1, 2, 3]`)
* **Functions:** Function call parsing (e.g., `func(a, b)`)
* **Comments:** Single line (`#`) and multi-line (`'''`)


## Requirements/Dependencies

- [ANTLR 4.13.2](https://www.antlr.org/download/antlr-4.13.2-complete.jar)
- Python 3.x (e.g., 3.8+ is recommended)
- **Runtime**
  - Python runtime: `pip install antlr4-python3-runtime`
  - *Or* C++ runtime (if using the executable version)
- **Visualization**: `pip install antlr4-tools`


## How to Use

### 1. Build the Parser
Generate the parser files using the provided scripts or the ANTLR command:

* **Windows:**
  ```powershell
  ./create_parser.ps1
  ```

* **Unix/macOS:**
  ```bash
  ./create_parsher.sh
  ```

* **Manual Command**
  ```bash
  antlr4 -Dlanguage=Cpp -o generated/ ./grammar/PythonSubset.g4
  ```
  
### 2. Run the Parser

You can run the parser against a Python test file (e.g., `test.py`).

  ```bash
  python .\grammar\main.py input_file.py
  ```

*Hint: Try `simple.py`.*

### 3. Visualization

  ```bash
  antlr4-parse .\grammar\PythonSubset.g4 start -gui input_file.py
  ```


## Demo

**Click the photo below!!!**

[![Python Parser Demo](https://img.youtube.com/vi/wkbUzMx9BZY/maxresdefault.jpg)](https://youtu.be/wkbUzMx9BZY)


## Team Members

- Khuram Choudhry
- Alon Barzilay
- Pablo Lasarte
- Hipolito Sanchez
- Evan Schreiner
