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
%token COLOR
%token COLOR_NAME
%token XCOR
%token YCOR
%token HEADING
%token RANDOM
%token SETXY
%token SETC
%token IF
%token IFELSE
%token REPEAT
%token BK
%token RT
%token LT
%token SETX
%token SETY
%token SETH
%token PD 
%token PU 
%token HT 
%token ST 



%left '+' '-'
%left '*' '/'


%%

statements:	statement statements		{ printf("statements->statement statements\n"); }
	|									{ printf("statements-><empty>\n"); }
	;

statement:	HOME						{ printf("statement->HOME\n"); }
	|	PD								{ printf("statement->PD\n"); }
	|	PU								{ printf("statement->PU\n"); }
	|	HT								{ printf("statement->HT\n"); }
	|	ST								{ printf("statement->ST\n"); }
	|	FD expression					{ printf("statement->FD expression\n"); }
	|	BK expression					{ printf("statement->BK expression\n"); }
	|	RT expression					{ printf("statement->RT expression\n"); }
	|	LT expression					{ printf("statement->LT expression\n"); }
	|	SETXY expression expression		{ printf("statement->SETXY expression expression\n"); }
	|	SETC expression					{ printf("statement->SETC expression\n"); }
	|	SETX expression					{ printf("statement->SETX expression\n"); }
	|	SETY expression					{ printf("statement->SETY expression\n"); }
	|	IF '(' conditional_expression ')' '[' statements ']'									{ printf("statement->IF (conditional_expression) [statements]\n"); }
	|	IFELSE '(' conditional_expression ')' '[' statements ']' '[' statements ']'				{ printf("statement->IFELSE (conditional_expression) [statements] [statements]\n"); }
	|	REPEAT expression '[' statements ']'													{ printf("statement->REPEAT expression [statements]\n"); }
	;

expression:	expression '+' expression	{ printf("expression->expression + expression\n"); }
	|	expression '-' expression		{ printf("expression->expression - expression\n"); }
	|	expression '*' expression		{ printf("expression->expression * expression\n"); }
	|	expression '/' expression		{ printf("expression->expression / expression\n"); }
	|	'-' expression					{ printf("expression-> - expression\n"); }
	|	'(' expression ')'				{ printf("expression->( expression)\n"); }
	|	NUMBER							{ printf("expression->NUMBER\n"); }
	|	COLOR_NAME						{ printf("expression->COLOR_NAME\n"); }
	|	function						{ printf("expression->function\n"); }
	;

conditional_expression: expression '=' expression	{ printf("conditional_expression->expression = expression\n"); }
	|	expression '>' expression	{ printf("conditional_expression->expression > expression\n"); }
	|	expression '<' expression	{ printf("conditional_expression->expression < expression\n"); }
	;

function: XCOR							{ printf("expression->XCOR\n"); }
	|	YCOR							{ printf("expression->YCOR\n"); }
	|	HEADING							{ printf("expression->HEADING\n"); }
	|	COLOR							{ printf("expression->COLOR\n"); }
	|	RANDOM '(' expression ')'		{ printf("statement->RANDOM (expression)\n"); }
	;
%%
