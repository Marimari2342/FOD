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

Hay varias estrategias que se pueden utilizar para reducir el número de colisiones en un archivo organizado mediante la técnica de hashing:

* Utilizar funciones de hash bien diseñadas para minimizar las colisiones al producir valores de dispersión que están distribuidos de manera más uniforme.

* Ajustar el tamaño de la tabla hash de manera adecuada puede ayudar a reducir las colisiones. Si la tabla hash es demasiado pequeña en relación con el número de elementos que se espera almacenar, aumenta la probabilidad de colisiones. Por otro lado, si es demasiado grande, puede haber un desperdicio de memoria.

* Utilizar técnicas de resolución de colisiones efectivas para mitigar los efectos de las colisiones.

* Hashing dinámico: Implementar una estrategia de dispersión dinámica puede ser útil para ajustar dinámicamente el tamaño de la tabla hash en función del número de elementos y la tasa de colisiones. Esto implica volver a calcular la función de hash y reorganizar los elementos en una tabla hash más grande cuando la tasa de colisiones supera un umbral predefinido.

* Diseño de la función de hash específica para los datos: En algunos casos, diseñar una función de hash específica para los datos en cuestión puede ayudar a reducir las colisiones.

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

Los métodos aplicables para resolver colisiones con desbordes en dispersión estática son:

* **Saturación Progresiva**: En esta técnica, cuando se produce un desbordamiento en una posición de la tabla hash, se busca la siguiente posición disponible en la tabla hasta que se encuentra una vacía. Esto implica que cada celda de la tabla hash se verifica secuencialmente en busca de espacio adicional cuando ocurre un desbordamiento. Si se llega al final de la tabla sin encontrar espacio, el desbordamiento no se puede manejar y se produce un error de "tabla llena".

* **Saturación Progresiva Encadenada**: En este enfoque, cada celda de la tabla hash contiene una lista enlazada de elementos que han sido mapeados a esa posición. Cuando se produce un desbordamiento, el nuevo elemento se agrega a la lista enlazada correspondiente a esa celda. Esto permite manejar colisiones sin límite de tamaño de la tabla hash, ya que se pueden agregar elementos adicionales a las listas enlazadas según sea necesario.

* **Saturación Progresiva Encadenada con Área de Desborde Separada**: Esta técnica es similar a la saturación progresiva encadenada, pero con una diferencia importante: cuando una celda de la tabla hash se llena y ya no puede contener más elementos, se utiliza una "área de desborde separada" para almacenar los elementos adicionales que causaron la colisión. Esto garantiza que las colisiones se puedan manejar de manera más eficiente sin afectar el rendimiento de las operaciones de búsqueda.

* **Dispersión Doble**: En este método, cuando ocurre una colisión, se utiliza una segunda función de hash para calcular una nueva ubicación en la tabla hash donde se puede almacenar el elemento. Esta segunda función de hash se utiliza como un "paso" adicional cuando se encuentra una colisión, lo que ayuda a distribuir los elementos de manera más uniforme en la tabla hash y reduce la probabilidad de colisiones.

</details>

## 🟠 Punto 7

***Para las siguientes claves, realice el proceso de dispersión mediante el método de hashing extensible, sabiendo que cada nodo tiene capacidad para dos registros. El número natural indica el orden de llegada de las claves. Se debe mostrar el estado del archivo para cada operación. Justifique brevemente ante colisión y desborde los pasos que realiza.***

![imagen](/recursos/img06.png)

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Click [<code>AQUI</code>](/practica5/ejercicio07.pdf) para ver el ejercicio resuelto.

</details>

## 🟠 Punto 8

***Realice el proceso de dispersión mediante el método de hashing extensible, sabiendo que cada registro tiene capacidad para dos claves. El número natural indica el orden de llegada de las mismas. Se debe mostrar el estado del archivo para cada operación. Justifique brevemente ante colisión y desborde los pasos que realiza.***

![imagen](/recursos/img07.png)

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Click [<code>AQUI</code>](/practica5/ejercicio08.pdf) para ver el ejercicio resuelto.

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