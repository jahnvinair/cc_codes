%{
#include <stdio.h>
#include <string.h>

int comment_count = 0, keyword_count = 0, identifier_count = 0;
int word_count = 0, line_count = 0, space_count = 0;

char *keywords[] = {"int", "float", "char", "double", "if", "else", "while", "for", 
                    "do", "return", "void", "static", "struct", "break", "continue"};
int n_keywords = 15;

int is_keyword(char *word) {
    for (int i = 0; i < n_keywords; i++) {
        if (strcmp(keywords[i], word) == 0) return 1;
    }
    return 0;
}
%}

%%

"//".*                          { comment_count++; }
"/*"([^*]|(\*+[^*/]))*\*+"/"   { comment_count++; }
[ \t]+                          { space_count += yyleng; }
\n                              { line_count++; }
[a-zA-Z_][a-zA-Z0-9_]*           { 
                                    word_count++;
                                    if (is_keyword(yytext)) keyword_count++;
                                    else identifier_count++;
                                }
.                               { /* ignore */ }

%%

int yywrap() { return 1; }

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }
    FILE *fp = fopen(argv[1], "r");
    if (!fp) {
        perror("File open failed");
        return 1;
    }
    yyin = fp;
    yylex();
    fclose(fp);

    printf("Comments: %d\n", comment_count);
    printf("Keywords: %d\n", keyword_count);
    printf("Identifiers: %d\n", identifier_count);
    printf("Words: %d\n", word_count);
    printf("Lines: %d\n", line_count);
    printf("Spaces: %d\n", space_count);
    return 0;
}
