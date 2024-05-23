# Fundamentos de la Organización de Datos - Practica 3

## 🔵 Punto 1

***Modificar el ejercicio 4 de la práctica 1 (programa de gestión de empleados),
agregándole una opción para realizar bajas copiando el último registro del archivo en
la posición del registro a borrar y luego truncando el archivo en la posición del último
registro de forma tal de evitar duplicados.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
procedure baja(var arc_emp:empleado); 
var
    nro,aux:integer;
    emp:empleR;
    existe:boolean;
begin
    Reset(arc_emp);
    read(arc_emp,emp);
    WriteLn('Ingrese numero de empleado a eliminar');
    read(nro);
    existe:=false;
    while(not Eof(arc_emp) or (not existe))do begin
        read(arc_emp,emp);
        if(nro<>emp.nro)then
          existe:=true;
    end;
    if (existe) then begin
      aux:=FilePos(arc_emp)-1; {me guardo la posición del registro a sobreescribir}
      Seek(arc_emp,FilePos(arc_emp)-1); {voy a la posicion del ultimo registro en el archivo}
      read(arc_emp,emp); {leo el ultimo registro del archivo}
      Seek(arc_emp,aux); {vuelvo a la posicion del registro a sobreescribir}
      Write(arc_emp,emp); {guardo el ultimo registro en esta posicion}
      Seek(arc_emp,FilePos(arc_emp)-1); {apunto a la posicion del ultimo registro}
      Truncate(arc_emp); {la trunco}
    end;
end;
~~~

</details>

>[!TIP]
>
> Punto 1 --> El procedimiento se encuenta en [*punto3y4.pas*](/practica1/punto3y4.pas).

## 🔵 Punto 2

***Definir un programa que genere un archivo con registros de longitud fija conteniendo información de asistentes a un congreso a partir de la información obtenida por teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del archivo de datos generado, elimine de forma lógica todos los asistentes con nro de asistente inferior a 1000. Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo String a su elección. Ejemplo: ‘@Saldaño’.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
Program punto2;
type
    asistenteR = record
        nroAsis:integer;
        apeNomb:string[20];
        email:string[15];
        tel:integer;
        dni:integer;
    end;
    archivo = file of asistenteR;

procedure cargar (var a:asistenteR);
begin
  WriteLn('Ingrese nroAsist, apellido y nombre, email, tel y dni, o 0 para salir');
  Read(a.nroAsis);
  if(a.nroAsis<>0)then begin
    Read(a.apeNomb);
    Read(a.email);
    Read(a.tel);
    Read(a.dni);
  end;
end;

{generar un archivo con registros de longitud fija conteniendo información de asistentes
a un congreso a partir de la información obtenida por teclado.}
procedure generar(var a:archivo);
var
    asistR:asistenteR;
begin
    Assign(a,'archivo_asistentes');
    Rewrite(a);
    cargar(asistR);
    while (asistR.nroAsis<>0) do begin
        Write(a,asistR);
        cargar(asistR);
    end;
    Close(a);
end;

{elimine de forma lógica todos los asistentes con nro de asistente inferior a 1000}
procedure eliminar_logico(var a:archivo);
var
    asistR:asistenteR;
begin
    Reset(a);
    while (not Eof(a)) do begin
      Read(a,asistR);
      if(asistR.nroAsis<1000)then begin
        asistR.apeNomb:=Concat('***',asistR.apeNomb);
        Seek(a,FilePos(a)-1);
        Write(a,asistR);
      end;
    end;
    Close(a);
end;

{programa principal}
var
    a:archivo;
begin
    generar(a);
    eliminar_logico(a);
end.
~~~

</details>

>[!TIP]
>
> Punto 2 --> El procedimiento se encuenta en [*punto2.pas*](/practica3/punto2.pas).

## 🔵 Punto 3

***Realizar un programa que genere un archivo de novelas filmadas durante el presente año. De cada novela se registra: código, género, nombre, duración, director y precio. El programa debe presentar un menú con las siguientes opciones:***

***a) Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se utiliza la técnica de lista invertida para recuperar espacio libre en el archivo. Para ello, durante la creación del archivo, en el primer registro del mismo se debe almacenar la cabecera de la lista. Es decir un registro ficticio, inicializando con el valor cero (0) el campo correspondiente al código de novela, el cual indica que no hay espacio libre dentro del archivo.***

***b) Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el inciso a., se utiliza lista invertida para recuperación de espacio. En particular, para el campo de ´enlace´ de la lista, se debe especificar los números de registro referenciados con signo negativo, (utilice el código de novela como enlace).Una vez abierto el archivo, brindar operaciones para:***

* ***Dar de alta una novela leyendo la información desde teclado. Para esta operación, en caso de ser posible, deberá recuperarse el espacio libre. Es decir, si en el campo correspondiente al código de novela del registro cabecera hay un valor negativo, por ejemplo -5, se debe leer el registro en la posición 5, copiarlo en la posición 0 (actualizar la lista de espacio libre) y grabar el nuevo registro en la posición 5. Con el valor 0 (cero) en el registro cabecera se indica que no hay espacio libre.***

* ***Modificar los datos de una novela leyendo la información desde teclado. El código de novela no puede ser modificado.***

* ***Eliminar una novela cuyo código es ingresado por teclado. Por ejemplo, si se da de baja un registro en la posición 8, en el campo código de novela del registro cabecera deberá figurar -8, y en el registro en la posición 8 debe copiarse el antiguo registro cabecera.***

***c) Listar en un archivo de texto todas las novelas, incluyendo las borradas, que representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.***

***NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser proporcionado por el usuario.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~

~~~

</details>

<p align=center>🔵</p>
<p align=center>🔵</p>
<p align=center>🔵</p>


>[!NOTE]
>
> * ***Para descargar la practica (del 2024) en PDF, click [<code>AQUÍ</code>](https://drive.google.com/file/d/1SQitB1Q9bsS3azl4tFKMQryw7hZCEiFR/view?usp=sharing).***


<br>
<br>
<br>


<p><img align="center" src="https://github.com/Marimari2342/Marimari2342/blob/main/firmagith.png" alt="marigit"/></p>