
%{

/* Turtle Compiler lex file
   by Pete Myers and Steven Reeves
   OIT Portland Fall 2008
   Flex C++ version Jan 2017

   Assign 3
*/

#include <stdio.h>
#include <stdlib.h>
#include "tree.h"
#include "TurtleYacc.h"
#include "symtable.h"

%}

%option noyywrap

%%

[0-9]+			{ yylval.value = atoi(yytext); return NUMBER; }

black			{yylval.colorType = BLACK; return COLOR_NAME;}
white			{yylval.colorType = WHITE; return COLOR_NAME;}
orange			{yylval.colorType = ORANGE; return COLOR_NAME;}
yellow			{yylval.colorType = YELLOW; return COLOR_NAME;}
lime			{yylval.colorType = LIME; return COLOR_NAME;}
cyan			{yylval.colorType = CYAN; return COLOR_NAME;}
blue			{yylval.colorType = BLUE; return COLOR_NAME;}
magenta			{yylval.colorType = MAGENTA; return COLOR_NAME;}
red				{yylval.colorType = RED; return COLOR_NAME;}
brown			{yylval.colorType = BROWN; return COLOR_NAME;}
green			{yylval.colorType = GREEN; return COLOR_NAME;}
turquoise		{yylval.colorType = TURQUOISE; return COLOR_NAME;}
sky				{yylval.colorType = SKY; return COLOR_NAME;}
violet			{yylval.colorType = VIOLET; return COLOR_NAME;}
pink			{yylval.colorType = PINK; return COLOR_NAME;}

"+"			{ return yytext[0]; }
"-"			{ return yytext[0]; }
"*"			{ return yytext[0]; }
"/"			{ return yytext[0]; }
"="			{ return yytext[0]; }
">"			{ return yytext[0]; }
"<"			{ return yytext[0]; }
"("			{ return yytext[0]; }
")"			{ return yytext[0]; }
"["			{ return yytext[0]; }
"]"			{ return yytext[0]; }


home		{ return HOME; }
fd			{ return FD; }
setxy		{ return SETXY; }
setc		{ return SETC; }
if			{ return IF; }
ifelse		{ return IFELSE; }
repeat		{ return REPEAT; }
random		{ return RANDOM; }
bk			{ return BK; }
rt			{ return RT; }
lt			{ return LT; }
setx		{ return SETX; }
sety		{ return SETY; }
seth		{ return SETH; }
pd			{ return PD; }
pu			{ return PU; }
ht			{ return HT; }
st			{ return ST; }
xcor		{ return XCOR; }
ycor		{ return YCOR; }
heading		{ return HEADING; }
color		{ return COLOR; }

.			{ }
\n			{ yylineno++; }

%%

void yyerror(const char * msg)
{
	fprintf(stderr, "ERROR! Line #%d: %s at %s\n", yylineno, msg, yytext);
}

