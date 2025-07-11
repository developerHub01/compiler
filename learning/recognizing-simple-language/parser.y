%{
#include<stdio.h>
int yylex();
void yyerror(const char *s);    
%}

%token INT 
%token <string> ID

%union {
    char *string;
}

%%

program: | program declaration
;
declaration: INT ID ';' {
    printf("Declared %s as int\n", $2);
}

%%

int main(){
    yyparse();
    return 0;
}

void yyerror(const char *s){
    fprintf(stderr, "Error %s\n", s);
    return;
}
