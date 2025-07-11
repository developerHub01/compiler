%{
#include "parser.tab.h"    
#include<string.h>
%}

%option noyywrap

%%
"while"      { return WHILE; }
[a-zA-Z]+    { yylval.string = strdup(yytext); return ID; }
[0-9]+       { yylval.num = atoi(yytext); return NUMBER; }
[<>]=?|==|!= { return RELOP; }
[(){};]       {return yytext[0]; }
[ \t\n]      {}
.            {printf("Invalid syntax: %s\n", yytext);}
%%