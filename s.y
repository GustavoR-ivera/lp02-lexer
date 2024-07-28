%{
    void yyerror(char *s);
    int yylex();
    //declaracion estandar de C
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>
    #include <string.h>

       //constante de tamaño tabla de simbolos
    #define TABLE_SIZE 100

    /*referenciar un tipo de dato*/
typedef enum {
    INT,
    DOUBLE,
    STRING,
    
} DataType;

    /*referenciar un tipo de nodo*/
typedef enum_nodo {
    nodo_int,
    nodo_double,
    nodo_string,
    
} DataTypeNode;

/*almacenar el valor del simbolo*/
typedef union {
    int intValue;
    double doubleValue;
    char* stringValue;
} SymbolValue;

/*estructura nodo para numeros enteros*/
typedef struct Node {
    char* symbol;
    DataType type;
    SymbolValue value;
    struct Node* next;
} Node;

/*estructura para la tabla de simbolos*/
typedef struct SymbolTable {
    Node* buckets[TABLE_SIZE];
} SymbolTable;

/*variable global referencia a la tabla de simbolos*/
SymbolTable* table;

 

    // retorna valor de variable en la tabla de simbolos
    //int symbolVal(char* symbol); 
    Node* findSymbol(SymbolTable* table, char* symbol);

    //void updateSymbolVal(char* symbol, int val);
    void insertSymbol(SymbolTable* table, char* symbol, DataTypeNode type, SymbolValue value);

    unsigned int hash(char* symbol);

    SymbolTable* createSymbolTable();
%}

    //declaraciones de yacc
    //especificar los tipos de dato que el a.lexico retorna
    %union {int entero; 
            double real;
            char* id; 
            char* cadena;}
    //indicar la produccion o regla de inicio
    %start line
    //obtener el token leido y referenciarlo con lo indicado en union
    %token print
    %token exit_command
    %token <entero> token_entero
    %token <real> token_real
    %token <id> token_identificador
    %token <cadena> token_cadena
    %token suma
    %token resta
    %token multi
    %token divi
    %token asignacion
    %type <real> line exp term factor
    %type <id> assignment 

%%

/* descriptions of expected inputs     corresponding actions (in C) */

line    : assignment ';'		{}
		| exit_command ';'		{exit(EXIT_SUCCESS);}
		| print exp ';'			{printf("Printing %d\n", $2);}
		| line assignment ';'	{}
		| line print exp ';'	{printf("Printing %d\n", $3);}
		| line exit_command ';'	{exit(EXIT_SUCCESS);}
        ;

assignment : token_identificador asignacion exp  { 
                                            SymbolValue value;

                                            #define TYPEOF(var) _Generic((var), \
                                            int: "int", \
                                            float: "float", \
                                            double: "double", \
                                            char*: "string", \
                                            default: "unknown")

                                            char* type = TYPEOF($3);
                                            if (type == "int") 
                                            {
                                                value.intValue = $3;
                                                insertSymbol(table, $1, INT, value);
                                            }
                                               
                                            }
			;
exp    	: term                  {$$ = $1;}
       	| exp suma term         {$$ = $1 + $3;}
       	| exp resta term        {$$ = $1 - $3;}
       	;
term   	: factor              {$$ = $1;}
		| '(' term ')'	      {$$ = $2;} 
        ;
factor  :  token_real               {$$ = $1;}   
        |  token_entero             {$$ = $1;} 
        |  token_identificador      {
                                    Node* node = findSymbol(table, $1);
                                    node.value
                                    } 
        |  token_cadena              {$$ = $1;}
        ;

%%      
/* C code */



SymbolTable* createSymbolTable() {
    SymbolTable* table = malloc(sizeof(SymbolTable));
    if (table == NULL) {
        // manejar error de asignación de memoria
        return NULL;
    }
    for (int i = 0; i < TABLE_SIZE; i++) {
        table->buckets[i] = NULL;
    }
    return table;
}

unsigned int hash(char* symbol) {
    unsigned int h = 0;
    for (char* p = symbol; *p != '\0'; p++) {
        h = 31 * h + *p;
    }
    return h % TABLE_SIZE;
}

/*
int computeSymbolIndex(char* token)
{
	int idx = -1;
	if(islower(token[0])) {
		idx = token[0] - 'a' + 26;
	} else if(isupper(token[0])) {
		idx = token[0] - 'A';
	}
	return idx;
} */

/* returns the value of a given symbol */
/*int symbolVal(char* symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}*/

/* updates the value of a given symbol */
/*
void updateSymbolVal(char* symbol, int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}
*/

/*guardar simbolo/token cuyo valor asociado en num_entero*/
void insertSymbol(SymbolTable* table, char* symbol, DataType type, SymbolValue value) {
    unsigned int idx = hash(symbol);
    Node* node = malloc(sizeof(Node));
    node->symbol = strdup(symbol);
    node->type = type;
    node->value = value;
    /*actualizar nodo siguiente*/
    node->next = table->buckets[idx];
    /*establecer el nodo actual en la posicion definida*/
    table->buckets[idx] = node;
}

Node* findSymbol(SymbolTable* table, char* symbol) {
    unsigned int idx = hash(symbol);
    for (Node* node = table->buckets[idx]; node != NULL; node = node->next) {
        if (strcmp(node->symbol, symbol) == 0) {
            return node;
        }
    }
    return NULL;
}

int main (void) {
	/* init symbol table */
	table = createSymbolTable();

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 


