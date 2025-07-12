%{
#include<stdio.h>

int number_count = 0, word_count = 0;
%}

%%

[0-9]+      { number_count++; }
[a-zA-Z]+   { word_count++; }


\n          {
        printf("\nnumber count = %d\n", number_count);
        printf("word count = %d\n", word_count);
        number_count = 0;
        word_count = 0;
}
%%

int yywrap(){
    return 1;
}
int main(){
    yylex();
    return 0;
}