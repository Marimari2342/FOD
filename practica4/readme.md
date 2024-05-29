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

## ⚪ Punto 4

* ***Defina los siguientes conceptos:***

En los dos últimos casos, ¿cuándo se aplica cada uno?

* **Overflow**

* **Underflow**

* **Redistribución** 

* **Fusión o concatenación**

</details>



<details><summary> <code> Respuesta 🖱 </code></summary><br>

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