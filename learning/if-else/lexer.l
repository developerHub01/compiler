%{
#include "parser.tab.h"    
#include<string.h>
%}

%option noyywrap

%%
"if"         { return IF; }
"else"       { return ELSE; }
"else if"    { return ELSE_IF; }
[a-zA-Z]+    { yylval.string = strdup(yytext); return ID; }
[0-9]+       { yylval.num = atoi(yytext); return NUMBER; }
[<>]=?|==|!= {return RELOP; }
[(){};]       {return yytext[0]; }
[ \t\n]      {}
.            {printf("Invalid syntax: %s\n", yytext);}
%%