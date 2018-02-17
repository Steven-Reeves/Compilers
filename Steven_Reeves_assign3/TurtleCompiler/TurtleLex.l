
%{

/* Turtle Compiler lex file
   by Pete Myers
   OIT Portland Fall 2008
   Flex C++ version Jan 2017

   Assign 3 Handout
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

black		{yylval.colorType = BLACK; return COLOR_NAME;}

"+"			{ return yytext[0]; }
"-"			{ return yytext[0]; }

"="			{ return yytext[0]; }
"("			{ return yytext[0]; }
")"			{ return yytext[0]; }
"["			{ return yytext[0]; }
"]"			{ return yytext[0]; }

if			{return IF;}

home		{ return HOME; }
fd			{ return FD; }
rt			{ return RT; }
color		{ return COLOR; }
xcor		{ return XCOR; }

.			{ }
\n			{ yylineno++; }

%%

void yyerror(const char * msg)
{
	fprintf(stderr, "ERROR! Line #%d: %s at %s\n", yylineno, msg, yytext);
}

