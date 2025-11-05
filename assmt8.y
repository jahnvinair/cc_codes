%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror(char*);
%}

%union { double dval; }
%token <dval> NUMBER
%type <dval> expr
%left '+' '-'
%left '*' '/'

%%

lines : lines expr '\n' { printf("%.2f\n", $2); }
      | lines '\n'
      | /* empty */
      | error '\n' { yyerrok; }
      ;

expr  : expr '+' expr   { $$ = $1 + $3; }
      | expr '-' expr   { $$ = $1 - $3; }
      | expr '*' expr   { $$ = $1 * $3; }
      | expr '/' expr   { if($3==0) yyerror("div0"); else $$ = $1 / $3; }
      | '(' expr ')'    { $$ = $2; }
      | NUMBER          { $$ = $1; }
      ;

%%

int yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}

int main() {
    printf("Enter expressions (Ctrl+D to exit):\n");
    yyparse();
    return 0;
}
