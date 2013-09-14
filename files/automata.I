%{ 
#include <stdio.h> 
#include <conio.h>
#include <string.h> 
#include <stdbool.h>

int num_lineas = 1, num_caracteres = 0; 
int contid=0;
char *a[100];
char *temp;
%} 
%option noyywrap 
%option yylineno 
creaciont ("C"|"c")("r"|"R")("e"|"E")("a"|"A")("t"|"T")("e"|"E")" "("t"|"T")("a"|"A")("b"|"B")("l"|"L")("e"|"E")
dropt  [Dd][rR][Oo][pP]" "[tT][aA][bB][lL][eE]
insertt [iI][Nn][sS][eE][rR][tT]" "[iI][nN][tT][oO]
update  [uU][pP][dD][aA][tT][eE]
parab "("
parce ")"
avg [aA][vV][gG]
min [mM][iI][nN]
max [mM][aA][xX]
count [cC][oO][uU][nN][tT]
from [fF][rR][oO][mM]
select ("s"|"S")("e"|"E")("l"|"L")("e"|"E")("c"|"C")("t"|"T")
borrar  "Delete from"
letra [a-zA-Z] 
digito [0-9] 
ignora " "|t|n 
operarit *|+|-|/ 
operlog &|$ 
comparador <|>|<=|>=|==|!=
funciones {}
 
%% 
{ignora}+ {;} 
{creaciont} {printf("Create Table ");}
{select} {printf("SELECT");}
{min} {printf("MIN");}
{max} {printf("MAX");}
{avg} {printf("AVG");}
{count} {printf("COUNT");}
{from} {printf("COUNT");}
{letra}({letra}|{digito})* {	
								temp=yytext;
								Id(a,contid,temp);
   								 
							}
{letra}+ {printf("CADENA\t" );} 
{digito}+ {printf("ENTERO=" ); ECHO; printf("\t");} 
{digito}+"."{digito}+ {printf("REAL\t" );} 
{comparador} {printf("COMPARADOR=" );ECHO;} 
":=" {printf("ASIGNADOR\t" );} 
";" {printf("PUNTO_COMA=" ); ECHO; printf("\t");} 
"!=" {printf("DIFERENCIA=" );ECHO; printf("\t");} 
"," {printf("COMA=" );ECHO; printf("\t");} 
"==" {printf("IGUAL\t" );} 
"." {printf("PUNTO\t" );} 
">=" {printf("MAYOR_IGUAL\t" );} 
"<=" {printf("MENOR_IGUAL\t" );} 
"(" {printf("OPEN_PARENTESIS\t" ) ;} 
" ) " {printf("CLOSE_PARENTESIS\t" ) ;} 
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


void Id(char *a[],int n, char *b){
	int i=0;

	for(i=0;i<n;i++){
	
		if(a[i]==b){ break; }	
		
	}
	if(i<n)
	{
		printf("ID%d= ",i ); ECHO;
	}
	else
	{
		printf("ID%d= ",contid ); ECHO; printf("\t");a[contid]=temp; contid=contid+1; 
	}

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
printf(a[0]);
printf("\nLos IDs encontrados son: \n");
int i=0;
for(i=0;i<contid;i++){
	
	printf("\nID# %d =",i);
	printf(a[i]);
	}	


printf("\nEl numero de lineas es: %d",num_lineas);
} 
fclose(yyin); 
printf(a[0]);
getch(); 
return 0; 
}

