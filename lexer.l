%{
#include "parser.tab.h"
%}

%option noyywrap

%option case-insensitive

%%
[ \t]+               ;
\n    		     ;

"START"             return START;
"END"               return END;
"MAIN"               return MAIN;
"MOVE"               return MOVE;
"TO"                 return TO;
"ADD"                return ADD;
"INPUT"              return INPUT;
"PRINT"              return PRINT;
"."    		     return PERIOD;
";"    		     return SEMI_COLON;
","                  return COMMA;

[Ss]+                { yylval.ival = strlen(yytext); return SIZE; }
[Ss]+\.[Ss]+ {
    int before = 0, after = 0;
    for (int i = 0; yytext[i] != '.'; ++i) {
        if (yytext[i] == 'S' || yytext[i] == 's') {
            before++;
        }
    }
    int decimalFound = 0;
    for (int i = 0; yytext[i]; ++i) {
        if (decimalFound) {
            if (yytext[i] == 'S' || yytext[i] == 's') {
                after++;
            }
        } else if (yytext[i] == '.') {
            decimalFound = 1;
        }
    }
    yylval.ival = before * 1000 + after;
    return FLOAT_SIZE;
}

[0-9]+               { yylval.ival = atoi(yytext); return INTEGER; }
[0-9]+\.[0-9]+       { yylval.fval = atof(yytext); return FLOAT; }

[a-zA-Z][-a-zA-Z0-9]*  |
"-"[a-zA-Z][-a-zA-Z0-9]*  { yylval.sval = strdup(yytext); return IDENTIFIER; }

\"[^"]*\"            { yylval.sval = strdup(yytext); return STRING; }

%%

