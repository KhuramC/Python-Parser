# Python Parser

A basic Python 3.x Parser. TODO: Flesh out description

## Team Members

- Khuram Choudhry
- Alon Barzilay
- Pablo Lasarte
- Hipolito Sanchez
- Evan Schreiner

## Requirements & Setup

This project is built using C++17, ANTLR 4, and the make build system. The following environment is required for building and running the parser.

### Environment

- OS: Windows 10/11
- Terminal: MSYS2 MINGW64
- Compiler: g++ (C++17)
- Build System: make
- Java: A Java JDK (version 17 or newer) is required to run the ANTLR tool.

### Setup Steps

**Install MSYS2:**

Download and install MSYS2 from <https://www.msys2.org/>.

Install it to the default location (C:\msys64).

**Install Build Tools:**

Open the "MSYS2 MINGW 64-bit" terminal.

Update the package manager: `pacman -Syu` (you may need to close and re-run this).

Install the C++ compiler, make, and other core tools:

```bash
pacman -S --needed mingw-w66-x86_64-toolchain base-devel
```

**Install Java JDK:**

Download a Windows x64 JDK (version 17 or newer) <https://adoptium.net/temurin/releases/>.

Download the .zip file, not the .msi installer.

Extract the folder to a permanent location (e.g., C:\Program Files\Java\jdk-21).

Add Java to your MSYS2 terminal's PATH. Run nano ~/.bashrc and add the following line (adjust the path to match your install):

```bash
export PATH="/c/Program Files/Java/jdk-21/bin:$PATH"
```

Restart your terminal and verify by running `java --version`.

**Clone This Repository:**

Clone the project, which includes the required ANTLR C++ runtime source code:

```bash
git clone https://github.com/KhuramC/Python-Parser.git
```

This repository also includes the antlr-4.13.1-complete.jar tool, which is used by the Makefile.

## How to Use/Run the Parser

All commands must be run from the MSYS2 MINGW 64-bit terminal in the root project directory.

1. Build the Parser

    A Makefile is provided to handle all compilation.
    To build the parser for the first time (or after changing the grammar), run:

    ```bash
    make
    ```

    This command will first run ANTLR to generate the parser files (placing them in the generated/ directory) and then compile all C++ source code into a single executable named my_parser.exe.

    To clean build files, run:

    ```bash
    make clean
    ```

2. Run the Parser

    The parser reads Python code from standard input and prints the resulting parse tree to standard output.

    The easiest way to run it is by redirecting a test file.

    ```bash
    ./my_parser.exe < test.py
    ```

## Demo

TODO: embed video demo into README
