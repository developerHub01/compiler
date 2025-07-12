%{
#include<stdio.h>    
int total = 0;
char current_operator = '+';
%}

%%

[0-9]+      { 
    int number = atoi(yytext);
    if(current_operator == '+'){
        total += number;
    }else {
        total -= number;
    }
}

[+-]        {
    current_operator = yytext[0];
}

\n      {
    printf("result = %d\n", total);
    current_operator = '+';
    total = 0;
}

.        {}

%%

int yywrap(){
    return 1;
}
int main(){
    yylex();
    return 0;
}