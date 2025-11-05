%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror(const char*);
void push(int);
int pop();
int stack[100];
int top = -1;
%}

%union { int n; }
%token <n> oprnd
%type <n> E

%%

input : E '\n'  { printf("Result: %d\n", pop()); }
      | E       { printf("Result: %d\n", pop()); }
      ;

E : E E '+'  { int a = pop(); int b = pop(); push(b + a); }
  | E E '-'  { int a = pop(); int b = pop(); push(b - a); }
  | E E '*'  { int a = pop(); int b = pop(); push(b * a); }
  | E E '/'  { int a = pop(); int b = pop(); if (a == 0) yyerror("div0"); else push(b / a); }
  | oprnd    { push($1); }
  ;

%%

void push(int val) { stack[++top] = val; }
int pop() { return stack[top--]; }

int yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}

int main() {
    printf("Enter postfix (end with Enter):\n");
    yyparse();
    return 0;
}

