%{
#include "calc.tab.h"
#include <stdlib.h>
#include <ctype.h>

%}

%%

[0-9]+\.[0-9]+    { yylval.val = atof(yytext); return NUMBER; }
[0-9]+            { yylval.val = atof(yytext); return NUMBER; }
"^"                { return EXP; }  // Exponentiation operator
"+"                { return ADD; }
"-"                { return SUB; }
"*"                { return MUL; }
"/"                { return DIV; }
"("                { return OP; }
")"                { return CP; }
"ABS"              { return ABS; }
\n                 { return EOL; }
[ \t]              { /* Ignore whitespace */ }

%%

int yywrap(void) {
    return 1;
}

