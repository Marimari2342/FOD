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

***Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creado en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
promedio de los números ingresados. El nombre del archivo a procesar debe ser proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.***

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

* ***Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.***

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

1. ***Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado, el cual se proporciona desde el teclado.***

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

<br>
<br>
<br>

* Descargar la [práctica](https://drive.google.com/file/d/1oVU2CYF7ZRFz3GPg8pN85K9uvSB5Cjsv/view?usp=sharing).

<br>
<br>
<br>


<p><img align="center" src="https://github.com/Marimari2342/Marimari2342/blob/main/firmagith.png" alt="marigit"/></p>

