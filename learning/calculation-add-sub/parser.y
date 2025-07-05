%{
#include<stdio.h>
int yylex();
void yyerror(const char *s);    
%}

%token NewLine Num

%%
prog: expr NewLine {printf("Result: %d\n", $1);}

expr: Num '+' Num '-' Num {$$=$1+$3-$5;}

%%

int main(){
    yyparse();
    return 0;
}
void yyerror(const char *s){
    fprintf(stderr, "Error: %s\n", s);
}