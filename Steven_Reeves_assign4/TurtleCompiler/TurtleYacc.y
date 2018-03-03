%{

/* Turtle Compiler yacc file
   by Pete Myers
   OIT Portland Fall 2008
   Bison C++ version Jan 2017

   Assign 4 Handout
*/

#include <stdio.h>
#include <stdlib.h>
#include "tree.h"
#include "symtable.h"
#include "codegen.h"

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
	int value;
	SymbolTable::Entry * symentry;
}

%token HOME
%token FD
%token <value> NUMBER

%type <node> statements
%type <node> statement
%type <node> expression

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
	;

expression:	expression '+' expression	{ $$ = factory->CreateOperator(OT_PLUS, $1, $3); }
	|	NUMBER							{ $$ = factory->CreateNumber($1); }
	;

%%
