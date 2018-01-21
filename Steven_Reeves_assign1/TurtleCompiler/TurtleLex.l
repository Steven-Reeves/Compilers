
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
"="			{ PrintKeyword(yytext); }
">"			{ PrintKeyword(yytext); }
"<"			{ PrintKeyword(yytext); }
"+"			{ PrintKeyword(yytext); }
"-"			{ PrintKeyword(yytext); }
"*"			{ PrintKeyword(yytext); }
"/"			{ PrintKeyword(yytext); }
"("			{ PrintKeyword(yytext); }
")"			{ PrintKeyword(yytext); }

home		{ PrintKeyword(yytext); }
fd			{ PrintKeyword(yytext); }
setxy		{ PrintKeyword(yytext); }
bk			{ PrintKeyword(yytext); }
rt			{ PrintKeyword(yytext); }
lt			{ PrintKeyword(yytext); }
setc		{ PrintKeyword(yytext); }
setx		{ PrintKeyword(yytext); }
sety		{ PrintKeyword(yytext); }
seth		{ PrintKeyword(yytext); }
pd			{ PrintKeyword(yytext); }
pu			{ PrintKeyword(yytext); }
ht			{ PrintKeyword(yytext); }
st			{ PrintKeyword(yytext); }

color		{ PrintKeyword(yytext); } 
xcor		{ PrintKeyword(yytext); }
ycor		{ PrintKeyword(yytext); }
heading		{ PrintKeyword(yytext); }
random		{ PrintKeyword(yytext); }

if			{ PrintKeyword(yytext); }
ifelse		{ PrintKeyword(yytext); }
repeat		{ PrintKeyword(yytext); }

black		{ PrintKeyword(yytext); }
white		{ PrintKeyword(yytext); }
orange		{ PrintKeyword(yytext); }
yellow		{ PrintKeyword(yytext); }
lime		{ PrintKeyword(yytext); }
cyan		{ PrintKeyword(yytext); }
blue		{ PrintKeyword(yytext); }
magenta		{ PrintKeyword(yytext); }
red			{ PrintKeyword(yytext); }
brown		{ PrintKeyword(yytext); }
green		{ PrintKeyword(yytext); }
turquoise	{ PrintKeyword(yytext); }
sky			{ PrintKeyword(yytext); }
violet		{ PrintKeyword(yytext); }
pink		{ PrintKeyword(yytext); }

int			{ PrintKeyword(yytext); }

([a-zA-Z][a-zA-Z0-9]*)*	{ PrintIdentifier(yytext); }

\/\/.*\n	{/* ignore comments */}

\/\*([^*]|(\*+[^*/]))*\*+\/	{/* ignore comments */}

[^ \-\*+>/<=\(\)\[\]\t\n]*	{ PrintIllegal(yytext);}
[ \t\n]		{ /* nothing! */ }

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

