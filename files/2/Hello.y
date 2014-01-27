%{
#include <stdlib.h>
#include <stdio.h> 
#include <stddef.h>
#include <conio.h>

extern int yylineno;
%}


%token HI ID BYE SELECT ASTERICO FROM P_COMA

%%

program: 
        
		| program ID  {	printf("id encontrado en linea: %d \n",yylineno); }
		| program HI BYE {printf("hi bye encontrado en: %d \n",yylineno); }
		| program SELECT ASTERICO FROM ID P_COMA {	printf("SELECT encontrado en linea: %d \n",yylineno); }
		| program P_COMA
        ;
        

         
%%
