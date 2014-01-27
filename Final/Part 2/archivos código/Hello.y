%{
#include <stdlib.h>
#include <stdio.h> 
#include <stddef.h>
#include <conio.h>

extern int yylineno;
%}


%token  ERROR ID  CREATE SELECT ASTERICO ASTERICOID FROM P_COMA DROP INSERT UPDATE BORRAR VALUES WHERE GROUPBY ORDERBY ASCDESC FUNCION PARAMETRO CONDICIONCOMPUESTA IDS IDSORD COMILLA P_ABRE P_CIERRA PARCRE CONDICIONIGUAL

%%

program: 
        
		| program ID  {	printf("id encontrado en linea: %d \n",yylineno); }
		
		
		| program SELECT ID FROM ID P_COMA {	printf("SELECT ID encontrado en linea: %d \n",yylineno); }
		| program SELECT ID FROM ID WHERE CONDICIONCOMPUESTA P_COMA {	printf("SELECT ID WHERE encontrado en linea: %d \n",yylineno); }
		| program SELECT ASTERICO FROM ID P_COMA {	printf("SELECT * encontrado en linea: %d \n",yylineno); }
		| program SELECT ASTERICO FROM ID WHERE CONDICIONCOMPUESTA P_COMA {	printf("SELECT * WHERE encontrado en linea: %d \n",yylineno); }
		
		| program SELECT IDS FROM ID P_COMA {	printf("SELECT IDS encontrado en linea: %d \n",yylineno); }
		| program SELECT IDS FROM ID WHERE CONDICIONCOMPUESTA P_COMA {	printf("SELECT IDS WHERE encontrado en linea: %d \n",yylineno); }
				
		| program SELECT FUNCION FROM ID P_COMA {	printf("SELECT fUNCION encontrado en linea: %d \n",yylineno); }
		| program SELECT FUNCION FROM ID WHERE CONDICIONCOMPUESTA P_COMA {	printf("SELECT WHERE FUNCION encontrado en linea: %d \n",yylineno); }
		
		| program SELECT ID FROM ID GROUPBY ID P_COMA {	printf("SELECT ID GROUPBY encontrado en linea: %d \n",yylineno); }
		| program SELECT ID FROM ID WHERE CONDICIONCOMPUESTA GROUPBY ID P_COMA {	printf("SELECT ID WHERE GROUPBY encontrado en linea: %d \n",yylineno); }
		
		| program SELECT ASTERICO FROM ID GROUPBY ID P_COMA {	printf("SELECT *|ID GROUPBY encontrado en linea: %d \n",yylineno); }
		| program SELECT ASTERICO FROM ID WHERE CONDICIONCOMPUESTA GROUPBY ID P_COMA {	printf("SELECT *|ID WHERE GROUPBY encontrado en linea: %d \n",yylineno); }
		
		| program SELECT IDS FROM ID GROUPBY ID P_COMA {	printf("SELECT IDS GROUPBY encontrado en linea: %d \n",yylineno); }
		| program SELECT IDS FROM ID WHERE CONDICIONCOMPUESTA GROUPBY ID P_COMA {	printf("SELECT IDS WHERE GROUPBY encontrado en linea: %d \n",yylineno); }
		
		| program SELECT FUNCION FROM ID GROUPBY ID P_COMA {	printf("SELECT funcion GROUPBY encontrado en linea: %d \n",yylineno); }
		| program SELECT FUNCION FROM ID WHERE CONDICIONCOMPUESTA GROUPBY ID P_COMA {	printf("SELECT FUNCION WHERE GROUPBY encontrado en linea: %d \n",yylineno); }
		
		| program SELECT IDS FROM ID ORDERBY ID ASCDESC P_COMA {	printf("SELECT IDS ORDERBY encontrado en linea: %d \n",yylineno); }
		| program SELECT ID FROM ID WHERE CONDICIONCOMPUESTA ORDERBY ID ASCDESC P_COMA {	printf("SELECT ID WHERE ORDERBY encontrado en linea: %d \n",yylineno); }
		| program SELECT IDS FROM ID GROUPBY ID ORDERBY ID ASCDESC P_COMA {	printf("SELECT IDS GROUPBY ORDERBY encontrado en linea: %d \n",yylineno); }
		| program SELECT IDS FROM ID WHERE CONDICIONCOMPUESTA GROUPBY ID ORDERBY ID ASCDESC P_COMA {	printf("SELECT IDS WHERE GROUPBY ORDERBY encontrado en linea: %d \n",yylineno); }
		
		| program SELECT ASTERICO FROM ID ORDERBY ID ASCDESC P_COMA {	printf("SELECT * ORDERBY encontrado en linea: %d \n",yylineno); }
		| program SELECT ASTERICO FROM ID WHERE CONDICIONCOMPUESTA ORDERBY ID ASCDESC P_COMA {	printf("SELECT * WHERE ORDERBY encontrado en linea: %d \n",yylineno); }
	
		| program SELECT IDS FROM ID ORDERBY IDSORD P_COMA {	printf("SELECT IDS ORDERBY IDS encontrado en linea: %d \n",yylineno); }
		| program SELECT ID FROM ID WHERE CONDICIONCOMPUESTA ORDERBY IDSORD P_COMA {	printf("SELECT ID WHERE ORDERBY IDS encontrado en linea: %d \n",yylineno); }
		| program SELECT IDS FROM ID GROUPBY ID ORDERBY IDSORD P_COMA {	printf("SELECT IDS GROUPBY ORDERBY IDS encontrado en linea: %d \n",yylineno); }
		| program SELECT IDS FROM ID WHERE CONDICIONCOMPUESTA GROUPBY ID ORDERBY IDSORD P_COMA {	printf("SELECT IDS WHERE GROUPBY ORDERBY IDS encontrado en linea: %d \n",yylineno); }
		
		| program SELECT ASTERICO FROM ID ORDERBY IDSORD P_COMA {	printf("SELECT * ORDERBY IDS encontrado en linea: %d \n",yylineno); }
		| program SELECT ASTERICO FROM ID WHERE CONDICIONCOMPUESTA ORDERBY IDSORD P_COMA {	printf("SELECT * WHERE ORDERBY IDS encontrado en linea: %d \n",yylineno); }
		
		| program INSERT ID VALUES P_ABRE PARAMETRO P_CIERRA P_COMA {printf("INSERT INTO encontrado en linea: %d \n",yylineno); }
		
		| program UPDATE CONDICIONIGUAL WHERE CONDICIONCOMPUESTA P_COMA {printf("UPDATE SET encontrado en linea: %d \n",yylineno); }
		| program UPDATE CONDICIONIGUAL P_COMA {printf("UPDATE SET encontrado en linea: %d \n",yylineno); }
		
		| program DROP ID P_COMA {printf("DROP TABLE encontrado en linea: %d \n",yylineno); }
		
		| program BORRAR ID WHERE CONDICIONCOMPUESTA P_COMA {printf("DELETE encontrado en linea: %d \n",yylineno); }
		
		| program CREATE ID P_ABRE PARCRE P_CIERRA P_COMA {printf("CREATE encontrado en linea: %d \n",yylineno); }
		
		| program P_COMA
        ;
        

         
%%


