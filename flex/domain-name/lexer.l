%{
#include<stdio.h>

/*
🏷️ Problem 2: Domain Name Matcher
✅ Constraints:
    Optional www. at the start.
    Domain parts separated by dots (.).
    Each domain part: letters, digits, hyphens only (-).
    Domain must have at least two parts (like example.com).
    The last part (TLD) must be only letters, length 2 to 6.
    No underscores or other special chars allowed.

🧩 Example Valid Domains:
www.google.com
mail.example.org
example.co.uk
sub.domain.net
my-site.io
localhost.localdomain

❌ Example Invalid Domains:
www.-google.com      # domain part starts with hyphen
example.123          # TLD is digits
example_domain.com   # underscore not allowed
example              # only one part, no TLD
example.corporate123 # TLD contains digits
*/

%}

OPTIONAL_WWW        (www\.)?
DOMAIN_PART         ([a-zA-Z][a-zA-Z0-9-]*\.)+
TLD                 [a-zA-Z]{2,6}

%%
{OPTIONAL_WWW}{DOMAIN_PART}{TLD}    {
    printf("Domain: %s\n", yytext);
}

.+ {
    printf("Invalid Domain: %s\n", yytext);
}
%%

int yywrap(){
    return 1;
}

int main(){
    yylex();
    return 0;
}