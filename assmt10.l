%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

[ \t]+                  { }
[0-9]+                  { yylval.sval = strdup(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.sval = strdup(yytext); return ID; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MUL; }
"/"                     { return DIV; }
"("                     { return '('; }
")"                     { return ')'; }
\n                      { return '\n'; }  /* Critical: consume newline */
.                       { return yytext[0]; }

%%

int yywrap() { return 1; }
