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

// Definición de precedencia de operadores
%left ADD SUB
%left MUL DIV
%left EXP
%right UMINUS

// Definimos que los paréntesis tienen mayor precedencia
%nonassoc OP CP  

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
    OP expr CP    { $$ = $2; printf("Resolviendo: (%.2f) = %.2f\n", $2, $$); } // Resolvemos primero lo que está en paréntesis
    | NUMBER          { $$ = $1; }
    | expr ADD expr { $$ = $1 + $3; printf("Sumando: %.2f + %.2f = %.2f\n", $1, $3, $$); }
    | expr SUB expr { $$ = $1 - $3; printf("Restando: %.2f - %.2f = %.2f\n", $1, $3, $$); }
    | expr MUL expr { $$ = $1 * $3; printf("Multiplicando: %.2f * %.2f = %.2f\n", $1, $3, $$); }
    | expr DIV expr {
        if ($3 == 0) {
            yyerror("Error: División por cero");
            $$ = 0;  // Manejo de error para división por cero
        } else {
            $$ = $1 / $3;
            printf("Dividiendo: %.2f / %.2f = %.2f\n", $1, $3, $$);
        }
    }
    | expr EXP expr { $$ = pow($1, $3); printf("Exponentiando: %.2f ^ %.2f = %.2f\n", $1, $3, $$); }
    | SUB expr %prec UMINUS { $$ = -$2; printf("Negando: -%.2f = %.2f\n", $2, $$); }
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

