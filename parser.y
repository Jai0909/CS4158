%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
extern int yylex();
%}

%union {
    int ival;
    float fval;
    char* sval;
}

%token START END MAIN MOVE TO ADD INPUT PRINT PERIOD SEMI_COLON COMMA
%token <ival> SIZE INTEGER FLOAT_SIZE
%token <fval> FLOAT
%token <sval> IDENTIFIER STRING

%type <sval> declaration assignment_statement_move assignment_statement_add input_statement output_statement 

%%

program: START PERIOD declarations MAIN PERIOD statements END PERIOD
      ;

declarations: /* empty */
            | declarations declaration PERIOD
            ;

declaration: SIZE IDENTIFIER { printf("Declared %s with size %d\n", $2, $1); }
	   | FLOAT_SIZE IDENTIFIER {
    int before = $1 / 1000;
    int after = $1 % 1000;
    printf("Declared %s with size %d before and %d after the decimal.\n", $2, before, after);
}
           ;

statements: /* empty */
          | statements statement PERIOD
          ;

statement: assignment_statement_move
         | input_statement
         | output_statement
         | assignment_statement_add
         ;

assignment_statement_move: MOVE value TO IDENTIFIER { printf("Assigned value to %s\n", $4); }
                    ;

value: INTEGER
     | FLOAT
     | IDENTIFIER
     ;
     
assignment_statement_add: ADD value TO IDENTIFIER { printf("Assigned value to %s\n", $4); }
                    ;

input_statement: INPUT identifier_list
               ;

identifier_list:
    IDENTIFIER
    | identifier_list COMMA IDENTIFIER
    ;

output_statement: PRINT print_list
                ;
    
print_list:
    print_element
    | print_list SEMI_COLON print_element
    ;
    
print_element:
    STRING
    | IDENTIFIER
    ;
     

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}


