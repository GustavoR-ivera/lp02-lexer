%{

    LT, LE, EQ, NE, GT, GE, IF, THEN, ELSE, ID,
    NUMERO, OPREL, OPARIT, SUMA, RESTA, MUL,
    DIV, MOD, EXP, DIV_ENTERA , ASIGNACION, FUNCION,
    MATRIZ, ARREGLO, CONJUNTO, OPCON, INTERSECCION,
    UNION, CONTIENE, CONTENIDO, CONTENIDO_IGUAL, PERTENECE,
    DIFERENCIA, COMPLEMENTO, WHILE;
    
%}


delim       [ \t\n]
ws          {delim}+
letra       [A-Za-z]
digito      [0-9]
id          {letra}({letra}|{digito})*
numero      {digito}+(\.{digito}+)?(E[+−]?{digito}+)?
cadena      {letra}+
funcion     fun{ws}+{id}{ws}*\({ws}*({id}({ws}*,{ws}*{id})*)?{ws}*\){ws}*\{.*\}
condicion   \(.*\)\{.*\}
if          si{ws}*{condicion}
while       mientras{ws}*{condicion}


%%

{if}        {printf("condicional if");}
{while}     {printf("bucle while");}
{funcion}   {printf("funcion");}


%%

yywrap() {}

int main(){
    printf("ingresa una cadena: ");
    yylex();
    return 0;
}