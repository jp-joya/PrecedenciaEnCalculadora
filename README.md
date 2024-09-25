Juan Joya
Juan Gallardo
Jefferson Gutierrez

Descripción General
Este programa es una calculadora simple que utiliza Bison y Flex para analizar y evaluar expresiones matemáticas. Es capaz de realizar operaciones aritméticas básicas como suma, resta, multiplicación y división. Además, maneja errores comunes como la división por cero y expresiones inválidas. 

Archivos
- calc.y: Archivo de Bison que define la gramática y las reglas de evaluación para las expresiones matemáticas.
- calc.l: Archivo de Flex que define cómo se tokenizan las entradas de la calculadora.
- calc.tab.h: Archivo de encabezado generado automáticamente por Bison que contiene las definiciones de tokens.
- calc.tab.c: Archivo de código fuente generado por Bison que contiene la implementación del parser.

Requisitos Previos
Antes de ejecutar este programa, debes tener instalados Bison y Flex en tu sistema.

Paso a Paso para Ejecutar el Programa

1. Creación de los Archivos:
   - Crea un archivo llamado calc.y y pega el contenido de la sección correspondiente en este archivo.
   - Crea un archivo llamado calc.l y pega el contenido de la sección correspondiente en este archivo.

2. Generación de Código C:
   - En la terminal, navega al directorio donde guardaste los archivos y ejecuta los siguientes comandos:
     bison -d calc.y
     flex calc.l
     gcc calc.tab.c lex.yy.c -o calculadora -lm
   - Estos comandos generarán los archivos calc.tab.h, calculadora.tab.c, y lex.yy.c, y luego compilarán todo para crear un ejecutable llamado calculadora.

3. Ejecución del Programa:
   - Para iniciar la calculadora, ejecuta el siguiente comando en la terminal:
     ./calculadora
   - La calculadora estará lista para recibir expresiones matemáticas.

4. Uso del Programa:
   - Escribe cualquier expresión matemática (como 3 + 4 * 2) y presiona Enter. El resultado se mostrará inmediatamente.
   - Para terminar el programa, simplemente presiona Ctrl + C.

Ejemplos de Salida

- Entrada:
  3 + 4 * 2
  Salida:
  Resultado: 11

- Entrada:
  (1 + 2) * (3 + 4)
  Salida:
  Resultado: 21
************************************************************************************************************************************************************************************************************

Explicación del Funcionamiento de la Calculadora

Tokenización

La tokenización es el primer paso en el procesamiento de la entrada. En el archivo de especificaciones del lexer (calculadora.l), se define cómo dividir una expresión matemática en tokens. Un token es una unidad significativa que el analizador sintáctico (parser) utilizará para construir la estructura de la expresión.

Lexer (Flex): El lexer escanea la cadena de entrada y la divide en tokens que representan números, operadores y paréntesis. Cada token tiene un significado específico. Por ejemplo:
Los números ([0-9]+(\.[0-9]*)?) se convierten en el token NUM.
Los operadores (+, -, *, /, ^) y los paréntesis ((, )) se reconocen como tokens individuales correspondientes a sus respectivos caracteres.
Los espacios y tabulaciones se ignoran.
Los caracteres no válidos se descartan.
Estos tokens son luego enviados al analizador sintáctico.

Análisis

El análisis es el proceso en el que los tokens generados por el lexer son interpretados para construir una estructura de datos que representa la expresión matemática. En el archivo de especificaciones del analizador (calculadora.y), se definen las reglas gramaticales que describen cómo se pueden combinar los tokens para formar expresiones válidas.

Analizador Sintáctico (Bison): El analizador utiliza las reglas definidas para construir un árbol de sintaxis abstracto. Cada regla en Bison representa una forma en que los tokens pueden agruparse. Por ejemplo:
exp '+' exp describe una expresión de suma, donde exp representa una subexpresión.
exp '*' exp representa una expresión de multiplicación.
'-' exp %prec UMINUS maneja la negación unaria.
El árbol de sintaxis abstracto refleja la estructura jerárquica de la expresión matemática y el orden de las operaciones.

Evaluación

La evaluación es el proceso final en el que el árbol de sintaxis abstracto se utiliza para calcular el resultado de la expresión. El resultado final se obtiene al aplicar las operaciones matemáticas definidas en el árbol de sintaxis.

Evaluación de la Expresión: A medida que se procesan las reglas en Bison, se evalúan los operadores y operandos siguiendo el orden de las operaciones. Por ejemplo:
En la regla exp '+' exp, el resultado se calcula sumando los valores de las dos subexpresiones.
En la regla exp '*' exp, el resultado se calcula multiplicando los valores de las dos subexpresiones.
En el caso de la división (exp '/' exp), se verifica que el divisor no sea cero antes de realizar la operación para evitar errores.
El resultado final se imprime en la salida estándar una vez que todas las operaciones han sido evaluadas.
