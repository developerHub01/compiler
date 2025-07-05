%{
#include<stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token Num NewLine

%%
prog: expr NewLine {printf("Result: %d\n", $1); return 0;}

expr: Num '*' Num {$$=$1*$3;}
%%

int main(){
    yyparse();
    return 0;
}
void yyerror(const char *s){
    fprintf(stderr, "Error: %s\n", s);
}