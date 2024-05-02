# Fundamentos de la Organización de Datos - Practica 1


## 🟡 Punto 1

***Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del archivo debe ser proporcionado por el usuario desde teclado.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
Program punto1;
type
    numeros = file of integer;
procedure recorro(var aN:numeros);
var 
	num:integer;
begin
	reset(aN);
	while (not eof(aN)) do begin
        read(aN,num); 
        writeln(num);
    end;
    close(aN);
end;
var
    archivoN : numeros;
    num : integer;
    nombre : string;
begin
    writeln ('Ingrese el nombre del archivo');
    read(nombre);
    Assign(archivoN,nombre);
    Rewrite(archivoN);
    read(num);
    while (num <> 30000) do begin
        write(archivoN,num);
        read(num);
    end;
    close(archivoN);
    recorro(archivoN);
end.
~~~

</details>

## 🟡 Punto 2

***Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados creado en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el promedio de los números ingresados. El nombre del archivo a procesar debe ser proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el contenido del archivo en pantalla.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
Program punto2;
type
    numeros = file of integer;
procedure procesar(var aN:numeros; var prom:real; var men:integer);
var 
	num,suma,cant:integer;
begin
	reset(aN);
    suma:=0;
	while (not eof(aN)) do begin
        read(aN,num); 
        writeln(num);
        suma:=suma+num;     {suma y cant son para sacar el promedio}
        cant:=cant+1;
        if (num<1500)then 
            men:=men+1
    end;
    close(aN);
    if (cant<>0) then
        prom:=suma/cant;
end;
var
    archivoN : numeros;
    prom: real;
    num,men: integer;
    nombre : string;
begin
    writeln ('Ingrese el nombre del archivo'); {ingreso nombre y lo asigno al archivo}
    read(nombre);
    Assign(archivoN,nombre);    {conecto nombre fisico y nombre logico}
    Rewrite(archivoN);          {creo el archivo}
    read(num);
    while (num <> 30000) do begin
        write(archivoN,num);
        read(num);
    end;
    close(archivoN);            {cierro el archivo}
    men:=0;
    procesar(archivoN,prom,men);
    WriteLn('Cantidad de numeros menores a 1500: ',men);
    WriteLn('Promedio de los numeros ingresados: ',prom);
end.
~~~

</details>

## 🟡 Punto 3

***Realizar un programa que presente un menú con opciones para:***

* ***Crear un archivo de registros no ordenados de empleados y completarlo con datos ingresados desde teclado. De cada empleado se registra: número de empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
Program punto3;
type
    empleR = record
        nro:integer;
        edad:integer;
        dni:integer;
        apell:string[20];
        nomb:string[20];
    end;
    empleado = file of empleR;
{asignar nombre a archivo}
procedure asignar(var arc_emp:empleado);
var
    nombre:string[15];
begin
    WriteLn('Ingrese nombre de archivo: ');
    readln(nombre);
    Assign(arc_emp,nombre);
end;
{cargar empleados hasta ingresar el ape "fin"}
procedure carga(var arc_emp: empleado);
var
    emp:empleR;
begin
    Rewrite(arc_emp);
    WriteLn('Ingrese apellido, numero, edad, dni y nombre: ');
    ReadLn(emp.apell);
    while(emp.apell<>'fin')do begin
      ReadLn(emp.nro);
      ReadLn(emp.edad);
      ReadLn(emp.dni);
      ReadLn(emp.nomb);
      write(arc_emp,emp);
      ReadLn(emp.apell);
    end;
    Close(arc_emp);
end;
{programa principal}
var
    arc_emp:empleado;
begin
    asignar(arc_emp);
    carga(arc_emp);
end.
~~~

</details>

* ***Abrir el archivo anteriormente generado y***

1. ***Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado, el cual se proporciona desde el teclado.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
{muestra un empleado en pantalla}
procedure mostrarEmpl(emp:empleR);
begin
    WriteLn('Apellido: ',emp.apell,' | Nombre: ',emp.nomb,' | Nro de empleado: ',
    emp.nro,' | Edad: ',emp.edad,' | DNI: ',emp.dni);
end;
{buscar un empleado a partir de un nombre o un apellido}
procedure buscar(var arc_emp:empleado);
var
    nom_ape:string[20];
    emp:empleR;
begin
    WriteLn('Ingrese nombre o apellido: ');
    ReadLn(nom_ape);
    Reset(arc_emp);
    while(not eof(arc_emp)) do begin
      Read(arc_emp,emp);
      if (emp.nomb=nom_ape)or(emp.apell=nom_ape) then
        mostrarEmpl(emp);
    end;
    Close(arc_emp);
end;
~~~

</details>

2. ***Listar en pantalla los empleados de a uno por línea.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
{muestra todos los empleados cargados}
procedure mostrarTodo(var arc_emp:empleado);
var
    emp:empleR;
begin
    Reset(arc_emp);
    while(not eof(arc_emp))do begin
        Read(arc_emp,emp);
        mostrarEmpl(emp); {codigo subido en el inciso anterior}
    end;
    Close(arc_emp);
end;
~~~

</details>

3. ***Listar en pantalla los empleados mayores de 70 años, próximos a jubilarse.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
{mostrar empleados mayores de 70 años}
procedure mayoresSetenta(var arc_emp:empleado);
var
    emp:empleR;
begin
    Reset(arc_emp);
    while (not eof(arc_emp)) do begin
        Read(arc_emp,emp);
        if(emp.edad>70)then
          mostrarEmpl(emp); {codigo subido en el inciso anterior}
    end;
    Close(arc_emp);
end;
~~~

</details>

Menu para acceder a lo pedido anteriormente

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
{menu}
procedure menu(var arc_emp:empleado);
var
    opMenu:integer;
begin
    opMenu:=4;
    while(opMenu<>0)do begin
      writeln('Ingrese la opcion que desea');
      writeln('1 --> Buscar empleado por nombre o apellido.');
      writeln('2 --> Mostrar todos los empleados.');
      writeln('3 --> Mostrar los empleados mayores de 70 años.');
      writeln('Cualquier otro --> Salir.');
      read(opMenu);
      case opMenu of
        1:buscar(arc_emp);
        2:mostrarTodo(arc_emp);
        3:mayoresSetenta(arc_emp);
      end;
    end;
end;
~~~

</details>

>[!NOTE]
>
> Punto 3 --> Para verlo completo ir a [*punto3y4.pas*](/practica1/punto3y4.pas).

## 🟡 Punto 4

***Agregar al menú del programa del ejercicio 3, opciones para:***

* ***Añadir uno o más empleados al final del archivo con sus datos ingresados por teclado. Tener en cuenta que no se debe agregar al archivo un empleado con un número de empleado ya registrado (control de unicidad).***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Debo agregar la opcion de carga en el menu (opción = 4). Luego modificar el procedimiento para cargar nuevos empleados preguntando si el número de empleado ya existe, y sino no lo cargo.
Además agrego la función para verificar si el empleado existe (que va a devolver un boolean). Función a continuación:

~~~
{PUNTO4 --> verificar si el empleado a agregar existe o no}
function existe(arc_emp:empleado;integer: nro):boolean;
var
    aux:boolean;
    emp:empleR;
begin
    reset(arc_emp);
    aux:=false;
    while(not eof(arc_emp) and (aux=false)) do begin
      Read(arc_emp,emp);
      if(emp.nro = nro) then
        aux:=true;
    end;
    return := aux;
end;
~~~

</details>

* ***Modificar la edad de un empleado dado.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Debo agregar la opcion de modificacion de la edad de un empleado en el menu (opción = 5). Luego agrego la función para modificar la edad del empleado a continuación:

~~~
{PUNTO4 --> modificar la edad de un empleado dado}
procedure cambioEdad(var arc_emp:empleado);
var
    numEmp,edad:integer;
    emp:empleR;
    aux:Boolean;
begin
    aux:=false;
    WriteLn('Ingrese numero de empleado: ');
    ReadLn(numEmp);
    Reset(arc_emp);
    while(not eof(arc_emp) and aux=false) do begin
      Read(arc_emp,emp);
      if (emp.num=numEmp) then 
        aux:=true;
    end;
    if (aux) then begin
        WriteLn('Ingrese nueva edad de empleado: ');
        ReadLn(edad);
        seek(arc_emp,FilePos(arc_emp)-1);
        emp.edad:=edad;
        Write(arc_emp,emp);
    end
    else 
        WriteLn('El numero ingresado no coincide con ningún empleado registrado.');
    Close(arc_emp);
end;
~~~

</details>

* ***Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt”.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Agrego la opcion para exportar al menu (opción = 6) y luego el procedimiento para exportar el archivo a un archivo de texto.

~~~
{PUNTO4 --> exportar a archivo de texto}
procedure exportar(var arc_emp:empleado);
var
    txt: Text;
    emp:empleR;
begin 
    Assign(txt, 'todos_empleados.txt');
    reset(arc_emp);
    Rewrite(txt);
    while (not eof(arc_emp)) do begin 
        read(arc_emp, emp);
        writeln(txt,
        ' ',emp.nro,
        ' ',emp.edad,
        ' ',emp.dni,
        ' ',emp.apell,
        ' ',emp.nomb);
    end;
    close(arc_emp);
    close(txt);
end;
~~~

</details>

* ***Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados que no tengan cargado el DNI (DNI en 00).***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

Agrego la opcion para exportar al menu los datos de los empleados que no tienen el dni cargado (opción = 7) y luego el procedimiento para exportar el archivo a un archivo de texto.

~~~
{PUNTO4 --> exportar a archivo de texto los empleados sin DNI cargado}
procedure exportarSinDNI(var arc_emp:empleado);
var
    txt: Text;
    emp:empleR;
begin 
    Assign(txt, 'faltaDNIEmpleado.txt');
    reset(arc_emp);
    Rewrite(txt);
    while (not eof(arc_emp)) do begin 
        read(arc_emp, emp);
        if(emp.dni=0)then
            writeln(txt,
            ' ',emp.nro,
            ' ',emp.edad,
            ' ',emp.dni,
            ' ',emp.apell,
            ' ',emp.nomb);
    end;
    close(arc_emp);
    close(txt);
end;
~~~

</details>

***NOTA: Las búsquedas deben realizarse por número de empleado.***

>[!NOTE]
>
> Punto 4 --> Para verlo completo (junto al Punto3) ir a [*punto3y4.pas*](/practica1/punto3y4.pas).

## 🟡 Punto 5

***Realizar un programa para una tienda de celulares, que presente un menú con opciones para:***

* ***Crear un archivo de registros no ordenados de celulares y cargarlo con datos ingresados desde un archivo de texto denominado “celulares.txt”. Los registros correspondientes a los celulares deben contener: código de celular, nombre, descripción, marca, precio, stock mínimo y stock disponible.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
Program punto5;
type
    celR = record
        cod: integer;
        nombre: string[15];
        descr: string[50];
        marca: string[15];
        precio: real;
        stockMin: integer;
        stockDisp: integer;
    end;
    celulares = file of celR;

{asignar nombre al archivo (NOTA1)}
procedure asignar(var arc_cel:celulares);
var
    nombre:string[15];
begin
    WriteLn('Ingrese nombre de archivo: ');
    readln(nombre);
    Assign(arc_cel,nombre);
end;

{carga de registros de celulares (no ordenados) desde un archivo de texto}
procedure carga(var arc_cel:celulares);
var
    txt:Text;
    c:celR;
begin
    asignar(arc_cel); {Asigno nombre al archivo}
    Rewrite(arc_cel); {Abro archivo en donde guardaré los datos (por primera vez)}
    Assignn(txt,'celulares.txt');
    Reset(txt); {Reabro archivo desde donde voy a leer}
    while(not Eof(txt)) do begin {siempre poner los string al final de la linea}
        readln(txt,c.cod,c.precio,c.marca); {carga especificada en NOTA2}
        readln(txt,c.stockDisp,c.stockMin,c.descr);
        readln(txt,c.nombre);
        write(arc_cel, c);
    end;
    Close(arc_cel);
    Close(txt);
end;

{programa pincipal}
var
    arc_cel:celulares;
begin
    carga(arc_cel);  
end.
~~~

</details>

* ***Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock mínimo.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
procedure imprCel(c:celR);
begin
    WriteLn('Codigo: '+ c.cod + ', Nombre: ' + c.nombre +
    ', Descripción: '+ c.descr + ', Marca: ' + c.marca + 
    ', Precio: ' + c.precio + ', Stock Minimo: ' + c.stockMin + 
    ', Stock Disponible: ' + c.stockDisp);
end;

{Listar en pantalla celulares con un stock menor al stock mínimo.}
procedure listarStkMenor(var arc_cel:celulares);
var
    c:celR;
    aux:Boolean;
begin
    reset(arc_cel);
    aux:=false;
    {Leo uno por uno los celulares del archivo de celulares}
    while (not Eof(arc_cel)) do begin
      Read(arc_cel,c);
      if(c.stockDisp < c.stockMin) then begin {Comparo los stock}
        if(not aux) then begin
          WriteLn('Celulares con un stock menor al stock minimo: ');
          aux:=true;
        end;
        {Muestro en pantalla los que el stock es menor al minimo (PROCED)}
        imprCel(c);
      end;
    end;
    if(not aux)then
      WriteLn('No se encontraron celulares con un stock menor al mínimo.');
    Close(arc_cel);
end;
~~~

</details>

* ***Listar en pantalla los celulares del archivo cuya descripción contenga una cadena de caracteres proporcionada por el usuario.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
{Listar en pantalla celulares cuya descripción tenga cadena de caracteres dada por el usuario.}
procedure buscarDesc(var arc_cel:celulares);
var
    des: string[50];
    aux: Boolean;
    c: celR;
begin
    Reset(arc_cel);
    aux:=false;
    WriteLn('Ingrese descripción: ');
    ReadLn(aux);
    while (not Eof(arc_cel)) do begin
      Read(arc_cel,c);
      if(aux = c.descr) then begin
        if(not aux) then begin
            aux:=true;
            WriteLn('Lista de celulares que coinciden con la descripción ingresada: ');
        end;
      end;
      imprCel(c);
    end;
    if(not aux)then 
        WriteLn('No se encontraron coincidencias.');
    Close(arc_cel);
end;
~~~

</details>

* ***Exportar el archivo creado en el inciso a) a un archivo de texto denominado “celulares.txt” con todos los celulares del mismo. El archivo de texto generado podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que debería respetar el formato dado para este tipo de archivos en la NOTA 2.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
{Exportar el archivo creado en a) al archivo de texto: “celulares.txt”, respetando el formato dado en la NOTA 2.}
procedure exportar(var arc_cel: celulares);
var
    txt: Text;
    c: celR;
begin
    {abro el archivo creado en a)}
    Reset(arc_cel);
    {creo y abro el archivo “celulares.txt”}
    Assign(txt,'celulares.txt');
    Rewrite(txt);
    {voy leyendo y exportando los celulares uno a uno (NOTA2)}
    while (not Eof(arc_cel)) do begin
      Read(arc_cel,c);
      WriteLn(txt,c.cod,' ',c.precio,' ',c.marca); {NOTA 2 --> Linea1: código, precio y marca}
      WriteLn(txt,c.stockDisp,' ', c.stockMin, ' ', c.descr); {NOTA 2 --> Linea2: stock disponible, stock mínimo y descripción}
      WriteLn(txt,c.nombre,' '); {NOTA 2 --> Linea3: nombre}
    end;
    {cierro ambos archivos}
    Close(arc_cel);
    Close(txt);
end;
~~~

</details>

***NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario.***

***NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en tres líneas consecutivas. En la primera se especifica: código de celular, el precio y marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo “celulares.txt”.***

>[!NOTE]
>
> Punto 5 --> Para verlo completo ir a [*punto5y6.pas*](/practica1/punto5y6.pas).

## 🟡 Punto 6

***Agregar al menú del programa del ejercicio 5, opciones para:***

* ***Añadir uno o más celulares al final del archivo con sus datos ingresados por teclado.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
procedure leerCel(var c:celR);
begin
    WriteLn('Ingrese codigo, precio, marca, stock disponible, stock minimo, descripcion y nombre');
    readln(c.cod);
    readln(c.precio);
    readln(c.marca);
    readln(c.stockDisp);
    readln(c.stockMin);
    readln(c.descr);
    readln(c.nombre);
end;

{PUNTO6: Añadir uno o más celulares al final del archivo con datos ingresados por teclado.}
procedure añadir(var arc_cel: celulares);
var
    c:celR;
    opcion:Char;
    ok:Boolean;
begin
    ok:=true;
    Reset(arc_cel);
    Seek(arc_cel,FileSize(arc_cel));
    while (ok) do begin
      leerCel(c);
      WriteLn('Indique si quiere ingresar otro celular [s/n]');
      ReadLn(opcion);
      if(opcion='n')then
        ok:=false;
      Write(arc_cel,c);
    end;
    Close(arc_cel);
end;
~~~

</details>

* ***Modificar el stock de un celular dado.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
{PUNTO6: Modificar el stock de un celular dado.}
procedure modificarStock(var arc_cel:celulares);
var
    c:celR;
    aux:string[15];
    encontre:Boolean;
begin
    Reset(arc_cel);
    encontre:=false;
    {Pedir que ingrese el nombre del celular}
    WriteLn('Ingrese el nombre del celular que busca: ');
    ReadLn(aux);
    {Recorrer el archivo de celulares para buscar el celular}
    while (not Eof(arc_cel) and (not encontre)) do begin
      read(arc_cel,c);
      if(c.nombre=aux) then
        encontre:=true;
    end;
    if(encontre)then begin {Si encuentro el celular}
      WriteLn ('Ingrese nuevo stock'); {Cambio el stock}
      ReadLn(c.stockDisp);
      Write(arc_cel,c); 
    end
    else {si no lo encuentro}
      WriteLn('El celular no se encuentra en el archivo.'); {aviso que no lo encontre}
    Close(arc_cel);
end;
~~~

</details>

* ***Exportar el contenido del archivo binario a un archivo de texto denominado: "SinStock.txt", con aquellos celulares que tengan stock 0.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
{Exportar al archivo "SinStock.txt" los celulares con stock = 0}
procedure exportarSinStock(var arc_cel:celulares)
var
    txt:Text;
    c:celR;
begin
    Reset(arc_cel);
    {Crear archivo "SinStock.txt"}
    Assign(txt,'SinStock.txt');
    Rewrite(txt);
    {Recorrer el archivo de celulares y fijarme los que tienen stock = 0}
    while (not Eof(arc_cel)) do begin
      Read(arc_cel,c);
      {Si hay algun stock = 0 lo guardo en el archivo nuevo}
      if(c.stockDisp = 0) then begin
        WriteLn(txt,c.cod,' ',c.precio,' ',c.marca); {NOTA 2 --> Linea1: código, precio y marca}
        WriteLn(txt,c.stockDisp,' ', c.stockMin, ' ', c.descr); {NOTA 2 --> Linea2: stock disponible, stock mínimo y descripción}
        WriteLn(txt,c.nombre,' '); {NOTA 2 --> Linea3: nombre}
      end;
    end;
    Close(arc_cel);
    Close(txt);
end;
~~~

</details>

***NOTA: Las búsquedas deben realizarse por nombre de celular.***

>[!NOTE]
>
> Punto 6 --> Para verlo completo (junto al Punto5) ir a [*punto5y6.pas*](/practica1/punto5y6.pas).

## 🟡 Punto 7

***Realizar un programa que permita:***

* ***Crear un archivo binario a partir de la información almacenada en un archivo de texto. El nombre del archivo de texto es: “novelas.txt”. La información en el archivo de texto consiste en: código de novela, nombre, género y precio de diferentes novelas argentinas. Los datos de cada novela se almacenan en dos líneas en el archivo de texto. La primera línea contendrá la siguiente información: código novela, precio y género, y la segunda línea almacenará el nombre de la novela.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~

~~~

</details>

* ***Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar una novela y modificar una existente. Las búsquedas se realizan por código de novela.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~

~~~

</details>

***NOTA: El nombre del archivo binario es proporcionado por el usuario desde el teclado.***

>[!NOTE]
>
> Punto 7 --> Para verlo completo ir a [*punto7.pas*](/practica1/punto7.pas).

<p align=center>🟡</p>
<p align=center>🟡🟡</p>
<p align=center>🟡</p>


>[!TIP]
>
> Para descargar la practica (del 2024) en PDF click [<code>AQUÍ</code>](https://drive.google.com/file/d/1oVU2CYF7ZRFz3GPg8pN85K9uvSB5Cjsv/view?usp=sharing).


<br>
<br>
<br>


<p><img align="center" src="https://github.com/Marimari2342/Marimari2342/blob/main/firmagith.png" alt="marigit"/></p>

