%{
#include <stdio.h>
int yylex();
int yyerror(char*);
%}

%token FOR ID NUM INC DEC LE GE EQ NE

%%

S : FOR '(' init ';' cond ';' incr ')' '{' body '}' 
    { printf("Valid FOR loop syntax\n"); }
  ;

init : ID '=' NUM
     | /* empty */
     ;

cond : ID '<' NUM
     | ID '>' NUM
     | ID LE NUM
     | ID GE NUM
     | ID EQ NUM
     | ID NE NUM
     | /* empty */
     ;

incr : ID INC
     | INC ID
     | ID DEC
     | DEC ID
     | ID '=' ID '+' NUM
     | ID '=' ID '-' NUM
     | /* empty */
     ;

body : stmt
     | /* empty */
     ;

stmt : ID INC ';'
     | ID DEC ';'
     | ID '=' NUM ';'
     | ID '=' ID ';'
     ;

%%

int main() {
    printf("Enter FOR loop:\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Invalid FOR loop syntax\n");
    return 0;
}
