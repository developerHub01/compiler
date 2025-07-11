%{
#include<stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token ID
%token <string> NUMBER RELOP IF ELSE_IF ELSE '(' ')' '{' '}' ';'

%union {
    char *string;
    int num;
}

%%

stmt:       | expr ';'
            | IF '(' cond ')' '{' stmt '}' else_stmt { printf("Valid"); return 0; }
;

else_stmt:  | ELSE_IF '(' cond ')' '{' stmt '}' else_stmt
            | ELSE '{' stmt '}'
;
expr:       ID | NUMBER
;
cond:       expr | expr RELOP expr
;

%%

int main(){
    yyparse();
    return 0;
}
void yyerror(const char *s){
    fprintf(stderr, "Error %s\n", s);
}