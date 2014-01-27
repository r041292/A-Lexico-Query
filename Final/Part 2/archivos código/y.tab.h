
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ERROR = 258,
     ID = 259,
     CREATE = 260,
     SELECT = 261,
     ASTERICO = 262,
     ASTERICOID = 263,
     FROM = 264,
     P_COMA = 265,
     DROP = 266,
     INSERT = 267,
     UPDATE = 268,
     BORRAR = 269,
     VALUES = 270,
     WHERE = 271,
     GROUPBY = 272,
     ORDERBY = 273,
     ASCDESC = 274,
     FUNCION = 275,
     PARAMETRO = 276,
     CONDICIONCOMPUESTA = 277,
     IDS = 278,
     IDSORD = 279,
     COMILLA = 280,
     P_ABRE = 281,
     P_CIERRA = 282,
     PARCRE = 283,
     CONDICIONIGUAL = 284
   };
#endif
/* Tokens.  */
#define ERROR 258
#define ID 259
#define CREATE 260
#define SELECT 261
#define ASTERICO 262
#define ASTERICOID 263
#define FROM 264
#define P_COMA 265
#define DROP 266
#define INSERT 267
#define UPDATE 268
#define BORRAR 269
#define VALUES 270
#define WHERE 271
#define GROUPBY 272
#define ORDERBY 273
#define ASCDESC 274
#define FUNCION 275
#define PARAMETRO 276
#define CONDICIONCOMPUESTA 277
#define IDS 278
#define IDSORD 279
#define COMILLA 280
#define P_ABRE 281
#define P_CIERRA 282
#define PARCRE 283
#define CONDICIONIGUAL 284




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


