%{
#include<stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token ID NUMBER RELOP WHILE '(' ')' '{' '}' ';'

%union {
    char *string;
    int num;
}

%%

stmt:       | expr ';'
            | WHILE '(' cond ')' '{' stmt '}' { printf("Valid"); return 0; }

            FOR'('INT $expression ';' condition ';' condition ')' '{' stmt '}' 
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