%{ 
#include <stdlib.h>
#include <stdio.h> 
#include <stddef.h>
#include <conio.h>
#include <string.h> 
#include <stdbool.h>
#include <ctype.h>
#include "y.tab.h"

int num_lineas = 1, num_caracteres = 0; 
int contid=0, err=0;
const char *a[500];
FILE *fp;
int sw=0;
int swwhere=0;
%} 

%option yylineno 
espacio (" ")*
creaciont [cC][rR][eE][aA][tT][eE]{espacio}[tT][aA][bB][lL][eE]
dropt  [Dd][rR][Oo][pP]{espacio}[tT][aA][bB][lL][eE]
insertt [iI][Nn][sS][eE][rR][tT]{espacio}[iI][nN][tT][oO]
from [fF][rR][oO][mM]
select [sS][eE][lL][eE][cC][tT]
borrar  [dD][eE][lL][eE][tT][eE]{espacio}[fF][rR][oO][mM]
values [vV][aA][lL][uU][eE][sS]
where [wW][hH][eE][rR][eE]
orderby [oO][rR][dD][eE][rR]{espacio}[bB][yY]
groupby [gG][rR][oO][uU][pP]{espacio}[bB][yY]

palres {creaciont}|{dropt}|{insertt}|{update}|{from}|{select}|{borrar}|{values}|{where}|{orderby}
parab "("
parce ")"
comilla "'"|"‘"|"’"

avg [aA][vV][gG]
min [mM][iI][nN]
max [mM][aA][xX]
count [cC][oO][uU][nN][tT]
funcion {avg}|{min}|{max}|{count}



asc [aA][sS][cC]
desc [dD][eE][sS][cC]
orden {asc}|{desc}

and [aA][nN][dD]
or	[oO][rR]
operadores {and}|{or}

letra [a-zA-Z] 
digito [0-9]
ignora " "
operarit *|+|-|/ 
operlog &|$ 
comparador <|>|<=|>=|==|<>|!=|=
id ({letra}({letra}|{digito})*)
ids ({id}{espacio}(","{espacio}{id})+)
idord ({id}{espacio}{orden}{espacio}(","{espacio}{id}{espacio}{orden})+)
idcom ({comilla}{id}{comilla})

update  [uU][pP][dD][aA][tT][eE]{espacio}{id}{espacio}[sS][eE][tT]

entero {digito}+
dec {digito}+"."{digito}+

varchar [vV][aA][rR][cC][hH][aA][rR]{espacio}"("{espacio}{entero}{espacio}")"
decimal [dD][eE][cC][iI][mM][aA][lL]{espacio}"("{espacio}{entero}{espacio}")"
integer [iI][nN][tT][eE][gG][eE][rR]
tipos {varchar}|{decimal}|{integer}

parametro (({idcom}|{entero}|{dec})({espacio}","{espacio}({idcom}|{entero}|{dec}))*)
condicionSimple (({id}|{entero}|{dec})({comparador})("'"{id}"'"|{entero}|{dec}))
condicionCompuesta ({condicionSimple}({espacio}{operadores}{espacio}{condicionSimple})*)
condicionigual ({condicionSimple}({espacio}","{espacio}{condicionSimple})*)

parmcrear (({id}{espacio}" "{tipos})({espacio}","{espacio}{id}{espacio}" "{tipos})*)

%% 

{ignora}+ {;} 
{creaciont} {covertToUpper(yytext); return CREATE;}
{select} {covertToUpper(yytext); return SELECT;}
{from}	{covertToUpper(yytext); return FROM;}
{dropt}	{covertToUpper(yytext); return DROP;}
{insertt} {covertToUpper(yytext); return INSERT;}
{update} {covertToUpper(yytext); return UPDATE;}
{borrar} {covertToUpper(yytext); return BORRAR;}
{values} {covertToUpper(yytext); return VALUES;}
{where} {covertToUpper(yytext); swwhere=1; return WHERE;}
{orderby} {covertToUpper(yytext); return ORDERBY;}
{groupby} {covertToUpper(yytext); return GROUPBY;}
{orden} {covertToUpper(yytext); return ASCDESC;}


{parametro} {ECHO; return PARAMETRO;}
{idord} {ECHO;printf(" "); return IDSORD;}
{ids} {ECHO;printf(" ");return IDS;}

{id} {Id(a,contid,yytext);return ID;}
{funcion}("(*)"|"("{id}")")({espacio}","{espacio}{funcion}("(*)"|"("{id}")"))*  {covertToUpper(yytext); return FUNCION;}


{condicionCompuesta} {ECHO; char * found = strstr( yytext, "AND" ); 
						char * found1 = strstr( yytext, "OR" );
						char * found2 = strstr( yytext, "=" );
						char * found3 = strstr( yytext, ">" );
						char * found4 = strstr( yytext, "<" );
						if (found == NULL && found1 == NULL && found2 != NULL  && found3 == NULL && found4 == NULL && swwhere==0)                     
						{
  							return CONDICIONIGUAL;	
 	                                      
						}else{ return CONDICIONCOMPUESTA;}}
						
{condicionigual}	{ECHO; char * found = strstr( yytext, "=" ); 
						char * found3 = strstr( yytext, ">" );
						char * found4 = strstr( yytext, "<" );
					if (found != NULL && found3 == NULL && found4 == NULL)                     
						{
  							return CONDICIONIGUAL;	
 	                                      
						}
						
						}					
						
{parmcrear} {ECHO;return PARCRE;}

{digito}+{letra}({letra}|{digito})* {printf("\tERROR LEXICO = "); ECHO; printf("\t" );} 

{digito}+ {printf("ENTERO=" ); ECHO; printf("\t");} 
{digito}+"."{digito}+ {printf("DECIMAL = " ); ECHO; printf("\t");} 
{comilla}  {printf("COMILLA = " ); ECHO; printf("\t" );return COMILLA;} 
"=" {printf("IGUAL = " ); ECHO; printf("\t" ); return ERROR; } 
";" {printf("PUNTO_COMA=" ); ECHO; printf("\t"); swwhere=0; return P_COMA;} 
"<>" {printf("DISTINTO_DE = " );ECHO; printf("\t");return ERROR;} 
"," {printf("COMA=" );ECHO; printf("\t");return ERROR;} 
"." {printf("PUNTO = " );ECHO; printf("\t"); return ERROR;} 
">=" {printf("MAYOR_IGUAL = " ); ECHO; printf("\t");return ERROR;} 
"<=" {printf("MENOR_IGUAL = " ); ECHO; printf("\t");return ERROR;} 
"(" {printf("OPEN_PARENTESIS = " ); ECHO; printf("\t"); return P_ABRE;} 
")" {printf("CLOSE_PARENTESIS = " ); ECHO; printf("\t");return P_CIERRA;} 
">" {printf("MAYOR_QUE = " ); ECHO; printf("\t");return ERROR;} 
"<" {printf("MENOR_QUE = " ); ECHO; printf("\t");return ERROR;} 
"+" {printf("MAS = " ); ECHO; printf("\t");return ERROR;} 
"-" {printf("MENOS = " ); ECHO; printf("\t");return ERROR;} 
("*") {printf("ASTERISCO= " ); ECHO; printf("\t"); return ASTERICO;}
"/" {printf("SLASH = " ); ECHO; printf("\t");return ERROR;} 
\n {++num_lineas;int i=0;swwhere=0;} 
. {printf("\tERROR LEXICO = "); ECHO; printf("\t" ); return ERROR;} 
%% 


void Id(char *a[],int n, char* b){
	int i=0;
	for(i=0;i<n;i++){ 
	if(strcmp(a[i],b)==0){ break; }
	}
	
	if(i<n){
		printf("ID%d= ",i+1 ); ECHO; printf("\t");
	}
	else{
		printf(" ID%d= ",contid+1 ); ECHO; printf("\t");
		a[contid]=strdup(b); b=0; 
		contid=contid+1;
	}
}

void covertToUpper(char *str){
    char *newstr, *p;
    p = newstr = strdup(str);
    while(*p++=toupper(*p));
	printf(newstr);printf(" ");
    //return newstr;
}

int main(int argc,char *argv[]) 
{ 
char NomArch[100]; 
fp= fopen( "salida.txt", "w" );
printf("Ingrese nombre de archivo: " ); 
gets(NomArch); 
if ((yyin = fopen(NomArch, "rt" )) == NULL) 
{ 
printf("\nNo se puede abrir el archivo: %sn", NomArch); 
} 
else 
{ 
yyparse(); 
printf("\nLos IDs encontrados son: \n");
int i=0;
for(i=0;i<contid;i++){
	printf("\nID# %d = ",i+1);
	printf(a[i]);
	}	
printf("\nEl numero de lineas es: %d",num_lineas);
} 
if(sw==0)
{
	fprintf(fp,"CORRECTO");
}
fclose(yyin); 
getch(); 
return 0; 
}


int yyerror(void)
{
	if(sw==0)
	{
		fprintf(fp,"incorrecto\n\n");
		sw=1;
	}
	if(yylineno > err){
		printf("Error en linea: %d ",yylineno);
		fprintf(fp,"Error en linea: %d\n",yylineno);
		err= yylineno;
	}

yyparse();

}

int yywrap(void)
{
return 1;
}

