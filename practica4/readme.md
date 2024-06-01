# Fundamentos de la Organización de Datos - Practica 4


## ⚪ Punto 1

***Considere que desea almacenar en un archivo la información correspondiente a los alumnos de la Facultad de Informática de la UNLP. De los mismos deberá guardarse nombre y apellido, DNI, legajo y año de ingreso. Suponga que dicho archivo se organiza como un árbol B de orden M.***

* ***Defina en Pascal las estructuras de datos necesarias para organizar el archivo de alumnos como un árbol B de orden M.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
const 
    M = x; {x es el orden del árbol}
type
    dato = record 
        nomApe: string[30];
        dni: longint;
        legajo: integer;
        anioIng: integer;
    end;
    nodo = record
        cant_claves: integer;
        claves: array [1..M-1] of integer;
        enlaces: array [1..M-1] of integer;
        hijos: array [1..M] of integer;
    end;
    archivoDatos = file of dato;
    arbolB = file of nodo;
~~~

</details>

* ***Suponga que la estructura de datos que representa una persona (registro de persona) ocupa 64 bytes, que cada nodo del árbol B tiene un tamaño de 512 bytes y que los números enteros ocupan 4 bytes, ¿cuántos registros de persona entrarían en un nodo del árbol B? ¿Cuál sería el orden del árbol B en este caso (el valor de M)? Para resolver este inciso, puede utilizar la fórmula N = (M-1) * A + M * B + C, donde N es el tamaño del nodo (en bytes), A es el tamaño de un registro (en bytes), B es el tamaño de cada enlace a un hijo y C es el tamaño que ocupa el campo referido a la cantidad de claves. El objetivo es reemplazar estas variables con los valores dados y obtener el valor de M (M debe ser un número entero, ignorar la parte decimal).***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
N = tamaño del nodo en bytes ......... 512 bytes

A = tamaño del registro en bytes ..... 64 bytes

B = tamaño del enlace ................ 4 bytes

C = tamaño que ocupa cant_claves ..... (M-1-1) * 4 bytes = (M-2) * 4 bytes

FORMULA --> N = (M - 1) * A + M * B + C

            512 bytes = (M - 1) * 64 bytes + M * 4 bytes + (M - 2) * 4 bytes

            512 bytes + 64 bytes + 8 bytes = M * (64 bytes + 4 bytes + 4 bytes)

            M = 584 bytes / 72 bytes

            M = 8

RTA. El orden del árbol B en este caso sería de M = 8
~~~

</details>

* ***¿Qué impacto tiene sobre el valor de M organizar el archivo con toda la información de los alumnos como un árbol B?***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Organizar un archivo con toda la información como un árbol B puede tener varios impactos en el valor de M y en el rendimiento general del sistema:

**Búsqueda eficiente:** Los árboles B están diseñados para mantener un equilibrio entre la profundidad del árbol y el número de nodos por nivel, lo que permite búsquedas eficientes. Si el archivo se organiza como un árbol B, las operaciones de búsqueda, inserción y eliminación pueden realizarse en tiempo logarítmico en relación con el número de registros en el archivo, lo que mejora la eficiencia en comparación con otras estructuras de datos no balanceadas.

**Utilización eficiente del espacio:** Los árboles B tienen un alto grado de ocupación, lo que significa que los nodos están bastante llenos. Esto puede llevar a una mejor utilización del espacio en comparación con otras estructuras de datos, especialmente en archivos grandes con muchos registros.

**Costo de mantenimiento:** Sin embargo, mantener un árbol B puede ser costoso en términos de operaciones de inserción y eliminación, ya que estas operaciones pueden requerir reequilibrar el árbol, lo que implica redistribuir los elementos en los nodos y posiblemente dividir o fusionar nodos. El valor de M (el orden del árbol B) influye en la frecuencia y la gravedad de estas operaciones de reequilibrio. Un M más grande puede reducir la frecuencia de reequilibrio pero puede aumentar el tamaño de los nodos y, por lo tanto, el consumo de memoria.

**Optimización del acceso a disco:** Los árboles B también pueden ser útiles para optimizar el acceso a disco, ya que tienden a agrupar los datos de manera más compacta, lo que puede reducir la cantidad de operaciones de E/S (entrada/salida) necesarias para acceder a los datos dispersos en el archivo.

En resumen, organizar el archivo como un árbol B puede mejorar la eficiencia de las operaciones de búsqueda y acceso a datos, pero puede requerir un mayor costo de mantenimiento y una consideración cuidadosa del valor de M para optimizar el rendimiento en términos de espacio y tiempo de ejecución.

</details>

* ***¿Qué dato seleccionaría como clave de identificación para organizar los elementos (alumnos) en el árbol B? ¿Hay más de una opción?***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Podría ser el DNI o el legajo.

</details>

## ⚪ Punto 5

* ***Defina los siguientes conceptos:***

* **Overflow:** sucede cuando un nodo en un árbol B excede su capacidad máxima de  almacenamiento de claves. Cuando esto ocurre, se divide el nodo desbordado y se redistribuyen las claves entre los nodos resultantes para mantener el árbol balanceado.

* **Underflow:** sucede cuando un nodo en un árbol B tiene menos claves que el mínimo requerido. Esto puede ocurrir después de una eliminación, cuando el número de claves en un nodo cae por debajo del límite mínimo. Para corregir un subdesbordamiento, se puede realizar una redistribución de claves desde los nodos vecinos o fusionar el nodo subdesbordado con uno de sus vecinos.

* **Redistribución:** es un proceso en el que las claves se redistribuyen entre nodos contiguos para corregir un desbordamiento (overflow) o un subdesbordamiento (underflow). En el caso de un desbordamiento, algunas claves se mueven a un nuevo nodo creado, mientras que en el caso de un subdesbordamiento, algunas claves se transfieren desde un nodo vecino para equilibrar el número de claves entre los nodos.

* **Fusión o concatenación:** en el contexto de los árboles B, la fusión o concatenación ocurre cuando dos nodos contiguos tienen un número insuficiente de claves y se combinan en un solo nodo. Durante este proceso, se elimina una clave del padre común de los nodos fusionados y se ajustan los punteros. Esto ayuda a mantener la estructura del árbol balanceada y eficiente.

</details>

## ⚪ Punto 6

***Suponga que se tiene un archivo que contiene información de los empleados de una empresa. De cada empleado se mantiene la siguiente información: DNI, legajo, nombre completo y salario. Considere que se mantiene además un índice, organizado como árbol B de orden 4, que provee acceso indizado a los empleados por su DNI. Grafique como queda el archivo de empleados (archivo de datos) y el archivo índice (árbol B) tras la inserción de los registros dados.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Click [<code>AQUI</code>](/practica4/ejercicio06.pdf) para ver el árbol graficado.

</details>

## ⚪ Punto 7

***Dado el siguiente árbol B de orden 5, mostrar cómo quedaría el mismo luego de realizar las siguientes operaciones: +320, -390, -400, -533. Justificar detalladamente cada operación indicando lecturas y escrituras en orden de ocurrencia. Para la resolución de underflow debe utilizar política a izquierda. Graficar cada operación por separado.***

![imagen](/recursos/img01.png)

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Click [<code>AQUI</code>](/practica4/ejercicio07.pdf) para ver el árbol graficado.

</details>

## ⚪ Punto 8

***Dado el siguiente árbol B de orden 4, mostrar cómo quedaría el mismo luego de realizar las siguientes operaciones: +5, +9, +80, +51, -50, -92. Política de resolución de underflows: derecha.***

![imagen](/recursos/img02.png)

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Click [<code>AQUI</code>](/practica4/ejercicio08.pdf) para ver el árbol graficado.

</details>

## ⚪ Punto 9

***Dado el siguiente árbol B de orden 6, mostrar cómo quedaría el mismo luego de realizar las siguientes operaciones: +15, +71, +3, +48, -56, -71. Política de resolución de underflows: derecha o izquierda.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Click [<code>AQUI</code>](/practica4/ejercicio09.pdf) para ver el árbol graficado.

</details>

## ⚪ Punto 10

***Dado el siguiente árbol B de orden 5, mostrar cómo quedaría el mismo luego de realizar las siguientes operaciones: +450, -485, -511, -614. Política de resolución de underflows: derecha.***

![imagen](/recursos/img03.png)

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Click [<code>AQUI</code>](/practica4/ejercicio10.pdf) para ver el árbol graficado.

</details>

## ⚪ Punto 11

***Dado un árbol B de orden 5 y con política izquierda, para cada operación dada: dibuje el árbol resultante, explique las decisiones tomadas y escriba las lecturas y escrituras.***

***Operaciones: -76, -400, +900, +12***

~~~
nodo 2: 3 i 0(76)4(300)1(600)3
nodo 0: 4 h(21)(45)(46)(70)
nodo 4: 2 h(100)(200)
nodo 1: 1 h(400)
nodo 3: 2 h(700)(800)
~~~

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Click [<code>AQUI</code>](/practica4/ejercicio11.pdf) para ver el árbol graficado.

</details>

## ⚪ Punto 16

***Dado el siguiente árbol B + de orden 4 y con política de resolución de underflows a derecha, realice las siguientes operaciones indicando lecturas y escrituras en el orden de ocurrencia. Además, debe describir detalladamente lo que sucede en cada operación. +80, -400.***

![imagen](/recursos/img04.png)

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Click [<code>AQUI</code>](/practica4/ejercicio16.pdf) para ver el árbol graficado.

</details>

## ⚪ Punto 17

***Dado el siguiente árbol B+ de orden 4, mostrar como quedaría el mismo luego de realizar las siguientes operaciones: +120, +110, +52, +70, +15, -45, -52, +22, +19, -66, -22, -19, - 23, -89. Política de resolución de underflows: derecha.***

![imagen](/recursos/img05.png)

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Click [<code>AQUI</code>](/practica4/ejercicio17.pdf) para ver el árbol graficado.

</details>

## ⚪ Punto 18

***Dada las siguientes operaciones, mostrar la construcción paso a paso de un árbol B+ de orden 4: +67, +56, +96, +10, +28, +95, +16, +46, +23, +36, +120, +130, +60, +57, -96, -67, -95, -60, -120, -57, -56. Política de resolución de underflows: derecha o izquierda.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Arbol B+ - Orden 4 - Política de resolución de underflows: derecha o izquierda.

* **+67 +56 +96**

L/E [+67]= E0

L/E [+56]= L0 E0

L/E [+96]= L0 E0 

~~~
0:(56)(67)(96)-1
~~~

* **+10** --> OVERFLOW en nodo 0. Se genera nodo 1, promoción de clave 67 y nueva raiz (se genera nodo 2). Se incrementa la altura del arbol.

L/E [+10]= L0 E0 E1 E2

~~~
        2:0(67)1
0:(10)(56)1   1:(67)(96)-1
~~~

* **+28 +95**

L/E [+28]= L2 L0 E0

L/E [+95]= L2 L0 E1

~~~
            2:0(67)1
0:(10)(28)(56)1   1:(67)(95)(96)-1
~~~

* **+16** --> OVERFLOW en nodo 0. Se genera nodo 3 y promueve clave 28 a nodo 2.

L/E [+16]= L2 L0 E0 E3 E2

~~~
             2:0(28)3(67)1
0:(10)(16)3   3:(28)(56)1   1:(67)(95)(96)-1
~~~

* **+46 +23**

L/E [+46]= L2 L3 E3

L/E [+23]= L2 L0 E0

~~~
                   2:0(28)3(67)1
0:(10)(16)(23)3   3:(28)(46)(56)1   1:(67)(95)(96)-1
~~~

* **+36** --> OVERFLOW en nodo 3. Se genera nodo 4 y promueve clave 46 a nodo 2.

L/E [+36]= L2 L3 E3 E4 E2

~~~
                    2:0(28)3(46)4(67)1
0:(10)(16)(23)3   3:(28)(36)4   4:(46)(56)1   1:(67)(95)(96)-1
~~~

* **+120** --> OVERFLOW en nodo 1. Se genera nodo 5 y promueve clave 96. Se propaga el OVERFLOW a nodo 2, se genera nodo 6 y promoción de clave 67: Nueva raiz. Se genera nodo 7 e incrementa la altura del arbol.

L/E [+120]= L2 L1 E1 E5 E2 E6 E7

~~~
                                      7:2(67)6
                 2:0(28)3(46)4                        6:1(96)5
0:(10)(16)(23)3   3:(28)(36)4   4:(46)(56)1   1:(67)(95)5   5:(96)(120)-1
~~~

* **+130 +60** 

L/E [+130]= L7 L6 L5 E5

L/E [+60]= L7 L6 L4 E4

~~~
                                      7:2(67)6
                 2:0(28)3(46)4                        6:1(96)5
0:(10)(16)(23)3   3:(28)(36)4   4:(46)(56)(60)1   1:(67)(95)5   5:(96)(120)(130)-1
~~~

* **+57** --> OVERFLOW en nodo 4. Se genera nodo 8 y promoción de clave 57

L/E [+57]= L7 L2 L4 E4 E8 E2

~~~
                                      7:2(67)6
                      2:0(28)3(46)4(57)8                            6:1(96)5
0:(10)(16)(23)3   3:(28)(36)4   4:(46)(56)8   8:(57)(60)1   1:(67)(95)5   5:(96)(120)(130)-1
~~~

* **-96 -67**

L/E [-96]= L7 L2 L5 E5

L/E [-67]= L7 L2 L1 E1

~~~
                                      7:2(67)6
                      2:0(28)3(46)4(57)8                        6:1(96)5
0:(10)(16)(23)3   3:(28)(36)4   4:(46)(56)8   8:(57)(60)1   1:(95)5   5:(120)(130)-1
~~~

* **-95** --> UNDERFLOW en nodo 1. Se redistribuye con hermano derecho.

L/E [-95]= L7 L2 L1 L5 E1 E5 E6

~~~
                                      7:2(67)6
                      2:0(28)3(46)4(57)8                        6:1(130)5
0:(10)(16)(23)3   3:(28)(36)4   4:(46)(56)8   8:(57)(60)1   1:(120)5   5:(130)-1
~~~

* **-60**

L/E [-60]= L7 L2 L8 E8

~~~
                                      7:2(67)6
                      2:0(28)3(46)4(57)8                     6:1(130)5
0:(10)(16)(23)3   3:(28)(36)4   4:(46)(56)8   8:(57)1   1:(120)5   5:(130)-1
~~~

* **-120** --> UNDERFLOW en nodo 1. Se Busca redistribuir por izquierda y por derecha pero no se puede pues el nodo hermano derecho tiene el minimo de claves y no hay nodo hermano izquierdo. Se fusiona liberando el nodo 5. Se propaga el UNDERFLOW a nodo 6. Redistribución entre nodo 2 6 y 7, promoción de clave 57 como nueva raiz.

L/E [-120]= L7 L6 L1 L5 E1 L2 E2 E6 E7

~~~
                                    7:2(57)6
                 2:0(28)3(46)4                    6:8(67)1
0:(10)(16)(23)3   3:(28)(36)4   4:(46)(56)8   8:(57)1   1:(130)-1
~~~

* **-57** --> UNDERFLOW en nodo 8. Se Busca redistribuir por izquierda y por derecha pero no se puede pues el nodo hermano derecho tiene el minimo de claves y no hay nodo hermano izquierdo. Se fusiona liberando el nodo 1. Se propaga el UNDERFLOW a nodo 6. Redistribución entre nodo 2 6 y 7, promoción de clave 46 como nueva raiz.

L/E [-57]= L7 L6 L8 L1 E8 L2 E2 E6 E7

~~~
                         7:2(46)6
            2:0(28)3                    6:4(57)8
0:(10)(16)(23)3   3:(28)(36)4   4:(46)(56)8   8:(130)-1
~~~

* **-56**

L/E [-57]= L7 L6 L4 E4

~~~
                        7:2(46)6
            2:0(28)3                6:4(57)8
0:(10)(16)(23)3   3:(28)(36)4   4:(46)8   8:(130)-1
~~~

</details>

<p align=center>⚪</p>
<p align=center>⚪</p>
<p align=center>⚪</p>

>[!NOTE]
>
> * ***Para descargar la practica (del 2024) en PDF, click [<code>AQUÍ</code>](https://drive.google.com/file/d/1ByjnQMO8Wgwq-xfp93bbTx7Fqd7yWdW2/view?usp=sharing).***


<br>
<br>
<br>


<p><img align="center" src="https://github.com/Marimari2342/Marimari2342/blob/main/firmagith.png" alt="marigit"/></p>