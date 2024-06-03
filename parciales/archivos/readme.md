# Fundamentos de la Organización de Datos <br> PARCIALES DE ARCHIVOS

## 🟠 Examen 1 (2019 - 1F)

***Una empresa que comercializa fármacos recibe de cada una de sus 30 sucursales un resumen mensual de las ventas y desea analizar la información para la toma de futuras decisiones. El formato de los archivos que recibe la empresa es: cod_farmaco, nombre, fecha, cantidad_vendida, forma_pago (campo String indicando contado o tarjeta).***

***Los archivos de ventas están ordenados por cod_farmaco y fecha.***

***Cada sucursal puede vender cero, uno o más veces determinado fármaco el mismo día, y la forma de pago podría variar en cada venta. Realizar los siguientes procedimientos:***

* ***Recibe los 30 archivos de ventas e informa por pantalla el fármaco con mayor cantidad_vendida.***

* ***Recibe los 30 archivos de ventas y guarda en un archivo de texto un resumen de ventas por fecha y fármaco con el siguiente formato: cod_farmaco, nombre, fecha, cantidad_total_vendida (el archivo de texto deberá estar organizado de manera tal que al tener que utilizarlo pueda recorrer el archivo realizando la menor cantidad de lecturas posibles).***

***NOTA: en el archivo de texto por fecha, cada fármaco aparecerá a lo sumo una vez. Además de escribir cada procedimiento deberá declarar las estructuras de datos utilizados.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Examen 1 --> Para verlo completo ir a [*examen1.pas*](/parciales/archivos/examen1.pas)

</details>

## 🟠 Examen 2 (2017 - 3F)

***En la facultad de Ciencias Jurídicas existe un sistema a través del cual los alumnos del posgrado tienen la posibilidad de pagar las carreras en RapiPago. Cuando el alumno se inscribe a una carrera, se le imprime una chequera con seis códigos de barra para que pague las seis cuotas correspondientes. Existe un archivo que guarda la siguiente información de los alumnos inscriptos: dni_alumno, codigo_carrera y monto_total_pagado.***

***Todos los días RapiPago manda N archivos con información de los pagos realizados por los alumnos en las N sucursales. Cada sucursal puede registrar cero, uno o más pagos y un alumno puede pagar más de una cuota el mismo día. Los archivos que manda RapiPago tienen la siguiente información: dni_alumno, codigo_carrera, monto_cuota.***

* ***Se debe realizar un procedimiento que dado el archivo con información de los alumnos inscriptos y los N archivos que envía RapiPago, actualice la información de lo que ha pagado cada alumno hasta el momento en cada carrera inscripto.***

* ***Realice otro procedimiento que reciba el archivo con información de los alumnos inscriptos y genere un archivo de texto con los alumnos que aún no han pagado nada en las carreras que están inscriptos. El archivo de texto debe contener la siguiente información: dni_alumno, codigo_carrera y la leyenda “alumno moroso”. La organización de la información del archivo de texto debe ser tal de poder utilizarla en una futura importación de datos realizando la cantidad mínima de lecturas.***

***Precondiciones:***

***- Cada alumno puede estar inscrito en una o varias carreras.***

***- Todos los archivos están ordenados, primero por dni_alumno y luego por codigo_carrera.***

***- En los archivos que envía RapiPago hay información de pagos de alumnos que si o si existen en el archivo de inscriptos.***

***NOTA: Para ambos incisos debe definir todas las estructuras de datos utilizados.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Examen 2 --> Para verlo completo ir a [*examen2.pas*](/parciales/archivos/examen2.pas)

</details>

## 🟠 Examen 3 (2017 - 2F)

***Defina en no más de 5 renglones los conceptos de baja lógica y baja física. Enumere las ventajas y desventajas de la utilización de bajas físicas.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

**BAJA LÓGICA**: borro un registro del archivo sin recuperar espacio en disco. Para esto utilizo una marca (por ejemplo, un * adelante de un campo determinado). 
**BAJA FÍSICA**: borra un registro del archivo, recuperando el espacio físico, y decrementando la cantidad de elementos de mi archivo. 

</details>

***Suponga que tiene un archivo que contiene información de los sistemas operativos más utilizados en la actualidad. Cada registro contiene los siguientes campos: nombre_sistema_operativo, cantidad_instalaciones, es_de_codigo_abierto (un sistema operativo puede ser de código abierto o no), tipo_licencia (GPL, BSD, MPL, etc.). Realice los siguientes procedimientos utilizando el registro cabecera para implementar una lista invertida que permita la reasignación de espacio:***

* ***Alta de sistema operativo: recibe un registro con información de un sistema operativo y un archivo. Debe dar el alta el registro en el archivo reutilizando espacio libre en caso de que exista.***

* ***Baja de sistema operativo: recibe un registro con información de un sistema operativo y un archivo. Debe dar de baja el sistema operativo del archivo, en caso de que exista. De lo contrario debe informar que el sistema operativo no existe en el archivo. Tenga en cuenta que deberá dejar preparado el archivo para futuras altas con reasignación de espacio.***

***NOTA: Debe declarar todas las estructuras de datos utilizadas y el campo utilizado para el encadenamiento debe ser cantidad_instalaciones.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>



</details>

## 🟠 Examen 4 (2017 - 1F)

***Suponga que usted es administrador de un servidor de correo electrónico. Los logs del mismo (información guardada acerca de los movimientos que ocurren en el server) se encuentran en la ruta: /var/log/logsmall.dat, donde se guarda la siguiente información: número de usuario, nombre de usuario, nombre, apellido y cantidad de mails enviados. Diariamente el servidor de correo genera un archivo con la siguiente información: número de usuario, cuenta destino y cuerpo del mensaje. Este archivo representa todos los correos enviados por los usuarios de un día determinado.***

***Ambos archivos están ordenados por número de usuario, se sabe que un usuario puede enviar cero, uno o mas mails por dia y los usuarios que aparecen en el archivo de envíos diarios seguro existen el logmail.dat.***

* ***Dado el archivo 6junio2017.dat el cual contiene los movimientos del 6 de junio de 2017, realice el procedimiento necesario para actualizar la información del log.***

* ***Dado un archivo detalle 6junio2017.dat del punto anterior, realice un procedimiento que genere un archivo de texto llamado listado.txt con la siguiente información:***

~~~
nroUsuario nombreUsuario cantidadMensajesEnviados
...
nroUsuario nombreUsuario cantidadMensajesEnviados
nroUsuario nombreUsuario cantidadMensajesEnviados
~~~

***Debe realizar el programa principal con un menú que muestre las opciones necesarias para llevar a cabo ambos puntos. Debe incluir la declaración de todas las estructuras de datos y variables-necesarias.***

***NOTA: Tener en cuenta que el listado.txt deberán aparecer todos los usuarios que existen en el sistema.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Examen 4 --> Para verlo completo ir a [*examen4.pas*](/parciales/archivos/examen4.pas)

</details>

## 🟠 Examen 5 (2023 - 1F)

***Suponga que tiene un archivo con información referente a los empleados que trabajan en una multinacional. De cada empleado se conoce el dni (único), nombre, apellido, edad, domicilio y fecha de nacimiento. Se solicita hacer el mantenimiento de este archivo utilizando la técnica de reutilización de espacio llamada lista invertida. Declare las estructuras de datos necesarias e implemente los siguientes módulos:***

* ***Agregar empleado: solicita al usuario que ingrese los datos del empleado y lo agrega al archivo sólo si el dni ingresado no existe. Suponga que existe una función llamada existeEmpleado que recibe un dni y un archivo y devuelve verdadero si el dni existe en el archivo o falso en caso contrario. La función existeEmpleado no debe implementarla. Si el empleado ya existe, debe informarlo en pantalla.***

* ***Quitar empleado: solicita al usuario que ingrese un dni y lo elimina del archivo solo si este dni existe. Debe utilizar la función existeEmpleado. En caso de que el empleado no exista debe informarse en pantalla.***

***Nota: Los módulos que debe implementar deberán guardar en memoria secundaria todo
cambio que se produzca en el archivo.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>



</details>

## 🟠 Examen 6 (AComAC - Tema1)

***Se cuenta con un archivo que almacena información sobre los tipos de dinosaurios que habitaron durante la era mesozoica, de cada tipo se almacena: código, tipo de dinosaurio, altura y peso promedio, descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice un programa que elimine tipos de dinosaurios que estuvieron en el periodo jurásico de la era mesozoica. Para ello se recibe por teclado los códigos de los tipos a eliminar.***

***Las bajas se realizan apilando registros borrados y las altas reutilizando registros borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el número 0 en el campo código implica que no hay registros borrados y -N indica que el próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido. Dada la estructura planteada en el ejercicio, implemente los siguientes módulos: {Abre el archivo y agrega un tipo de dinosaurios, recibido como parámetro manteniendo la política descripta anteriormente}***

* ***procedure agregarDinosaurios (var a: tArchDinos ; registro: recordDinos);***

* ***Liste el contenido del archivo en un archivo de texto, omitiendo los tipos de dinosaurios eliminados. Modifique lo que considere necesario para obtener el listado.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>



</details>

## 🟠 Examen 7 (AComAC - Tema2)

***Se cuenta con un archivo que almacena información sobre los tipos de dinosaurios que habitaron durante la era mesozoica, de cada tipo se almacena: código, tipo de dinosaurio, altura y peso promedio, descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice un programa que elimine tipos de dinosaurios que estuvieron en el periodo jurásico de la era mesozoica. Para ello se recibe por teclado los códigos de los tipos a eliminar.***

***Las bajas se realizan apilando registros borrados y las altas reutilizando registros borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el número 0 en el campo código implica que no hay registros borrados y -N indica que el próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido. Dada la estructura planteada en el ejercicio, implemente los siguientes módulos: {Abre el archivo y elimina el tipo de dinosaurio recibido como parámetro manteniendo la política descripta anteriormente}***

* ***procedure eliminarDinos (var a: tArchDinos ; tipoDinosaurio: String);***

* ***Liste en un txt (archivo de texto) el contenido del archivo omitiendo los tipos de dinosaurios eliminados. Modifique lo que considere necesario para obtener el listado.***

***Nota: Las bajas deben finalizar al recibir el código 100000***

<details><summary> <code> Respuesta 🖱 </code></summary><br>



</details>

## 🟠 Examen 8 (2023 - 3F)

***Una empresa dedicada a la venta de golosinas posee un archivo que contiene información sobre los productos que tiene a la venta. De cada producto se registran los siguientes datos: código de producto, nombre comercial, precio de venta, stock actual y stock mínimo. La empresa cuenta con 20 sucursales. Diariamente se recibe un archivo detalle de cada una de las 20 sucursales de la empresa que indica las ventas diarias efectuadas por cada sucursal. De cada venta se registra código de producto y cantidad vendida. Se debe realizar un procedimiento que actualice el stock en el archivo maestro con la información disponible en los archivos detalles y que además informe en un archivo de texto aquellos productos cuyo monto total vendido en el día supere los $10000. En el archivo de texto a exportar, por cada producto incluido, se deben informar todos sus datos. Los datos de un producto se deben organizar en el archivo de texto para facilitar el uso eventual del mismo como un archivo de carga. El objetivo del ejercicio es escribir el procedimiento solicitado, junto con las estructuras de datos y módulos usados en el mismo.***

***NOTAS:***

* ***Todos los archivos se encuentran ordenados por codigo de producto.***

* ***En un archivo detalle pueden haber 0, 1 o N registros de un producto determinado.***

* ***Cada archivo detalle sólo contiene productos que seguro existen en el archivo maestro.***

* ***Los archivos se deben recorrer una sóla vez. En el mismo recorrido, se debe realizar la actualización del archivo maestro con los archivos detalles, así como la generación del archivo de texto solicitado.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Examen 8 --> Para verlo completo ir a [*examen8.pas*](/parciales/archivos/examen8.pas)

</details>

<p align=center>🟠</p>
<p align=center>🟠</p>
<p align=center>🟠</p>


<br>
<br>
<br>


<p><img align="center" src="https://github.com/Marimari2342/Marimari2342/blob/main/firmagith.png" alt="marigit"/></p>