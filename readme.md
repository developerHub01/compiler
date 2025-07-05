## Run a program: 

```
bison -d parser.y
flex lexer.l
gcc lex.yy.c parser.tab.c
a
```

- Parser.y

```c
%{
  // C code - header part (variable, include etc.)
%}

%token TOKEN_NAME // token gula define

%%
// Grammar rules
%%
int main() {...} // C code - helper function
```