
%{

/* Turtle Compiler lex file
   by Pete Myers
   OIT Portland Fall 2008
   Flex C++ version Jan 2017

   Assign 4 Handout
*/

#include <stdio.h>
#include <stdlib.h>
#include "tree.h"
#include "TurtleYacc.h"
#include "symtable.h"

%}

%option noyywrap

%%

[0-9]+		{ yylval.value = atoi(yytext); return NUMBER; }

"+"			{ return yytext[0]; }

home		{ return HOME; }
fd			{ return FD; }

.			{ }
\n			{ yylineno++; }

%%

void yyerror(const char * msg)
{
	fprintf(stderr, "ERROR! Line #%d: %s at %s\n", yylineno, msg, yytext);
}

