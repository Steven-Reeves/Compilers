
%{

/* Turtle Compiler lex file
   by Pete Myers and Steven Reeves
   OIT Portland Fall 2008
   Flex C++ version Jan 2017

   Assignment 2 Part 2
*/

#include <stdio.h>
#include <stdlib.h>
#include "TurtleYacc.h"

%}

%option noyywrap

%%

[0-9]+		{ return NUMBER; }

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

