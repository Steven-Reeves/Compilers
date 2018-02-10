%{

/* Turtle Compiler yacc file
   by Pete Myers and Steven Reeves
   OIT Portland Fall 2008
   Bison C++ version Jan 2017

   Assignment 2 Part 2
*/

#include <stdio.h>
#include <stdlib.h>

extern FILE * yyin;
extern FILE * yyout;
extern int yylineno;
void yyerror(const char *);

int yylex(void);

%}

%token HOME
%token FD
%token NUMBER
%token COLOR_NAME
%token SETXY
%token SETC




%left '+' '-'
%left '*' '/'


%%

statements:	statement statements		{ printf("statements->statement statements\n"); }
	|									{ printf("statements-><empty>\n"); }
	;

statement:	HOME						{ printf("statement->HOME\n"); }
	|	FD expression					{ printf("statement->FD expression\n"); }
	|	SETXY expression expression		{ printf("statement->SETXY expression expression\n"); }
	|	SETC expression					{ printf("statement->SETC expression\n"); }
	;

expression:	expression '+' expression	{ printf("expression->expression + expression\n"); }
	|	expression '-' expression		{ printf("expression->expression - expression\n"); }
	|	expression '*' expression		{ printf("expression->expression * expression\n"); }
	|	expression '/' expression		{ printf("expression->expression / expression\n"); }
	|	NUMBER							{ printf("expression->NUMBER\n"); }
	|	COLOR_NAME						{ printf("expression->COLOR_NAME\n"); }
	;

%%
