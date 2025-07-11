%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token Num NewLine

%left '+' '-'
%left '*' '/'
%left UMINUS

%%
prog: expr NewLine {printf("Result = %d\n", $1); return 0;}

expr: Num
    | '(' expr ')'  {$$=$2;}
    | expr '+' expr   {$$=$1+$3;}
    | expr '-' expr   {$$=$1-$3;}
    | expr '*' expr   {$$=$1*$3;}
    | expr '/' expr   {
        if($3 == 0){
            yyerror("Divide by zero");
            exit(1);
        }
        $$=$1/$3;
    }
    | '-' expr %prec UMINUS {$$=-$2;}

%%

int main(){
    yyparse();
    return 0;
}
void yyerror(const char *s){
    fprintf(stderr, "Error: %s\n", s);
}