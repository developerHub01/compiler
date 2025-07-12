%{
/*
Constraints:
    Matches valid IPv4 addresses — 4 octets separated by dots .
    Each octet is a number from 0 to 255 (no leading zeros unless the octet is exactly zero)
    No extra characters or spaces allowed

    Examples:
        Valid: 192.168.1.1, 0.0.0.0, 255.255.255.255
        Invalid: 256.100.1.1 (octet > 255), 192.168.01.1 (leading zero), 192.168.1. (missing octet)
*/

#include<stdio.h>    
%}

OCTET       (25[0-5]|1[0-9]{2}|2[0-5][0-5]|[1-2]55|[1-9][0-9]?|[0-9])
IPV4        {OCTET}\.{OCTET}\.{OCTET}\.{OCTET}

%%
{IPV4} {
    printf("Valid IPv4 Address: %s\n", yytext);
}

.+ {
    printf("Invalid input: %s\n", yytext);
}

%%

int yywrap(){
    return 1;
}
int main(){
    yylex();
    return 0;
}