%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    double val;
}

%token <val> NUMBER
%token ADD SUB MUL DIV EXP ABS OP CP EOL

%left MUL DIV
%left ADD SUB
%left EXP
%left ABS
%right UMINUS

%type <val> expr

%% 

calculo:
    /* vacío */
    | calculo linea
    ;

linea:
    expr EOL    { printf("Resultado final: %.2f\n", $1); }
    | EOL
    ;

expr:
    NUMBER          { $$ = $1;}
    | expr ADD expr { $$ = $1 + $3; printf("Sumando: %.2f + %.2f = %.2f\n", $1, $3, $$); }
    | expr SUB expr { $$ = $1 - $3; printf("Restando: %.2f - %.2f = %.2f\n", $1, $3, $$); }
    | expr MUL expr { $$ = $1 * $3; printf("Multiplicando: %.2f * %.2f = %.2f\n", $1, $3, $$); }
    | expr DIV expr {
        if ($3 == 0) {
            yyerror("Error: División por cero");
            $$ = 0;  // o maneja este caso como sea necesario
        } else {
            $$ = $1 / $3;
            printf("Dividiendo: %.2f / %.2f = %.2f\n", $1, $3, $$);
        }
    }
    | expr EXP expr { $$ = pow($1, $3); printf("Exponentiando: %.2f ^ %.2f = %.2f\n", $1, $3, $$); }
    | SUB expr %prec UMINUS { $$ = -$2; printf("Negando: -%.2f = %.2f\n", $2, $$); }
    | OP expr CP    { $$ = $2; printf("Paréntesis: (%.2f) = %.2f\n", $2, $$); }
    | ABS expr ABS  { $$ = fabs($2); printf("Valor absoluto: |%.2f| = %.2f\n", $2, $$); }
    ;

%% 

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    printf("Ingrese una expresión matemática:\n");
    return yyparse();
}

