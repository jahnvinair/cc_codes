%{
#include <stdio.h>
#include <stdlib.h>
%}

%%

[0-9]+  { 
            int num = atoi(yytext);
            printf("%s (decimal) = %X (hexadecimal)\n", yytext, num);
        }
.|\n    { /* ignore */ }

%%

int yywrap() { return 1; }

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }
    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Cannot open file");
        return 1;
    }
    yyin = file;
    yylex();
    fclose(file);
    return 0;
}
