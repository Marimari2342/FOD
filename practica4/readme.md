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