grammar PythonSubset;

/*
* ==============
  PARSING RULES
* ==============
*/

start: program;

// A program is one or more statements or blank lines 
program: (statement | NEWLINE)+ EOF;

statement:
    assignment_statement
    | if_statement
    | while_statement
    | for_statement;

if_statement:
    IF expression COLON block
    (NEWLINE* INDENT* ELIF expression COLON block)*
    (NEWLINE* INDENT* ELSE COLON block)?;

while_statement:
    WHILE expression COLON block;

for_statement:
    FOR ID IN expression COLON block;

// Block rule expects a NEWLINE, then an INDENT token,
// then one or more statements that are also prefixed by NEWLINE INDENT.
block: (NEWLINE INDENT+ statement)+;


assignment_statement:
    ID (
        ASSIGN
        | ADD_ASSIGN
        | SUB_ASSIGN
        | MUL_ASSIGN
        | DIV_ASSIGN
    ) expression;

/*
* Expression rules with precedence
*/

expression: orExpr;

orExpr: andExpr (OR andExpr)*;

andExpr: notExpr (AND notExpr)*;

notExpr: (NOT)? comparisonExpr;

comparisonExpr: addSubExpr ( (EQ | NEQ | GTE | LTE | GT | LT) addSubExpr)*;

addSubExpr: mulDivModExpr ( (ADD | SUB) mulDivModExpr)*;

mulDivModExpr: atom ( (MUL | DIV | MOD) atom)*;

atom:
	NUMBER // e.g., 5, -100, 1.23
	| ID // e.g., x, varName
	| STRING // e.g., "20", 'a'
	| BOOLEAN // e.g., True
	| array // e.g., [1, 2, 3]
    | function_call // e.g., func(a, b)
	| LPAREN expression RPAREN ; // e.g., (5 + x)

function_call: ID LPAREN (expression (COMMA expression)*)? RPAREN;

array: LBRACK (expression (COMMA expression)*)? RBRACK;

/*
* ====================
  LEXER RULES
  (Order is important)
 =====================
*/

// Skip single line commments that start with "#"
COMMENT: '#' ~[\r\n]* -> skip;

// Skip multi-line comments enclosed in ''' '''
MULTI_LINE_COMMENT: '\'\'\'' .*? '\'\'\'' -> skip;

// --- Operators ---
ASSIGN: '=';
ADD_ASSIGN: '+=';
SUB_ASSIGN: '-=';
MUL_ASSIGN: '*=';
DIV_ASSIGN: '/=';
ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';
MOD: '%';

// --- Comparison Operators ---
EQ: '==';
NEQ: '!=';
GTE: '>=';
LTE: '<=';
GT: '>';
LT: '<';

// --- Punctuation ---
LPAREN: '(';
RPAREN: ')';
LBRACK: '[';
RBRACK: ']';
COMMA: ',';
COLON: ':';

// --- Keywords --- define before id
IF: 'if';
ELIF: 'elif';
ELSE: 'else';
WHILE: 'while';
FOR: 'for';
IN: 'in';
BOOLEAN: 'True' | 'False';
AND: 'and';
OR: 'or';
NOT: 'not';

// --- Literals and Identifiers ---
NUMBER: '-'? [0-9]+ ('.' [0-9]+)?;

STRING:
    '"' ('\\' . | ~["\\])* '"'
    | '\'' ( '\\' . | ~['\\])* '\'';

ID: [a-zA-Z_] [a-zA-Z_0-9]*;

// --- Whitespace & Indentation ---

// Allow INDENT to be 4 spaces OR a tab.
// It MUST come before the general WS rule.
INDENT: ('    ' | '\t');

// WS only matches simple spaces.
WS: [ ]+ -> skip; 

NEWLINE: ( '\r'? '\n' );