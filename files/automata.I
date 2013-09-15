%{ 
#include <stdio.h> 
#include <stddef.h>
#include <conio.h>
#include <string.h> 
#include <stdbool.h>
#include <ctype.h>

int num_lineas = 1, num_caracteres = 0; 
int contid=0;
const char *a[100];
%} 
%option noyywrap 
%option yylineno 
espacio (" ")*
creaciont [cC][rR][eE][aA][tT][eE]{espacio}[tT][aA][bB][lL][eE]
dropt  [Dd][rR][Oo][pP]{}espacio}[tT][aA][bB][lL][eE]
insertt [iI][Nn][sS][eE][rR][tT]
into [iI][nN][tT][oO]
update  [uU][pP][dD][aA][tT][eE]
from [fF][rR][oO][mM]
select [sS][eE][lL][eE][cC][tT]
borrar  [dD][eE][lL][eE][tT][eE]{espacio}[fF][rR][oO][mM] 
palres [{creaciont}{dropt}{insertt}{into}{update}{from}{select}{borrar}]
parab "("
parce ")"
comilla "'"|"‘"|"’"

avg [aA][vV][gG]
min [mM][iI][nN]
max [mM][aA][xX]
count [cC][oO][uU][nN][tT]
funcion [{avg}{min}{max}{count}]

letra [a-zA-Z] 
digito [0-9] 
ignora " "|t|n 
operarit *|+|-|/ 
operlog &|$ 
comparador <|>|<=|>=|==|!=

 
%% 
{ignora}+ {;} 
{palres}|{funcion} { covertToUpper(yytext); }

{letra}({letra}|{digito})* {Id(a,contid,yytext);yytext=0;}

{letra}+ {printf("CADENA\t" );} 
{digito}+ {printf("ENTERO=" ); ECHO; printf("\t");} 
{digito}+"."{digito}+ {printf("REAL\t" );} 
{comparador} {printf("COMPARADOR=" );ECHO;} 
{comilla}  {printf("Comilla= " ); ECHO; printf("\t" );} 
":=" {printf("ASIGNADOR\t" );} 
";" {printf("PUNTO_COMA=" ); ECHO; printf("\t");} 
"!=" {printf("DIFERENCIA=" );ECHO; printf("\t");} 
"," {printf("COMA=" );ECHO; printf("\t");} 
"==" {printf("IGUAL\t" );} 
"." {printf("PUNTO\t" );} 
">=" {printf("MAYOR_IGUAL\t" );} 
"<=" {printf("MENOR_IGUAL\t" );} 
"(" {printf("OPEN_PARENTESIS\t" ) ;} 
")" {printf("CLOSE_PARENTESIS\t" ) ;} 
">" {printf("MAYOR\t" );} 
"<" {printf("MENOR\t" );} 
"{" {printf("OPEN_LLAVE\t" );} 
"}" {printf("CLOASE_LLAVE\t" ) ;} 
"+" {printf("SUMA\t" );} 
"-" {printf("RESTA\t" );} 
"*" {printf("MUTIPLICACION\t" ) ;} 
"/" {printf("DIVISION\t" ) ;} 
"&" {printf("AND\t" ) ;} 
"$" {printf("OR\t" ) ;} 
\n {++num_lineas;int i=0;} 
. {printf("\nERROR LEXICO EN LINEA: %d ",yylineno);} 
%% 


void Id(char *a[],int n, char* b){
	int i=0;
	for(i=0;i<n;i++){
		if(strcmp(a[i],b)==0){ break; }	
		
	}
	
	if(i<n)
	{
		printf("ID%d= ",i ); ECHO;
	}
	else
	{
		printf(" ID%d= ",contid ); ECHO; printf("\t");
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
char NomArch[30]; 


printf("Ingrese nombre de archivo: " ); 
gets(NomArch); 
if ((yyin = fopen(NomArch, "rt" )) == NULL) 
{ 
printf("nNo se puede abrir el archivo: %sn", NomArch); 
} 
else 
{ 
yylex(); 
printf("\nLos IDs encontrados son: \n");
int i=0;
for(i=0;i<contid;i++){
	
	printf("\nID# %d =",i);
	printf(a[i]);
	}	


printf("\nEl numero de lineas es: %d",num_lineas);
} 
fclose(yyin); 
getch(); 
return 0; 
}

