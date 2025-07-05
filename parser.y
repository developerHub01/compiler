%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token Num Newline 

%%
prog: expr Newline {printf("Result: %d\n", $1); return 0;}
    ;
expr: Num '+' Num '+' Num {$$=$1+$3+$5;};
%%


int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return;
}