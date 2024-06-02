# Fundamentos de la Organización de Datos - Practica 5


## 🟠 Punto 1

***Defina el concepto de hashing (o dispersión). ¿Cómo se relaciona este concepto con archivos?***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

El **HASHING** es una técnica para generar una dirección base única para una clave dada. Lo que hace es convertir la clave en un número aleatorio, que luego sirve para determinar donde se almacena la clave. Para esto, utiliza una función de dispersión que lo que hace es mapear cada clave con una dirección física de almacenamiento. Es utilizada cuando se requiere acceso rápido por clave.

En el contexto de archivos, el hashing se utiliza para generar un valor único que representa el contenido del archivo. Esto es útil para varias aplicaciones, incluida la verificación de la integridad de los datos, la detección de duplicados, la identificación rápida de archivos idénticos y la seguridad.

</details>

## 🟠 Punto 2

***Explique el concepto de función de dispersión. Enumere al menos tres funciones de dispersión y explique brevemente cómo funciona cada una.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

**FUNCIÓN DE DISPERSIÓN:** caja negra que a partir de una clave genera la dirección física donde debe almacenarse el registro. La función de dispersión o hash lo que hace es tomar una entrada y generar un valor de hash único, que se utiliza para identificar o verificar la integridad de los datos. La elección de la función de hash depende de los requisitos específicos de seguridad y rendimiento de la aplicación.

</details>

## 🟠 Punto 3

***Explique los conceptos de sinónimo, colisión y desborde (overflow). ¿Qué condición es necesaria en el archivo directo para que pueda ocurrir una colisión y no un desborde?***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

El concepto de **SINÓNIMO** se refiere a dos o más claves diferentes que tienen el mismo valor de dispersión. Esto puede ocurrir cuando la función de dispersión utilizada para mapear las claves a ubicaciones en una tabla hash produce el mismo resultado para múltiples claves diferentes.

La **COLISIÓN** es una situación en la que un registro es asignado, por función de dispersión, a una dirección que ya posee uno o más registros. Las colisiones son inevitables en las tablas hash, especialmente cuando el espacio de claves es más grande que el espacio de valores hash posible.

El **DESBORDE** se da cuando una clave carece de lugar en la dirección asignada por la función de dispersion. 

Para que ocurra una colisión en lugar de un desbordamiento en un archivo directo, es necesario que la ubicación calculada para el nuevo registro esté disponible, pero haya otro registro existente con el mismo valor de dispersión que ya ocupa esa ubicación. En otras palabras, la colisión implica que hay múltiples registros que se mapean a la misma ubicación, mientras que el desbordamiento ocurre cuando un solo registro no puede caber en una ubicación determinada debido a la falta de espacio.

</details>

## 🟠 Punto 4

***¿Qué alternativas existen para reducir el número de colisiones (y por ende de desbordes) en un archivo organizado mediante la técnica de hashing?***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~

~~~

</details>

## 🟠 Punto 5

***Explique brevemente qué es la densidad de empaquetamiento. ¿Cuáles son las consecuencias de tener una menor densidad de empaquetamiento en un archivo directo?***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

La **DENSIDAD DE EMPAQUETAMIENTO** es la relación entre el espacio disponible para el archivo de datos y la cantidad de registros que integran el mismo. La fórmula de la densidad de empaquetamiento es:

~~~
DE = num_registros / espacio_total
~~~

En general, una menor densidad de empaquetamiento en un archivo directo puede llevar a un uso ineficiente de recursos de almacenamiento y una degradación del rendimiento en términos de acceso y transferencia de datos. Por lo tanto, es importante optimizar la densidad de empaquetamiento al diseñar y trabajar con archivos para maximizar la eficiencia y el rendimiento del sistema.

</details>

## 🟠 Punto 6

***Explique brevemente cómo funcionan las siguientes técnicas de resolución de desbordes que se pueden utilizar en hashing estático.***

* ***Saturación progresiva***

* ***Saturación progresiva encadenada***

* ***Saturación progresiva encadenada con área de desborde separada***

* ***Dispersión doble***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~

~~~

</details>

<p align=center>🟠</p>
<p align=center>🟠</p>
<p align=center>🟠</p>

>[!NOTE]
>
> * ***Para descargar la practica (del 2024) en PDF, click [<code>AQUÍ</code>](https://drive.google.com/file/d/1k_4-_X96sVBPjACQnMyVObOE7YLCnP0a/view?usp=sharing).***


<br>
<br>
<br>


<p><img align="center" src="https://github.com/Marimari2342/Marimari2342/blob/main/firmagith.png" alt="marigit"/></p>