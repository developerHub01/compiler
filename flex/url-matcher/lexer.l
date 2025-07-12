%{
/*
Constraints:
✅ Must start with http:// or https://
✅ Then www. is optional
✅ Then valid domain (same as domain rule: no underscore, no hyphen at start/end of any part, TLD must be 2–6 letters)
✅ After domain, you can have:
    nothing (https://www.google.com)
    or / with path: letters, digits, dash, underscore, dots, slashes — e.g. /path/to/resource
    ✅ Query strings (?param=value) optional — you can skip this if it feels too much!
*/
#include<stdio.h>
%}

HTTP_TYPE       (http:\/\/|https:\/\/)
OPTIONAL_WWW    (www\.)?
DOMAIN_PART     ([a-zA-Z]([a-zA-Z0-9-]*[a-zA-Z])*\.)+
TLD             [a-zA-Z]{2,6}
PARAM           (\/[a-zA-Z0-9._-]*)?
QUERY_PARAM     (\?[a-zA-Z_-][a-zA-Z0-9_-]*(=[a-zA-Z0-9_-]*)?)?
SUB_ROUTE       ((({PARAM}{QUERY_PARAM})|({QUERY_PARAM}{PARAM}))*)?




%%

{HTTP_TYPE}{OPTIONAL_WWW}{DOMAIN_PART}{TLD}{SUB_ROUTE}     {
    printf("Valid URL %s\n", yytext);
}

.+          {
    printf("Invalid URL %s\n", yytext);
}

%%

int yywrap(){
    return 1;
}
int main(){
    yylex();
    return 0;
}