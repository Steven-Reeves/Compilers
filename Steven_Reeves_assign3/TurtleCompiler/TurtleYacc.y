%{

/* Turtle Compiler yacc file
   by Pete Myers and Steven Reeves
   OIT Portland Fall 2008
   Bison C++ version Jan 2017

   Assign 3 
*/

#include <stdio.h>
#include <stdlib.h>
#include "tree.h"
#include "symtable.h"

TreeNode * root;

extern TreeNodeFactory * factory;

extern FILE * yyin;
extern FILE * yyout;
extern int yylineno;
void yyerror(const char *);

int yylex(void);

%}

%union
{
	TreeNode * node;
	BlockTreeNode * block;
	int value;
	COLOR_TYPE colorType;
	SymbolTable::Entry * symentry;
}

%token HOME
%token FD
%token COLOR
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
%token <colorType> COLOR_NAME
%token <value> NUMBER

%type <block> statements
%type <node> statement
%type <node> expression
%type <node> function
%type <node> condition

%left '+' '-'
%left '*' '/'

%%

statements:	statement statements		{
											if ($1 != NULL)
											{
												// there is a statement node
												$$ = factory->CreateBlock();
												$$->AddChild($1);
												if ($2 != NULL)
												{
													$$->AdoptChildren($2);
												}
												root = $$;
											}
											else
											{
												// there is no statement node
												$$ = $2;
											}
										}
	|									{ $$ = NULL; }
	;

statement:	HOME						{ $$ = factory->CreateTurtleCmd(CMD_HOME); }
	|	PD								{ $$ = factory->CreateTurtleCmd(CMD_PD); }
	|	PU								{ $$ = factory->CreateTurtleCmd(CMD_PU); }
	|	HT								{ $$ = factory->CreateTurtleCmd(CMD_HT); }
	|	ST								{ $$ = factory->CreateTurtleCmd(CMD_ST); }
	|	FD expression					{ $$ = factory->CreateTurtleCmd(CMD_FD, $2); }
	|	RT expression					{ $$ = factory->CreateTurtleCmd(CMD_RT, $2); }
	|	LT expression					{ $$ = factory->CreateTurtleCmd(CMD_LT, $2); }
	|	BK expression					{ $$ = factory->CreateTurtleCmd(CMD_BK, $2); }
	|	SETC expression					{ $$ = factory->CreateTurtleCmd(CMD_SETC, $2); }
	|	SETX expression					{ $$ = factory->CreateTurtleCmd(CMD_SETX, $2); }
	|	SETY expression					{ $$ = factory->CreateTurtleCmd(CMD_SETY, $2); }
	|	SETXY expression expression		{ $$ = factory->CreateTurtleCmd(CMD_SETXY, $2, $3); }
	|	IF '(' condition ')' '[' statements ']'	{ $$ = factory->CreateIf($3, $6); }
	|	IFELSE '(' condition ')' '[' statements ']' '[' statements ']'	{ $$ = factory->CreateIfElse($3, $6, $9); }
	|	REPEAT expression '[' statements ']'	{ $$ = factory->CreateRepeat($2, $4); }	
	;

expression:	expression '+' expression	{ $$ = factory->CreateOperator(OT_PLUS, $1, $3); }
	|	expression '-' expression		{ $$ = factory->CreateOperator(OT_MINUS, $1, $3); }
	|	NUMBER							{ $$ = factory->CreateNumber($1); }
	|	function						{ $$ = $1; }
	|	COLOR_NAME						{ $$ = factory->CreateColorName($1);}
	;

function: COLOR							{ $$ = factory->CreateFunction(FT_COLOR);}
	|	XCOR							{ $$ = factory->CreateFunction(FT_XCOR);}
	;

condition: expression '=' expression	{ $$ = factory->CreateOperator(OT_EQUALS, $1, $3);}
	;

%%
