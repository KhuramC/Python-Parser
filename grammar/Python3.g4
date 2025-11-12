grammar Python3;

/*
Parser rules
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

// atom includes necessary types.
atom:
    NUMBER          // e.g., 5, -100, 1.23
    | ID            // e.g., x, varName
    | STRING        // e.g., "20", 'a'
    | BOOLEAN       // e.g., True
    | array         // e.g., [1, 2, 3]
| LPAREN expression RPAREN // e.g., (5 + x)
;

// Defines an array (or list) structure.
// e.g., "[]", "[1]", "[1, 2, 3]"
array:
LBRACK (expression (COMMA expression)*)? RBRACK
;

/*
LEXER RULES
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

// --- Punctuation ---
LPAREN: '(';
RPAREN: ')';
LBRACK: '[';
RBRACK: ']';
COMMA:  ',';

// --- Keywords ---
// This MUST be defined before the ID rule to be matched correctly.
BOOLEAN: 'True' | 'False';

// --- Literals ---

// Matches integers and floating-point numbers (e.g., 10, -5.5)
NUMBER: '-'? [0-9]+ ('.' [0-9]+)?;

// Matches strings using either "double" or 'single' quotes.
STRING:
    '"' ( '\\' . | ~["\\] )* '"'
    | '\'' ( '\\' . | ~['\\] )* '\''
    ;

// --- Identifier ---
// Matches variable names (e.g., x, my_var).
// This must be one of the LAST rules to avoid consuming keywords.
ID:     [a-zA-Z_] [a-zA-Z_0-9]*;

// --- Whitespace (Ignored) ---
// Tells the lexer to match whitespace but not produce a token.
WS:     [ \t]+ -> skip;
// Matches newline characters and produces a token for the parser.
NEWLINE: ( '\r'? '\n' ) ;