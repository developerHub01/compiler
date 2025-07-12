%{
#include<stdio.h>
%}

START_WITH_END_AND_ATLEAST_ONE_ALPHABET ^end.*[a-zA-Z]+.*

%%

{START_WITH_END_AND_ATLEAST_ONE_ALPHABET} {
    printf("Valid\n");
}

.*       {
    printf("Invalid\n");
}

%%


int yywrap(){
    return 1;
}
int main(){
    yylex();
    return 0;
}