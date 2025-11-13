grammar PythonSubset;

/*
* ==============
  PARSING RULES
* ==============
*/

start: program;

program: statement (NEWLINE+ statement)* (NEWLINE+)? EOF;

statement: assignment_statement;

assignment_statement:
	ID (
		ASSIGN
		| ADD_ASSIGN
		| SUB_ASSIGN
		| MUL_ASSIGN
		| DIV_ASSIGN
	) expression;

expression: addSubExpr;

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

LPAREN: '(';
RPAREN: ')';
LBRACK: '[';
RBRACK: ']';
COMMA: ',';

// --- Keywords --- define before id
BOOLEAN: 'True' | 'False';

NUMBER: '-'? [0-9]+ ('.' [0-9]+)?;

// Supports strings with "double" or 'single' quotes
STRING:
	'"' ('\\' . | ~["\\])* '"'
	| '\'' ( '\\' . | ~['\\])* '\'';

// --- Identifier/variable name --- 
ID: [a-zA-Z_] [a-zA-Z_0-9]*;

// --- Whitespace ---
WS: [ \t]+ -> skip;
NEWLINE: ( '\r'? '\n');