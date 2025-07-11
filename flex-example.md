Here are 10 problems that focus specifically on Flex (Lex) and require either complex regular expressions or demonstrate raw Flex capabilities without Bison:

---

### **Problem 1: Count Lines, Words, and Characters**
**Task**: Write a Flex program to count the number of lines, words, and characters in a file (similar to `wc` in Unix).

**Solution** (`wordcount.l`):
```lex
%{
    int chars = 0;
    int words = 0;
    int lines = 0;
%}

%%
[^\n\t ]+   { words++; chars += yyleng; }
\n          { lines++; chars++; }
.           { chars++; }
%%

int main() {
    yylex();
    printf("Lines: %d, Words: %d, Chars: %d\n", lines, words, chars);
    return 0;
}
```

**Key Points**:
- `[^\n\t ]+` matches words (any sequence not containing spaces, tabs, or newlines).
- `yyleng` gives the length of the matched token.

---

### **Problem 2: Remove Comments**
**Task**: Write a Flex program to remove all `/* ... */` and `//` comments from a C file.

**Solution** (`remove_comments.l`):
```lex
%{
    #include <stdio.h>
%}

%%
"/*"            { /* Skip multiline comments */
                 int c;
                 while ((c = yyinput()) != 0) {
                     if (c == '*' && yyinput() == '/') break;
                 }
               }
"//".*          ; // Skip single-line comments
.|\n            { ECHO; } // Echo everything else
%%

int main() {
    yylex();
    return 0;
}
```

**Key Points**:
- `yyinput()` reads the next character manually.
- `ECHO` prints the matched text.

---

### **Problem 3: Validate Email Addresses**
**Task**: Write a Flex program to check if input lines contain valid email addresses.

**Solution** (`email_validate.l`):
```lex
%{
    #include <stdio.h>
%}

%%
^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$   { printf("Valid email: %s\n", yytext); }
.|\n                                               { printf("Invalid: %s\n", yytext); }
%%

int main() {
    yylex();
    return 0;
}
```

**Regex Explanation**:
- `^[a-zA-Z0-9._%+-]+` → Local part (before `@`).
- `@[a-zA-Z0-9.-]+` → Domain.
- `\.[a-zA-Z]{2,}$` → Top-level domain (e.g., `.com`, `.org`).

---

### **Problem 4: Extract URLs**
**Task**: Write a Flex program to extract URLs from text.

**Solution** (`extract_urls.l`):
```lex
%{
    #include <stdio.h>
%}

%%
https?:\/\/[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(\/[^\s]*)?   { printf("URL: %s\n", yytext); }
.|\n                                                 ; // Ignore non-URLs
%%

int main() {
    yylex();
    return 0;
}
```

**Regex Explanation**:
- `https?` → Matches `http` or `https`.
- `:\/\/` → Escaped `://`.
- `[a-zA-Z0-9.-]+` → Domain name.
- `(\/[^\s]*)?` → Optional path.

---

### **Problem 5: Count Keywords**
**Task**: Write a Flex program to count keywords (`if`, `else`, `while`, etc.) in a C file.

**Solution** (`count_keywords.l`):
```lex
%{
    #include <stdio.h>
    int if_count = 0, else_count = 0, while_count = 0;
%}

%%
"if"      { if_count++; }
"else"    { else_count++; }
"while"   { while_count++; }
.|\n      ; // Ignore others
%%

int main() {
    yylex();
    printf("if: %d, else: %d, while: %d\n", if_count, else_count, while_count);
    return 0;
}
```

---

### **Problem 6: Convert Case**
**Task**: Write a Flex program to convert uppercase letters to lowercase and vice versa.

**Solution** (`convert_case.l`):
```lex
%%
[a-z]     { printf("%c", yytext[0] - 32); } // Lower to upper
[A-Z]     { printf("%c", yytext[0] + 32); } // Upper to lower
.|\n      { ECHO; } // Leave others unchanged
%%

int main() {
    yylex();
    return 0;
}
```

---

### **Problem 7: Count Indentation Levels**
**Task**: Write a Flex program to count Python-style indentation levels (tabs/spaces at line start).

**Solution** (`count_indent.l`):
```lex
%{
    int indent_level = 0;
%}

%%
^[ \t]+   { printf("Indent level: %d\n", yyleng); }
.|\n      ; // Ignore other content
%%

int main() {
    yylex();
    return 0;
}
```

---

### **Problem 8: Validate Numbers**
**Task**: Write a Flex program to validate integers, floats, and hex numbers.

**Solution** (`validate_numbers.l`):
```lex
%{
    #include <stdio.h>
%}

%%
[0-9]+          { printf("Integer: %s\n", yytext); }
[0-9]+\.[0-9]+  { printf("Float: %s\n", yytext); }
0x[0-9a-fA-F]+  { printf("Hex: %s\n", yytext); }
.|\n            ; // Ignore others
%%

int main() {
    yylex();
    return 0;
}
```

---

### **Problem 9: Strip Whitespace**
**Task**: Write a Flex program to remove extra whitespace (collapse multiple spaces/tabs into one).

**Solution** (`strip_whitespace.l`):
```lex
%%
[ \t]+        { printf(" "); } // Replace multiple spaces/tabs with one space
.|\n          { ECHO; }
%%

int main() {
    yylex();
    return 0;
}
```

---

### **Problem 10: Tokenize CSV**
**Task**: Write a Flex program to tokenize CSV fields (split on commas, handle quoted fields).

**Solution** (`tokenize_csv.l`):
```lex
%{
    #include <stdio.h>
%}

%%
\"[^\"]*\"   { printf("Quoted field: %s\n", yytext); } // Quoted fields
[^,\n]+      { printf("Field: %s\n", yytext); } // Unquoted fields
,|\n         { printf("Delimiter\n"); } // Comma or newline
%%

int main() {
    yylex();
    return 0;
}
```

---

### **Key Takeaways**:
1. **Pure Flex Problems**: These examples don’t require Bison and focus on regex/lexical analysis.
2. **Advanced Regex**: Email/URL validation uses complex regex.
3. **State Manipulation**: Problems like comment removal use `yyinput()` for manual control.
4. **Real-World Use Cases**: CSV parsing, keyword counting, etc.

**Compile & Run**:
```bash
flex filename.l
gcc lex.yy.c -o lexer -lfl
./lexer < input.txt
``` 

Let me know if you'd like more problems in a specific area!