grammar PythonSubset;

/*
* ==============
  PARSING RULES
* ==============
*/

start: program;

program: (NEWLINE)* statement (NEWLINE+ statement)* (NEWLINE+)? EOF;

statement:
    assignment_statement
    | if_statement;

// 		   Add (NEWLINE*) before ELIF and ELSE to allow
//         them to be on different lines from the preceding block.
if_statement:
    IF expression COLON block
    (NEWLINE* ELIF expression COLON block)*
    (NEWLINE* ELSE COLON block)?;

// Block rule expects a NEWLINE, then an INDENT token,
// then one or more statements that are also prefixed by NEWLINE INDENT.
block: NEWLINE INDENT statement (NEWLINE INDENT statement)*;


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
	| LPAREN expression RPAREN ; // e.g., (5 + x)

array: LBRACK (expression (COMMA expression)*)? RBRACK;

/*
* ====================
  LEXER RULES
  (Order is important)
 =====================
*/

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

WS: [ \t]+ -> skip;

// NEWLINE is no longer skipped.
NEWLINE: ( '\r'? '\n');