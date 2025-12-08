grammar PythonSubset;

/*
* ==============
* PARSING RULES
* ==============
*/

start: program;

program: (NEWLINE)* statement (NEWLINE+ statement)* (NEWLINE+)? EOF;

statement:
    assignment_statement
    | if_statement
    | while_statement
    | for_statement;

// Note: ELIF/ELSE allow NEWLINE* to permit spacing between blocks
if_statement:
    IF expression COLON block
    (NEWLINE* ELIF expression COLON block)*
    (NEWLINE* ELSE COLON block)?;

while_statement: WHILE expression COLON block;

for_statement: FOR ID IN expression COLON block;

// We accept one or more INDENT tokens to signify a block.
block: NEWLINE INDENT+ statement (NEWLINE INDENT+ statement)*;

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

function_call: ID LPAREN (expression (COMMA expression)*)? RPAREN;

/*
* ====================
*  LEXER RULES
*  (Order is important)
* ====================
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
WHILE: 'while';
FOR: 'for';
IN: 'in';
BOOLEAN: 'True' | 'False';
AND: 'and';
OR: 'or';
NOT: 'not';
RANGE: 'range';

// --- Literals and Identifiers ---
NUMBER: '-'? [0-9]+ ('.' [0-9]+)?;

STRING:
    '"' ('\\' . | ~["\\])* '"'
    | '\'' ( '\\' . | ~['\\])* '\'';

ID: [a-zA-Z_] [a-zA-Z_0-9]*;

// --- Comments ---
SINGLE_LINE_COMMENT: '#' ~[\r\n]* -> skip;
MULTI_LINE_COMMENT: (
    '\'\'\'' .*? '\'\'\''
    | '"""' .*? '"""'
    ) -> skip;

// --- Whitespace & Indentation ---


INDENT: '    ' | '\t';
WS: [ \t]+ -> skip;

NEWLINE: ( '\r'? '\n');