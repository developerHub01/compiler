## Example 41: Complex Expressions with Variables

**Problem**: Handle complex arithmetic expressions with variables and assignment.

```bison
/* expr_var.y */
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

struct symbol {
    char *name;
    int value;
    struct symbol *next;
} *symtab = NULL;

struct symbol *lookup(char *name) {
    struct symbol *s;
    for (s = symtab; s; s = s->next)
        if (strcmp(s->name, name) == 0) return s;
    s = malloc(sizeof(struct symbol));
    s->name = strdup(name);
    s->value = 0;
    s->next = symtab;
    symtab = s;
    return s;
}
%}

%union {
    int num;
    char *str;
}

%token <num> NUMBER
%token <str> ID
%token ASSIGN '=' PRINT

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

program:    /* empty */
           | program stmt
;

stmt:       expr ';'               { printf("%d\n", $1); }
           | ID ASSIGN expr ';'    { lookup($1)->value = $3; }
           | PRINT expr ';'        { printf("= %d\n", $2); }
;

expr:       NUMBER
           | ID                    { $$ = lookup($1)->value; }
           | expr '+' expr         { $$ = $1 + $3; }
           | expr '-' expr         { $$ = $1 - $3; }
           | expr '*' expr         { $$ = $1 * $3; }
           | expr '/' expr         { if ($3 == 0) yyerror("divide by zero");
                                    else $$ = $1 / $3; }
           | '(' expr ')'          { $$ = $2; }
           | '-' expr %prec UMINUS { $$ = -$2; }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
```

```lex
/* expr_var.l */
%{
#include "expr_var.tab.h"
#include <stdlib.h>
%}

%option noyywrap

%%

[0-9]+      { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z]+   { yylval.str = strdup(yytext); return ID; }
"="         { return ASSIGN; }
"print"     { return PRINT; }
[-+*/()]    { return yytext[0]; }
[ \t\n]     ;
.           { yyerror("Invalid character"); }

%%
```

## Example 42: If-Else with Blocks

**Problem**: Parse if-else statements with block statements.

```bison
/* ifelse_block.y */
%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token IF ELSE NUMBER ID ';' '{' '}' '(' ')' RELOP

%%

program:    /* empty */
           | program stmt
;

stmt:       expr ';'
           | IF '(' cond ')' block
           | IF '(' cond ')' block ELSE block
;

block:      '{' stmts '}'
           | stmt
;

stmts:      /* empty */
           | stmts stmt
;

expr:       NUMBER
           | ID
;

cond:       expr RELOP expr
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
```

```lex
/* ifelse_block.l */
%{
#include "ifelse_block.tab.h"
%}

%option noyywrap

%%

"if"        { return IF; }
"else"      { return ELSE; }
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z]+   { yylval = strdup(yytext); return ID; }
[<>]=?|==   { return RELOP; }
[();{}]     { return yytext[0]; }
[ \t\n]     ;
.           { yyerror("Invalid character"); }

%%
```

## Example 43: While Loops with Break/Continue

**Problem**: Parse while loops with break and continue statements.

```bison
/* while_break.y */
%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token WHILE BREAK CONTINUE NUMBER ID ';' '{' '}' '(' ')' RELOP

%%

program:    /* empty */
           | program stmt
;

stmt:       expr ';'
           | WHILE '(' cond ')' block
           | BREAK ';'
           | CONTINUE ';'
;

block:      '{' stmts '}'
           | stmt
;

stmts:      /* empty */
           | stmts stmt
;

expr:       NUMBER
           | ID
;

cond:       expr RELOP expr
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
```

```lex
/* while_break.l */
%{
#include "while_break.tab.h"
%}

%option noyywrap

%%

"while"     { return WHILE; }
"break"     { return BREAK; }
"continue"  { return CONTINUE; }
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z]+   { yylval = strdup(yytext); return ID; }
[<>]=?|==   { return RELOP; }
[();{}]     { return yytext[0]; }
[ \t\n]     ;
.           { yyerror("Invalid character"); }

%%
```

## Example 44: For Loops

**Problem**: Parse for loops with initialization, condition, and increment.

```bison
/* for_loop.y */
%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token FOR NUMBER ID ';' '{' '}' '(' ')' RELOP INC DEC '='

%%

program:    /* empty */
           | program stmt
;

stmt:       expr ';'
           | FOR '(' expr ';' cond ';' expr ')' block
;

block:      '{' stmts '}'
           | stmt
;

stmts:      /* empty */
           | stmts stmt
;

expr:       NUMBER
           | ID
           | ID '=' expr
           | ID INC
           | ID DEC
;

cond:       expr RELOP expr
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
```

```lex
/* for_loop.l */
%{
#include "for_loop.tab.h"
%}

%option noyywrap

%%

"for"       { return FOR; }
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z]+   { yylval = strdup(yytext); return ID; }
"++"        { return INC; }
"--"        { return DEC; }
[<>]=?|==   { return RELOP; }
[();={}]    { return yytext[0]; }
[ \t\n]     ;
.           { yyerror("Invalid character"); }

%%
```

## Example 45: Switch-Case Statements

**Problem**: Parse switch-case statements with break.

```bison
/* switch_case.y */
%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token SWITCH CASE DEFAULT NUMBER ID ';' '{' '}' ':' BREAK

%%

program:    /* empty */
           | program stmt
;

stmt:       expr ';'
           | SWITCH '(' expr ')' '{' cases '}'
           | BREAK ';'
;

cases:      /* empty */
           | cases case
;

case:       CASE expr ':' stmts
           | DEFAULT ':' stmts
;

stmts:      /* empty */
           | stmts stmt
;

expr:       NUMBER
           | ID
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
```

```lex
/* switch_case.l */
%{
#include "switch_case.tab.h"
%}

%option noyywrap

%%

"switch"    { return SWITCH; }
"case"      { return CASE; }
"default"   { return DEFAULT; }
"break"     { return BREAK; }
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z]+   { yylval = strdup(yytext); return ID; }
[():{}]     { return yytext[0]; }
[ \t\n]     ;
.           { yyerror("Invalid character"); }

%%
```

## Example 46: Function Calls

**Problem**: Parse function calls with multiple arguments.

```bison
/* func_call.y */
%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token ID NUMBER ';' '(' ')' ',' PRINT

%%

program:    /* empty */
           | program stmt
;

stmt:       expr ';'
           | PRINT expr ';'    { printf("= %d\n", $2); }
;

expr:       NUMBER
           | ID '(' args ')'
;

args:       /* empty */
           | expr
           | args ',' expr
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
```

```lex
/* func_call.l */
%{
#include "func_call.tab.h"
%}

%option noyywrap

%%

"print"     { return PRINT; }
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z]+   { yylval = strdup(yytext); return ID; }
[(),]       { return yytext[0]; }
[ \t\n]     ;
.           { yyerror("Invalid character"); }

%%
```

## Example 47: Arrays

**Problem**: Parse array declarations and accesses.

```bison
/* arrays.y */
%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token INT ID NUMBER ';' '[' ']' '=' '{' '}' ','

%%

program:    /* empty */
           | program decl
           | program stmt
;

decl:       INT ID ';'
           | INT ID '[' NUMBER ']' ';'
           | INT ID '=' '{' init_list '}' ';'
;

init_list:  NUMBER
           | init_list ',' NUMBER
;

stmt:       expr ';'
;

expr:       NUMBER
           | ID
           | ID '[' expr ']'
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
```

```lex
/* arrays.l */
%{
#include "arrays.tab.h"
%}

%option noyywrap

%%

"int"       { return INT; }
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z]+   { yylval = strdup(yytext); return ID; }
[][;={},]   { return yytext[0]; }
[ \t\n]     ;
.           { yyerror("Invalid character"); }

%%
```

## Example 48: Pointers

**Problem**: Parse pointer declarations and operations.

```bison
/* pointers.y */
%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token INT ID NUMBER ';' '*' '&' '=' PRINT

%%

program:    /* empty */
           | program stmt
;

stmt:       expr ';'
           | PRINT expr ';'    { printf("= %d\n", $2); }
;

expr:       NUMBER
           | ID
           | '*' ID
           | '&' ID
           | ID '=' expr
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
```

```lex
/* pointers.l */
%{
#include "pointers.tab.h"
%}

%option noyywrap

%%

"int"       { return INT; }
"print"     { return PRINT; }
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z]+   { yylval = strdup(yytext); return ID; }
[*&;=]      { return yytext[0]; }
[ \t\n]     ;
.           { yyerror("Invalid character"); }

%%
```

## Example 49: Structures

**Problem**: Parse structure declarations and member access.

```bison
/* structs.y */
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex();
void yyerror(const char *s);
%}

%token STRUCT ID NUMBER ';' '{' '}' '.' '='

%%

program:    /* empty */
           | program decl
           | program stmt
;

decl:       STRUCT ID '{' members '}' ';'
           | ID ID ';'
;

members:    /* empty */
           | members member
;

member:     ID ';'
;

stmt:       expr ';'
;

expr:       NUMBER
           | ID
           | ID '.' ID
           | ID '=' expr
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
```

```lex
/* structs.l */
%{
#include "structs.tab.h"
%}

%option noyywrap

%%

"struct"    { return STRUCT; }
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z]+   { yylval = strdup(yytext); return ID; }
[.;={}]     { return yytext[0]; }
[ \t\n]     ;
.           { yyerror("Invalid character"); }

%%
```

## Example 50: Typedef

**Problem**: Parse typedef declarations.

```bison
/* typedef.y */
%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token TYPEDEF INT ID ';' '{' '}' ',' '*' '[' ']'

%%

program:    /* empty */
           | program decl
;

decl:       type_spec ID ';'
           | TYPEDEF type_spec ID ';'
;

type_spec:  INT
           | STRUCT ID '{' members '}'
           | type_spec '*'
           | type_spec '[' NUMBER ']'
;

members:    /* empty */
           | members member
;

member:     type_spec ID ';'
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
```

```lex
/* typedef.l */
%{
#include "typedef.tab.h"
%}

%option noyywrap

%%

"typedef"   { return TYPEDEF; }
"int"       { return INT; }
"struct"    { return STRUCT; }
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z]+   { yylval = strdup(yytext); return ID; }
[;,*={}[]]  { return yytext[0]; }
[ \t\n]     ;
.           { yyerror("Invalid character"); }

%%
```

These 10 additional examples cover more advanced language features including variables, control structures, functions, arrays, pointers, structures, and typedefs. Each example includes both the lexer and parser files with complete implementations.