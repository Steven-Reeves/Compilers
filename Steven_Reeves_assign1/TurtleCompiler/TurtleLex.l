
%{

/* Turtle Compiler lex file
   by Pete Myers and Steven Reeves 
   OIT Portland Fall 2008
   Flex C++ version Jan 2017

   Built off of Assignment 1 Handout
*/

#include <stdio.h>
#include <stdlib.h>

void PrintKeyword(const char * lexeme);
void PrintIdentifier(const char * lexeme);
void PrintNumber(const char * lexeme);
void PrintIllegal(const char * lexeme);

%}

%option noyywrap

%%

\-?[0-9]+		{ PrintNumber(yytext); }

"["			{ PrintKeyword(yytext); }
"]"			{ PrintKeyword(yytext); }

home		{ PrintKeyword(yytext); }
fd			{ PrintKeyword(yytext); }
setxy		{ PrintKeyword(yytext); }


\/\/.*\n	{printf("Single line comment: %s", yytext);}

\/\*(.|\n)*\*\/	{printf("C style line comment: %s", yytext);}


(\t|" ")+	{ /* ignore whitespace */ }

\n			{ yylineno++; }

.			{ PrintIllegal(yytext); }


%%

void PrintKeyword(const char * lexeme)
{
	printf("Keyword: %s\n", lexeme);
}

void PrintIdentifier(const char * lexeme)
{
	printf("Id: %s\n", lexeme);
}

void PrintNumber(const char * lexeme)
{
	printf("Number: %s\n", lexeme);
}

void PrintIllegal(const char * lexeme)
{
	printf("Illegal: %s\n", lexeme);
}

void yyerror(const char * msg)
{
	fprintf(stderr, "ERROR! Line #%d: %s at %s\n", yylineno, msg, yytext);
}

