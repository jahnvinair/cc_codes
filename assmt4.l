%{
#include <stdio.h>
#include <ctype.h>
int upper = 0, lower = 0;
%}

%%

[a-z]   { printf("%c", toupper(yytext[0])); lower++; }
[A-Z]   { printf("%c", tolower(yytext[0])); upper++; }
.       { printf("%s", yytext); }

%%

int yywrap() { return 1; }

int main() {
    printf("Enter text (Ctrl+D to end):\n");
    yylex();
    printf("\nUppercase letters: %d\n", upper);
    printf("Lowercase letters: %d\n", lower);
    return 0;
}
