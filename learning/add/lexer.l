%{
#include "parser.tab.h"    
%}

%option noyywrap

%%
[0-9]+      {
        yylval = atoi(yytext);
        return Num;
}
"+"     {return '+';}
\n      {return NewLine;}
[ \t]   {}
.       {printf("invalid: %s\n", yytext);}

%%