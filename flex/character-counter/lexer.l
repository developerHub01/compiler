%{
#include<stdio.h>

int count = 0;
%}

%%

[a-zA-Z]    { count++; }
\n          { printf("count = %d\n", count); count=0; }

%%

int yywrap(){
    return 1;
}
int main(){
    yylex();
    return 0;
}