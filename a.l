%{

#include "y.tab.h"
void yyerror (char *s);
int yylex();
    
%}

delim       [ \t\n]
ws          {delim}+
letra       [A-Za-z]
digito      [0-9]
identificador          {letra}({letra}|{digito})*
numero      -?{digito}+(\.{digito}+)?(E[+−]?{digito}+)?
real        [0-9]*\.[0-9]*([eE][+-]?[0-9]+)?
entero      [0-9]+
cadena      "\"([^\"\\]|\\.)*\""
conjunto    \{{ws}*\}|\{{ws}*{numero}{ws}*(,{ws}*{numero})*{ws}*\}
arreglo     \[{ws}*\]|\[{ws}*({identificador}|{numero}){ws}*(,({identificador}|{numero}))*{ws}*\]
matriz      \[{arreglo}(,{arreglo})*\]
funcion     fun{ws}+{identificador}{ws}*\({ws}*({identificador}({ws}*,{ws}*{identificador})*)?{ws}*\){ws}*\{.*\}
condicion   \(.*\)\{.*\}
if          si{ws}*{condicion}
while       mientras{ws}*{condicion}
asignacion  =
menor       <
menor_igual <=
mayor       >
mayor_igual >=
igual       ==
diferente   !=
suma        \+
resta       -
multi        \*
divi         \/
div_entera  \/\/
potencia    \*\*
inter_c             _inter
union_c             _union
contiene_c          _contiene 
contenido_c         _contenido
contenido_igual_c   _contenido_igual
contiene_igual_c    _contiene_igual
pertenece_c         _pertenece
diferencia_c        _diferencia
complemento_c       _complemento



%%

{ws}        {}
"print"				   {return print;}
"exit"				   {return exit_command;}
{if}        {printf("condicional if");}
{while}     {printf("bucle while");}
{funcion}   {printf("funcion");}
{cadena}    {yylval.cadena = strdup(yytext); return token_cadena;}
{identificador}  {yylval.id = strdup(yytext); return token_identificador;}
{entero}        {yylval.entero = atoi(yytext); return token_entero;}
{real}          {yylval.real = atof(yytext); return token_real;}
{conjunto}  {printf("conjunto");}
{arreglo}   {printf("arreglo");}
{matriz}    {printf("matriz");}
{asignacion}    { return asignacion;}
{menor}         {printf("oprel, lt");}
{menor_igual}   {printf("oprel, le");}
{igual}         {printf("oprel, eq");}
{diferente}     {printf("oprel, ne");}
{mayor}         {printf("oprel, gt");}
{mayor_igual}   {printf("oprel, ge");}
{suma}          {return suma;}
{resta}         {return resta;}
{multi}          {return multi;}
{divi}           {return divi;}
{potencia}      {printf("oparit, potencia");}
{div_entera}    {printf("oparit, parte entera");}
{inter_c}             {printf("opcon, interseccion");}
{union_c}             {printf("opcon, union");}
{contiene_c}          {printf("opcon, contiene");}
{contenido_c}         {printf("opcon, contenido");}
{contenido_igual_c}   {printf("opcon, contenido_igual");}
{contiene_igual_c}    {printf("opcon, contiene_igual");}
{pertenece_c}         {printf("opcon, pertenece");}
{diferencia_c}        {printf("opcon, diferencia");}
{complemento_c}       {printf("opcon, complemento");}

%%

int yywrap (void) {return 1;}