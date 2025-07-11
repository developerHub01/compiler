%{
#include "parser.tab.h"
#include <string.h>
%}

%option noyywrap

%%
"int"       { return INT; }
[a-zA-Z]+   { yylval.string = strdup(yytext); return ID; }
";"         { return ';'; }
[ \t\n]     {}
.           { printf("Invalid character: ", yytext); }

%%