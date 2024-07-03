%{

/*
LT, LE, EQ, NE, GT, GE, IF, THEN, ELSE, ID,
    NUMERO, OPREL, OPARIT, SUMA, RESTA, MUL,
    DIV, MOD, EXP, DIV_ENTERA , ASIGNACION, FUNCION,
    MATRIZ, ARREGLO, CONJUNTO, OPCON, INTERSECCION,
    UNION, CONTIENE, CONTENIDO, CONTENIDO_IGUAL, PERTENECE,
    DIFERENCIA, COMPLEMENTO, WHILE
*/

    
%}

delim       [ \t\n]
ws          {delim}+
letra       [A-Za-z]
digito      [0-9]
id          {letra}({letra}|{digito})*
numero      -?{digito}+(\.{digito}+)?(E[+−]?{digito}+)?
cadena      {letra}+
conjunto    \{{ws}*\}|\{{ws}*{numero}{ws}*(,{ws}*{numero})*{ws}*\}
arreglo     \[{ws}*\]|\[{ws}*({id}|{numero}){ws}*(,({id}|{numero}))*{ws}*\]
matriz      \[{arreglo}(,{arreglo})*\]
funcion     fun{ws}+{id}{ws}*\({ws}*({id}({ws}*,{ws}*{id})*)?{ws}*\){ws}*\{.*\}
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
mult        \*
div         \/
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
{if}        {printf("condicional if");}
{while}     {printf("bucle while");}
{funcion}   {printf("funcion");}
{id}        {printf("identificador");}
{numero}    {printf("numero");}
{conjunto}  {printf("conjunto");}
{arreglo}   {printf("arreglo");}
{matriz}    {printf("matriz");}
{asignacion}    {printf("asignacion");}
{menor}         {printf("oprel, lt");}
{menor_igual}   {printf("oprel, le");}
{igual}         {printf("oprel, eq");}
{diferente}     {printf("oprel, ne");}
{mayor}         {printf("oprel, gt");}
{mayor_igual}   {printf("oprel, ge");}
{suma}          {printf("oparit, suma");}
{resta}         {printf("oparit, resta");}
{mult}          {printf("oparit, multiplicacion");}
{div}           {printf("oparit, division");}
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

int yywrap() {}

int main(){
    printf("ingresa una cadena: ");
    yylex();
    return 0;
}