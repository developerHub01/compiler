%{
#include<stdio.h>    
%}

%%

-?[0-9]+          {printf("INT %s\n", yytext);}
-?[0-9]*\.[0-9]+  {printf("FLOAT %s\n", yytext);}  

.                 {}
%%

int yywrap(){
    return 1;
}
int main(){
    yylex();
    return 0;
}