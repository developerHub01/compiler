%{
#include<stdio.h>
#include<ctype.h>

int is_upper = -1;
%}

%%
[uU][pP]        {
    if(is_upper != -1)
        printf("Invalid\n");
    else is_upper = 1;
}
[lL][oO][wW]    {
    if(is_upper != -1) 
        printf("Invalid\n");
    else is_upper = 0;
}


[a-zA-Z]        {
    if(is_upper == -1) {
        return printf("Invalid\n");
    }

    char ch = yytext[0];
    if(is_upper == 1){
        ch = toupper(ch);
    }else if(is_upper == 0){
        ch = tolower(ch);
    }
    printf("%c", ch);
}

\n              {
    printf("\n=============\n");
    is_upper = -1;
}

%%

int yywrap(){
    return 1;
}

int main(){
    yylex();
    return 0;
}