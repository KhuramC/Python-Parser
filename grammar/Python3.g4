grammar Python3;

/*
 * ======================================================================
 * PARSER RULES
 * ======================================================================
 */

program: statement (NEWLINE+ statement)* (NEWLINE+)? EOF;

statement: assignment_statement;

assignment_statement:
    ID (ASSIGN | ADD_ASSIGN | SUB_ASSIGN | MUL_ASSIGN | DIV_ASSIGN) expression
    ;

expression: addSubExpr;

addSubExpr:
    mulDivModExpr ( (ADD | SUB) mulDivModExpr )*
    ;

mulDivModExpr:
    atom ( (MUL | DIV | MOD) atom )*
    ;

// 'atom' is now expanded to include all new types
atom:
    NUMBER          // e.g., 5, -100, 1.23
    | ID            // e.g., x, varName
    | STRING        // e.g., "20", 'a'
    | BOOLEAN       // e.g., True
    | array         // e.g., [1, 2, 3]
    | LPAREN expression RPAREN // e.g., (5 + x)
    ;

// NEW: A parser rule for array structures
array:
    LBRACK (expression (COMMA expression)*)? RBRACK
    ;


/*
 * ======================================================================
 * LEXER RULES
 * (Order is important here!)
 * ======================================================================
 */

// --- Operators ---
ASSIGN:     '=';
ADD_ASSIGN: '+=';
SUB_ASSIGN: '-=';
MUL_ASSIGN: '*=';
DIV_ASSIGN: '/=';
ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';
MOD: '%';

// --- Punctuation (NEW for arrays and parens) ---
LPAREN: '(';
RPAREN: ')';
LBRACK: '[';
RBRACK: ']';
COMMA:  ',';

// --- Keywords (NEW for Booleans) ---
// This MUST be defined before the ID rule
BOOLEAN: 'True' | 'False';

// --- Literals ---

// UPDATED: Now supports integers AND floats
NUMBER: '-'? [0-9]+ ('.' [0-9]+)?; 

// NEW: Supports strings with "double" or 'single' quotes
STRING:
    '"' ( '\\' . | ~["\\] )* '"'
    | '\'' ( '\\' . | ~['\\] )* '\''
    ;

// --- Identifier ---
// This must be one of the LAST rules
ID:     [a-zA-Z_] [a-zA-Z_0-9]*; 

// --- Whitespace (Ignored) ---
WS:     [ \t]+ -> skip; 
NEWLINE: ( '\r'? '\n' ) ;