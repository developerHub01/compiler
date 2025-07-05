%{
#include<stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token Num NewLine

%left '+' '-'
%left '*' '/'

%%
prog: expr NewLine {printf("Result = %d\n", $1); return 0;}

expr: Num
    | '(' expr ')'  {$$=$2;}
    | expr '+' expr   {$$=$1+$3;}
    | expr '-' expr   {$$=$1-$3;}
    | expr '*' expr   {$$=$1*$3;}
    | expr '/' expr   {$$=$1/$3;}

%%

int main(){
    yyparse();
    return 0;
}
void yyerror(const char *s){
    fprintf(stderr, "Error: %s\n", s);
}