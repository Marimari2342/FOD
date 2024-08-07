# Repaso para el examen teórico para la promoción

## Primer Simulacro del Examen 2024

***Las respuestas correctas suman un punto, las incorrectas restan 0,5. Sin responder es neutro. Cada ejercicio tiene un y solo un inciso correcto.***

<br>

***1. Un archivo serie***

* ***(a) ✔️ Tiene acceso secuencial y orden de búsqueda lineal.***

* (b) Tiene acceso secuencial indizado y orden de búsqueda logarítmico.

* (c) Tiene acceso secuencial y orden de búsqueda constante.

* (d) Tiene acceso secuencial indizado y orden de búsqueda lineal.

* (e) Todas las anteriores.

* (f) Algunas de las anteriores.

* (g) Ninguna de las anteriores.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="justify">Un archivo serie no tiene ningún orden preestablecido más que el físico, donde, para acceder a un registro determinado, se deben visitar todos los registros previos en el orden en que estos fueron almacenados. Aquí, la búsqueda de un dato específico es lineal, puesto que se detiene en el registro que contiene ese dato (previo acceso a todos los registros anteriores), o en el final del archivo si el resultado no es exitoso (el dato no se encuentra).</p>

<p align="center">__________</p>

</details><br>

***2. Un proceso de actualización de un archivo con n archivos***

* (a) Se puede aplicar con todos los archivos ordenados por algún criterio.

* (b) Se puede aplicar con todos los archivos desordenados.

* (c) Se puede aplicar con algunos de los archivos ordenados por algún criterio y el resto desordenados.

* (d) Se puede aplicar con cada uno de los n archivos ordenados por diferentes criterios.

* ***(e) ✔️ Todas las anteriores son válidas.***

* (f) Algunas de las anteriores son válidas.

* (g) Ninguna de las anteriores son válidas.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="justify">Se puede aplicar con todos los archivos ordenados por algún criterio: no es estrictamente necesario que esto se cumpla pero si los archivos detalles estan ordenados puedo aplicar un proceso de actualización del archivo. Por esto mismo es que podemos decir que, ya que no siempre es necesario que los detalles estén ordenados, podemos aplicar un proceso de actualización de un archivo en caso de que todos los detalles esten desordenados, puesto que algunos algoritmos de merge pueden funcionar eficientemente con detalles desordenados, aunque la ordenación puede mejorar la eficiencia del proceso en ciertos casos.</p>

<p align="center">__________</p>

</details><br>

***3. Si se realiza la baja de un registro en un archivo secuencial indizado***

* (a) Es igual de eficiente hacer una baja lógica que una baja física.

* (b) Es más eficiente hacer una baja lógica que una baja física.

* (c) Es menos eficiente hacer una baja lógica que una baja física.

* ***(d) ✔️ Ninguna de las anteriores.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="justify">Se denomina archivo con acceso secuencial indizado a aquel que permite dos formas para visualizar la información --> <n>Indizada:</n> el archivo puede verse como un conjunto de registros ordenados por una clave o llave. <n>Secuencial:</n> se puede acceder secuencialmente al archivo, con registros físicamente contiguos y ordenados nuevamente por una clave o llave.</p>

<p align="justify">En términos de espacio ocupado, baja física es más eficiente porque libera el espacio inmediatamente. La baja lógica puede ser más eficiente en términos de tiempo y simplicidad de implementación, pero a costa de un mayor espacio ocupado y posible fragmentación lógica a lo largo del tiempo. La elección entre baja lógica y baja física depende del contexto y de las prioridades específicas de rendimiento y gestión de espacio de tu aplicación. Por lo tanto no podemos determinar cuándo será más eficiente una baja física que una lógica con la información dada.</p>

<p align="center">__________</p>

</details><br>

***4. Un archivo con registros de longitud variable***

* (a) Ocupa más espacio que el mismo archivo con registros de longitud física.

* (b) Ocupa el mismo espacio que el mismo archivo con registros de longitud física.

* (c) Ocupa menos espacio que el mismo archivo con registros de longitud física.

* ***(d) ✔️ No tengo datos suficientes para contestar.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***5. Para poder realizar un algoritmo de corte de control sobre un archivo***

* (a) Es suficiente que el archivo este ordenado por al menos un criterio.

* (b) Es necesario que el archivo este ordenado por al menos un criterio.

* (c) Es suficiente que el archivo este ordenado por al menos dos criterios.

* (d) Es necesario que el archivo este ordenado por al menos dos criterios.

* (e) Todas las anteriores son válidas.

* ***(f) ✔️ Algunas de las anteriores son válidas.***

* (g) Ninguna de las anteriores son válidas.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***6. Una clave secundaria***

* (a) Identifica unívocamente un elemento del archivo.

* (b) Identifica unívocamente varios elementos de un archivo.

* ***(c) ✔️ Está constituida por al menos un atributo del archivo donde está definida.***

* (d) Todas las anteriores son válidas.

* (e) Algunas de las anteriores son válidas.

* (f) Ninguna de las anteriores son válidas.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***7. Un índice***

* (a) Se implementa con un vector.

* (b) Se implementa con un árbol primario.

* (c) Se implementa con un árbol B.

* (d) Se implementa con un árbol B+.

* (e) Todas las anteriores son válidas.

* (f) Algunas de las anteriores son válidas.

* ***(g) ✔️ Ninguna de las anteriores son válidas.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="justify">Pues "se implementa" ≠ "se puede implementar" (es decir, no siempre se implementa, pero puede implementarse).</p>

<p align="center">__________</p>

</details><br>

***8. Un árbol binario paginado***

* (a) Puede desbalancearse.

* (b) Puede estar balanceado.

* (c) Puede no estar balanceado.

* ***(d) ✔️ Todas las anteriores son válidas.***

* (e) Algunas de las anteriores son válidas.

* (f) Ninguna de las anteriores son válidas.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***9. Dado un índice de un archivo. Para un momento determinado***

* (a) Si se implementó con árbol B tiene mayor altura que si se implementó con un árbol B+.

* (b) Si se implementó con árbol B tiene igual altura que si se implementó con un árbol B+.

* (c) Si se implementó con árbol B tiene menor altura que si se implementó con un árbol B+.

* ***(d) ✔️ No tengo datos suficientes para responder.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***10. Un árbol multicambio***

* (a) Es un árbol binario.

* (b) Es un árbol AVL.

* (c) Es un árbol B+.

* (d) Todas las anteriores son válidas.

* (e) Algunas de las anteriores son válidas.

* ***(f) ✔️ Ninguna de las anteriores son válidas.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="justify">No es ni un árbol binario ni un árbol AVL y "no necesariamente" es un árbol B+.</p>

<p align="center">__________</p>

</details><br>

***11. El acceso directo a un elemento de datos es***

* (a) Más eficiente que el acceso secuencial.

* (b) Más eficiente que el acceso secuencial indizado.

* (c) Más eficiente que utilizar un árbol B+.

* ***(d) ✔️ Todas las anteriores son válidas.***

* (e) Algunas de las anteriores son válidas.

* (f) Ninguna de las anteriores son válidas.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***12. Una función de Hash en teoría debe ser***

* ***(a) ✔️ Uniforme y aleatoria.***

* (b) Uniforme pero no aleatoria.

* (c) Aleatoria pero no uniforme.

* (d) No debe ser ni uniforme ni aleatoria.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***13. La densidad de empaquetamiento***

* (a) Mide la relación entre espacio disponible y espacio utilizado.

* (b) Mide la relación entre la capacidad de registros que tiene un archivo y la capacidad de almacenamiento disponible para el mismo.

* (c) Es el cociente entre el número de registros del archivo y el espacio disponible.

* ***(d) ✔️ Todas las anteriores son válidas.***

* (e) Algunas de las anteriores son válidas.

* (f) Ninguna de las anteriores son válidas.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="justify">Se define la Densidad de Empaquetamiento (DE) como la relación entre el espacio disponible para el archivo de datos y la cantidad de registros que integran dicho archivo.</p>

<p align="justify">La DE es la razón entre la cantidad de registros que componen un archivo (r) y el espacio disponible para almacenar ese archivo. El espacio disponible se define como la cantidad de nodos direccionables (n) por la función de hash, y la cantidad de registros que cada nodo puede almacenar, Registros por Nodo (RPN).</p>

La fórmula es --> DE = r/n*RPN

(Bertone, Thomas - pp161)

<p align="center">__________</p>

</details><br>

***14. Cuando se produce una inserción en Hash estático, sobre el archivo de datos***

* (a) Se realiza una operación de escritura y una de lectura.

* ***(b) ✔️ Se realiza al menos una operación de escritura y al menos una de lectura.***

* (c) Se realiza una operación de lectura y al menos una de escritura.

* (d) Se realiza una operación de escritura y al menos una de lectura.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="justify">En un hash estático, las operaciones de inserción no son simplemente agregar un nuevo registro al archivo de datos. Requieren al menos una lectura para determinar la ubicación adecuada del nuevo registro en el archivo y al menos una escritura para agregar el nuevo registro en esa posición determinada. Si la inserción provoca que la tabla de dispersión o cualquier estructura de índice se vea afectada, puede ser necesario realizar operaciones adicionales, como la reorganización de la tabla de dispersión o la reubicación de registros en el archivo de datos para mantener la eficiencia del acceso (por eso es "al menos", siempre hay al menos una operación de L y otra de E, pero no necesariamente es una sola operación de L/E).</p>

<p align="center">__________</p>

</details><br>

***15. En Hashing extensible, cuando la densidad de empaquetamiento tiende a 1***

* (a) Se debe pasar de Hash estático a dinámico.

* (b) Se debe reformular el tamaño del nodo.

* (c) Se deben aumentar la cantidad de registros por nodo.

* (d) Algunas de las anteriores.

* ***(e) ✔️ Ninguna de las anteriores.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="justify">Cuanto mayor sea la DE, mayor será la posibilidad de colisiones, dado que en ese caso se dispone de menos espacio para esparcir registros (Bertone, Thomas - pp161).</p>

<p align="justify">Por eso, cuando la densidad de empaquetamiento tiende a 1 en Hashing extensible, las colisiones se vuelven más frecuentes y el tiempo de acceso a los elementos puede aumentar, lo que reduce la eficiencia de la tabla de Hash.</p>

<p align="center">__________</p>

</details><br>

<p align="center">🔵🔵🔵🔵🔵🔵</p>

## Segundo Simulacro del Examen 2024

***Las respuestas correctas suman un punto, las incorrectas restan 0,5. Sin responder es neutro. Cada ejercicio tiene un y solo un inciso correcto.***

<br>

***1. Un archivo directo***

* (a) Tiene acceso Directo y orden de búsqueda lineal.

* (b) Tiene acceso Directo y orden de búsqueda logarítmico.

* (c) Tiene acceso Directo y orden de búsqueda exponencial.

* (d) Todas las anteriores.

* (e) Algunas de las anteriores.

* ***(f) ✔️ Ninguna de las anteriores.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***2. Un proceso de merge de n archivos, para que sea lo más eficiente posible en términos de rendimiento / performance***

* (a) Se debe aplicar con todos los archivos ordenados por algún criterio.

* (b) Se debe aplicar con todos los archivos desordenados.

* (c) Se debe aplicar con algunos de los archivos ordenados por algún criterio y el resto desordenados.

* (d) Se debe aplicar con cada uno de los archivos ordenados por diferentes criterios.

* (e) Todas las anteriores.

* (f) Algunas de las anteriores.

* ***(g) ✔️ Ninguna de las anteriores.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***3. Si se realiza la baja de un registro en un archivo directo***

* (a) Es igual de eficiente hacer una baja lógica que una baja física.

* (b) Es más de eficiente hacer una baja lógica que una baja física considerando el espacio ocupado.

* (c) Es menos de eficiente hacer una baja lógica que una baja física considerando el rendimiento / performance.

* ***(d) ✔️ Ninguna de las anteriores.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***4. Un archivo directo con registros de longitud variable***

* (a) Puede ocupar más espacio que el mismo archivo con registros de longitud física.

* (b) Puede ocupar el mismo espacio que el mismo archivo con registros de longitud física.

* (c) Ocupa menos espacio que el mismo archivo con registros de longitud física.

* ***(d) ✔️ Ninguna de las anteriores.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***5. Para poder realizar un algoritmo de bajas sobre un archivo***

* (a) Es suficiente que el archivo este ordenado por al menos un criterio.

* (b) Es necesario que el archivo este ordenado por al menos un criterio.

* (c) Es suficiente que el archivo este ordenado por al menos dos criterios.

* (d) Es necesario que el archivo este ordenado por al menos dos criterios.

* (e) Todas las anteriores son válidas.

* ***(f) ✔️ Algunas de las anteriores son válidas.***

* (g) Ninguna de las anteriores son válidas.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***6. Una clave***

* (a) Identifica unívocamente un elemento del archivo.

* (b) Identifica varios elementos de un archivo.

* (c) Está constituída por al menos dos atributos del archivo donde está definida.

* (d) Todas las anteriores son válidas.

* (e) Algunas de las anteriores son válidas.

* ***(f) ✔️ Ninguna de las anteriores son válidas.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***7. Un índice secundario implementado con un árbol binario***

* (a) Puede desbalancearse.

* (b) Puede estar balanceado.

* (c) Puede balancearse.

* (d) Se desbalancea facilmente.

* (e) Todas las anteriores son válidas.

* (f) Algunas de las anteriores son válidas.

* ***(g) ✔️ Ninguna de las anteriores son válidas.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***8. Un árbol***

* (a) Puede desbalancearse.

* (b) Puede estar balanceado.

* (c) Está balanceado en altura.

* (d) Puede no estar balanceado.

* (e) Todas las anteriores son válidas.

* ***(f) ✔️ Algunas de las anteriores son válidas.***

* (g) Ninguna de las anteriores son válidas.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***9. Dado un índice de un archivo con registros de longitud variable***

* (a) Sus registros pueden ser de longitud variable.

* (b) Sus registros deben ser de longitud variable.

* (c) Sus registros pueden ser de longitud fija.

* ***(d) ✔️ Sus registros son de longitud fija.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***10. Un árbol***

* ***(a) ✔️ Puede ser árbol binario y AVL.***

* (b) Puede ser B* y B+.

* (c) Puede ser B y B+.

* (d) Todas las anteriores son válidas.

* (e) Algunas de las anteriores son válidas.

* (f) Ninguna de las anteriores son válidas.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***11. La saturación progresiva encadenada***

* (a) Se usa en caso de coalisión.

* (b) Se usa en caso de coalisión y saturación.

* (c) Se usa en caso de saturación.

* (d) Se puede usar en caso de saturación.

* (e) Todas las anteriores son válidas.

* (f) Algunas de las anteriores son válidas.

* (g) Ninguna de las anteriores son válidas.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***12. Una función de hash uniforme y aleatoria***

* ***(a) ✔️ Tiene un promedio 1, de acceso a registros.***

* (b) Tiene un promedio entre 1 y 2, de acceso a registros.

* (c) Tiene un promedio menor a 1, de acceso a registros.

* (d) Ninguna de las anteriores son válidas.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***13. La densidad de empaquetamiento***

* (a) Se modifica con cada alta o baja, utilizando hashing extensible.

* (b) Se modifica con cada alta, utilizando hashing extensible.

* (c) Se modifica con cada baja, utilizando hashing extensible.

* (d) No se modifica con altas o bajas, utilizando hashing extensible.

* (e) Todas las anteriores son válidas.

* (f) Algunas de las anteriores son válidas.

* ***(g) ✔️ Ninguna de las anteriores son válidas.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***14. Cuando se produce una inserción en hash estático, sobre el archivo de datos***

* (a) Se realiza una operación de escritura y una de lectura.

* ***(b) ✔️ Se realiza al menos una operación de escritura y al menos una de lectura.***

* (c) Se realiza una operación de lectura y al menos una de escritura.

* (d) Se realiza una operación de escritura y al menos una de lectura.

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>

***15. Si hubo coalisión con hashing dinámico***

* (a) Ocurre Overflow.

* (b) No ocurre Overflow.

* (c) Se trata con un regimen específico de tratamiento de coalisiones.

* (d) Algunas de las anteriores.

* ***(e) ✔️ Ninguna de las anteriores.***

<details><summary> <code> Nota 🖱 </code></summary><br>

<p align="center">__________</p>

</details><br>



<p align="center">🔵🔵🔵🔵🔵🔵</p>

>[!NOTE]
>Se aprueba con 5 (necesito 7.5 puntos como mínimo).
>
