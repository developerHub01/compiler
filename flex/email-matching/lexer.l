%{
#include<stdio.h>
/*
✅ Constraints:
    Local part:
        Starts with a letter.
        Can have letters, digits, dot (.), underscore (_), dash (-).
        Length: min 3 characters before @.
    Domain:
        Only letters and digits, can have hyphens.
        At least 2 parts separated by dot (.).
        TLD: 2–6 letters.
*/

%}

LOCAL_PART  [a-zA-Z][a-zA-Z0-9._-]{2,}
DOMAIN_PART [a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,6})

%%

{LOCAL_PART}@{DOMAIN_PART} {
    printf("Valid Email: %s\n", yytext);
}

.+       {
    printf("Invalid Email: %s\n", yytext);
}

%%

int yywrap(){
    return 1;
}
int main(){
    yylex();
    return 0;
}