%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define MAXSTACK 100
int stack[MAXSTACK];
int top = -1;

void push(int val) {
    if (top == MAXSTACK - 1) {
        printf("Error: Stack overflow\n");
        exit(1);
    }
    stack[++top] = val;
}

int pop() {
    if (top == -1) {
        printf("Error: Stack underflow\n");
        exit(1);
    }
    return stack[top--];
}
%}

%%

[0-9]+      { push(atoi(yytext)); }
"+"         { int a = pop(); int b = pop(); push(b + a); }
"-"         { int a = pop(); int b = pop(); push(b - a); }
"*"         { int a = pop(); int b = pop(); push(b * a); }
"/"         { int a = pop(); int b = pop(); if (a == 0) { printf("Error: Division by zero\n"); exit(1); } push(b / a); }
[ \t]       { /* ignore whitespace */ }
\n          { printf("Result: %d\n", pop()); }
.           { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() { return 1; }

int main() {
    printf("Enter postfix expression (e.g., 2 3 +):\n");
    yylex();
    return 0;
}
