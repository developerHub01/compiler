%{
#include<stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token NewLine Num

%%

prog: expr NewLine {printf("Result: %d\n", $1);}

expr: Num
    | expr '*' expr {$$=$1*$3}
    | expr '+' expr {$$=$1+$3}
    | expr '/' expr {$$=$1/$3}
    | expr '-' expr {$$=$1-$3}

%%


int main(){
    yyparse();
    return 0;
}
void yyerror(const char *s){
    printf("Error :%s\n", s);
}