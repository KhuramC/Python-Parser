# Save this as Makefile

# 1. Set your C++ compiler
CXX = g++

# 2. Define project structure
G4_FILE     = grammar/Python3.g4
G4_BASENAME = Python3
MAIN_CPP    = src/main.cpp
GENERATED_DIR = generated
RUNTIME_DIR = antlr4-cpp-runtime-4.13.1-source

# 3. Set compiler flags
CXXFLAGS = -std=c++17 -g -Wall -DANTLR4CPP_STATIC \
           -I./src \
           -I./grammar \
           -I./$(GENERATED_DIR) \
           -I./$(RUNTIME_DIR)/runtime/src \
           -I./$(RUNTIME_DIR)/runtime/thirdparty/utf8

# 4. List all source files
SRC = $(MAIN_CPP) \
      $(GENERATED_DIR)/$(G4_BASENAME)Lexer.cpp \
      $(GENERATED_DIR)/$(G4_BASENAME)Parser.cpp \
      $(GENERATED_DIR)/$(G4_BASENAME)BaseVisitor.cpp \
      $(GENERATED_DIR)/$(G4_BASENAME)Visitor.cpp \
      $(wildcard $(RUNTIME_DIR)/runtime/src/*.cpp) \
      $(wildcard $(RUNTIME_DIR)/runtime/src/atn/*.cpp) \
      $(wildcard $(RUNTIME_DIR)/runtime/src/dfa/*.cpp) \
      $(wildcard $(RUNTIME_DIR)/runtime/src/misc/*.cpp) \
      $(wildcard $(RUNTIME_DIR)/runtime/src/support/*.cpp) \
      $(wildcard $(RUNTIME_DIR)/runtime/src/internal/*.cpp) \
      $(wildcard $(RUNTIME_DIR)/runtime/src/tree/*.cpp) \
      $(wildcard $(RUNTIME_DIR)/runtime/src/tree/pattern/*.cpp) \
      $(wildcard $(RUNTIME_DIR)/runtime/src/tree/xpath/*.cpp) \
      $(wildcard $(RUNTIME_DIR)/runtime/thirdparty/utf8/src/*.cpp)

# 5. Define the target executable name
TARGET = my_parser

# 6. Default 'all' rule: depends on parser files first
all: $(TARGET)

# 7. Rule to build the target executable
$(TARGET): $(GENERATED_DIR)/$(G4_BASENAME)Lexer.h $(SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC)

# 8. Rule to generate parser files from the grammar
$(GENERATED_DIR)/$(G4_BASENAME)Lexer.h: $(G4_FILE)
	java -jar /d/tools/antlr-4.13.1-complete.jar -Dlanguage=Cpp -visitor -o $(GENERATED_DIR) $(G4_FILE)

# 9. A 'clean' rule to remove generated files
clean:
	rm -f $(TARGET)
	rm -f $(TARGET).exe
	rm -rf $(GENERATED_DIR)