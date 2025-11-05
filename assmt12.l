%{
#include <stdio.h>
%}

%%

[a-zA-Z0-9_.]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,6} { printf("Valid Email Address: %s\n", yytext); }
\n                                          { /* ignore newline or process next */ }
.                                           { printf("Invalid Email Address: %s\n", yytext); }

%%

int yywrap() { return 1; }

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) { perror("File error"); return 1; }
    } else {
        printf("Enter emails (Ctrl+D to end):\n");
    }
    yylex();
    return 0;
}
