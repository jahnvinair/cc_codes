%{
#include "y.tab.h"
%}

%%

for         { return FOR; }
"("         { return '('; }
")"         { return ')'; }
"{"         { return '{'; }
"}"         { return '}'; }
";"         { return ';'; }
","         { return ','; }
"="         { return '='; }
"<"         { return '<'; }
">"         { return '>'; }
"<="        { return LE; }
">="        { return GE; }
"=="        { return EQ; }
"!="        { return NE; }
"++"        { return INC; }
"--"        { return DEC; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; }
[0-9]+      { return NUM; }
[ \t\n]     { }
.           { return yytext[0]; }

%%

int yywrap() { return 1; }
