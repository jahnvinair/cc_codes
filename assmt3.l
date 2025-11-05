%{
#include <stdio.h>
int count = 0;
%}

%%

[A][a-zA-Z]*    { count++; ECHO; printf(" "); }
.|\n            { /* ignore */ }

%%

int yywrap() { return 1; }

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) { perror("File open"); return 1; }
        yyin = file;
    }
    yylex();
    printf("\nNumber of words starting with 'A': %d\n", count);
    return 0;
}
