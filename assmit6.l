#include <stdio.h>
int com_count = 0;
int org_count = 0;
int edu_count = 0;
%}

%%


.*\.com$      { com_count++; }
.*\.org$      { org_count++; }
.*\.edu$      { edu_count++; }


.*\n          { }
.             { }

%%

int main(int argc, char* argv[]) {
    // If a filename is provided, read from it
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror(argv[1]);
            return 1;
        }
    }

    yylex(); // Start the lexical analysis

    printf("Lines ending with '.com': %d\n", com_count);
    printf("Lines ending with '.org': %d\n", org_count);
    printf("Lines ending with '.edu': %d\n", edu_count);

    return 0;
}

int yywrap() {
    return 1;
}
