%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int yylex();
int yyerror(char*);
char* newtemp();
int temp_count = 0;
%}

%union { char* sval; }
%token <sval> ID NUMBER
%token PLUS MINUS MUL DIV
%type <sval> E T F

%left PLUS MINUS
%left MUL DIV

%%

input : E '\n' { printf("Result in %s\n", $1); }
      | E      { printf("Result in %s\n", $1); }
      ;

E : E PLUS T  { char* t = newtemp(); printf("%s = %s + %s\n", t, $1, $3); $$ = t; }
  | E MINUS T { char* t = newtemp(); printf("%s = %s - %s\n", t, $1, $3); $$ = t; }
  | T         { $$ = $1; }
  ;

T : T MUL F   { char* t = newtemp(); printf("%s = %s * %s\n", t, $1, $3); $$ = t; }
  | T DIV F   { char* t = newtemp(); printf("%s = %s / %s\n", t, $1, $3); $$ = t; }
  | F         { $$ = $1; }
  ;

F : '(' E ')' { $$ = $2; }
  | ID        { $$ = $1; }
  | NUMBER    { $$ = $1; }
  ;

%%

char* newtemp() {
    char* t = (char*)malloc(10);
    sprintf(t, "t%d", temp_count++);
    return t;
}

int main() {
    printf("Enter expression: ");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}
