%{
#include<stdio.h>
%}

START_WITH_P_END_WITH_Q ^p.*q$

%%
{START_WITH_P_END_WITH_Q}   {
    printf("Valid\n");
}

.* {
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