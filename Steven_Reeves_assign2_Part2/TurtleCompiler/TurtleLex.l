
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
"-"			{ return yytext[0]; }
"*"			{ return yytext[0]; }
"/"			{ return yytext[0]; }

home		{ return HOME; }
fd			{ return FD; }
setxy		{ return SETXY; }
setc		{ return SETC; }

black		{ return COLOR_NAME; }
white		{ return COLOR_NAME; }
orange		{ return COLOR_NAME; }
yellow		{ return COLOR_NAME; }
lime		{ return COLOR_NAME; }
cyan		{ return COLOR_NAME; }
blue		{ return COLOR_NAME; }
magenta		{ return COLOR_NAME; }
red			{ return COLOR_NAME; }
brown		{ return COLOR_NAME; }
green		{ return COLOR_NAME; }
turquoise	{ return COLOR_NAME; }
sky			{ return COLOR_NAME; }
violet		{ return COLOR_NAME; }
pink		{ return COLOR_NAME; }


.			{ }
\n			{ yylineno++; }

%%

void yyerror(const char * msg)
{
	fprintf(stderr, "ERROR! Line #%d: %s at %s\n", yylineno, msg, yytext);
}

