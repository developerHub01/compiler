%{
#include<stdio.h>
%}

START_WITH_END_AND_2_TO_4_CHARACTERS    ^end.{2,4}$

%%
{START_WITH_END_AND_2_TO_4_CHARACTERS}  {
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