%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+      { yylval.n = atoi(yytext); return oprnd; }
[+\-*/]     { return yytext[0]; }
[ \t]       { /* ignore whitespace */ }
\n          { return 0; }  /* End of input */
.           { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() { return 1; }

