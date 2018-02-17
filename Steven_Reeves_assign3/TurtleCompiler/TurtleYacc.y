%{

/* Turtle Compiler yacc file
   by Pete Myers
   OIT Portland Fall 2008
   Bison C++ version Jan 2017

   Assign 3 Handout
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
%token RT
%token IF
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
	|	FD expression					{ $$ = factory->CreateTurtleCmd(CMD_FD, $2); }
	|	RT expression					{ $$ = factory->CreateTurtleCmd(CMD_RT, $2); }
	|	IF '(' condition ')' '[' statements ']'	{ $$ = factory->CreateIf($3, $6); }
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
