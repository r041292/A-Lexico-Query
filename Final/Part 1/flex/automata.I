%{ 
#include <stdio.h> 
#include <stddef.h>
#include <conio.h>
#include <string.h> 
#include <stdbool.h>
#include <ctype.h>

int num_lineas = 1, num_caracteres = 0; 
int contid=0,conterror=0;
const char *a[500];
%} 
%option noyywrap 
%option yylineno 
espacio (" ")*
creaciont [cC][rR][eE][aA][tT][eE]{espacio}[tT][aA][bB][lL][eE]
dropt  [Dd][rR][Oo][pP]{espacio}[tT][aA][bB][lL][eE]
insertt [iI][Nn][sS][eE][rR][tT]{espacio}[iI][nN][tT][oO]
update  [uU][pP][dD][aA][tT][eE]{espacio}[sS][eE][tT]
from [fF][rR][oO][mM]
select [sS][eE][lL][eE][cC][tT]
borrar  [dD][eE][lL][eE][tT][eE]{espacio}[fF][rR][oO][mM]
values [vV][aA][lL][uU][eE][sS]
where [wW][hH][eE][rR][eE]
orderby [oO][rR][dD][eE][rR]{espacio}[bB][yY]
palres {creaciont}|{dropt}|{insertt}|{update}|{from}|{select}|{borrar}|{values}|{where}|{orderby}
parab "("
parce ")"
comilla "'"|"‘"|"’"

avg [aA][vV][gG]
min [mM][iI][nN]
max [mM][aA][xX]
count [cC][oO][uU][nN][tT]
funcion {avg}|{min}|{max}|{count}

varchar [vV][aA][rR][cC][hH][aA][rR]
decimal [dD][eE][cC][iI][mM][aA][lL]
integer [iI][nN][tT][eE][gG][eE][rR]
tipos {varchar}|{decimal}|{integer}

asc [aA][sS][cC]
desc [dD][eE][sS][cC]
orden {asc}|{desc}

and [aA][nN][dD]
or	[oO][rR]
operadores {and}|{or}

letra [a-zA-Z] 
digito [0-9]
ignora " "|t|n 
operarit *|+|-|/ 
operlog &|$ 
comparador <|>|<=|>=|==|!=

 
%% 
{ignora}+ {;} 
{palres}|{funcion}|{tipos}|{operadores}|{orden} { covertToUpper(yytext); }


{letra}({letra}|{digito})* {Id(a,contid,yytext);yytext=0;}
{digito}+{letra}({letra}|{digito})* {printf("\tERROR LEXICO = "); ECHO; conterror=conterror+1; printf("\t" );} 

{digito}+ {printf("ENTERO=" ); ECHO; printf("\t");} 
{digito}+"."{digito}+ {printf("DECIMAL = " ); ECHO; printf("\t");} 
{comilla}  {printf("COMILLA = " ); ECHO; printf("\t" );} 
"=" {printf("IGUAL = " ); ECHO; printf("\t" ); } 
";" {printf("PUNTO_COMA=" ); ECHO; printf("\t");} 
"<>" {printf("DISTINTO_DE = " );ECHO; printf("\t");} 
"," {printf("COMA=" );ECHO; printf("\t");} 
"." {printf("PUNTO = " );ECHO; printf("\t");} 
">=" {printf("MAYOR_IGUAL = " ); ECHO; printf("\t");} 
"<=" {printf("MENOR_IGUAL = " ); ECHO; printf("\t");} 
"(" {printf("OPEN_PARENTESIS = " ); ECHO; printf("\t");} 
")" {printf("CLOSE_PARENTESIS = " ); ECHO; printf("\t");} 
">" {printf("MAYOR_QUE = " ); ECHO; printf("\t");} 
"<" {printf("MENOR_QUE = " ); ECHO; printf("\t");} 
"+" {printf("MAS = " ); ECHO; printf("\t");} 
"-" {printf("MENOS = " ); ECHO; printf("\t");;} 
"*" {printf("ASTERISCO = " ); ECHO; printf("\t");} 
"/" {printf("SLASH = " ); ECHO; printf("\t");} 
\n {++num_lineas;int i=0;printf("\n\n");} 
. {printf("\tERROR LEXICO = "); ECHO; conterror=conterror+1; printf("\t" );} 
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
printf("Ingrese nombre de archivo: " ); 
gets(NomArch); 
if ((yyin = fopen(NomArch, "rt" )) == NULL) 
{ 
printf("\n\nNo se puede abrir el archivo: %s", NomArch); 
} 
else 
{ 
yylex(); 
printf("\n\nLos IDs encontrados son: \n");
int i=0;
for(i=0;i<contid;i++){
	printf("\nID# %d = ",i+1);
	printf(a[i]);
	}
printf("\n\nTotal: %d\n",contid);
printf("\nEl numero de errores es: %d\n",conterror);		
printf("El numero de lineas es: %d",num_lineas);
} 
fclose(yyin); 
getch(); 
return 0; 
}

