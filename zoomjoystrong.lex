%{

#include <stdio.h>
#include "project2parser.tab.h"

%}

%option noyywrap

%%

[0-9]+     	{
			yylval.ival = atoi(yytext);
			return INT;
		}
[0-9]*\.[0-9]+	{
			yylval.fval = atof(yytext);
			return FLOAT;
		}
end     	{return END;}
\;     		{return END_STATEMENT;}
line     	{return LINE;}
point     	{return POINT;}
circle     	{return CIRCLE;}
set_color     	{return SET_COLOR;}
circle     	{return CIRCLE;}
rectangle     	{return RECTANGLE;}
[\t| |\n]	;
.		{printf("invalid");}

%%
