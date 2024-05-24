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
Program punto3;
type
    novelaR = record
        cod:integer;
        genero:String[10];
        nombre:String[20];
        duracion:integer;
        director:string[20];
        precio:real;
    end;
    arc_novelas = file of novelaR;

procedure leer_novela(var nov:novelaR);
begin
  WriteLn('Ingrese codigo, genero, nombre, duracion, director y precio, o -1 para terminar.');
  Read(nov.cod);
  if(nov.cod<>-1)then begin
    Read(nov.genero);
    Read(nov.nombre);
    Read(nov.duracion);
    Read(nov.director);
    Read(nov.precio);
  end;
end;

{punto a) --> Crear el archivo y cargarlo a partir de datos ingresados por teclado. 
(LISTA INVERTIDA: durante la creación del archivo, en el primer registro se debe 
almacenar la cabecera de la lista. Es decir un registro ficticio, inicializando con el 
valor cero (0) el campo correspondiente al código de novela, el cual indica que no hay 
espacio libre dentro del archivo}
procedure carga(var a:arc_novelas);
var
    nov:novelaR;
begin
    Assign(a,'archivo');
    Rewrite(a);
    nov.cod:=0;
    Write(a,nov); {cabecera de la lista}
    leer_novela(nov);
    while (nov.cod<>-1) do begin
      Write(a,nov);
      leer_novela(nov);
    end;
    Close(a);
end;

{punto b) i --> dar de alta una novela (de ser posible)}
procedure alta_novela(var a:arc_novelas);
var 
    nueva,nov,cab:novelaR;
begin
    Reset(a);
    leer_novela(nueva);
    read(a,nov);
    if (nov.cod=0) then begin
      Seek(a,FileSize(a));
      Write(a,nueva);
    end
    else begin
      Seek(a,abs(nov.cod)); {voy a la posicion en donde quiero guardar la nueva novela}
      Read(a,cab); {leo el registro de esa posicion y me lo guardo en cab}
      Seek(a,FilePos(a)-1); {vuelvo a apuntar donde tengo espacio}
      Write(a,nueva); {guardo la novela nueva}
      Seek(a,0); {voy a la posicion cabecera}
      Write(a,cab); {guardo la variable cabecera que tiene otra posicion libre (o el 0)}
    end;
    Close(a);
end;

{punto b) ii --> modificar novela desde teclado (cod NO)}
procedure realizar_modif(var n:novela);
var
    aux:integer;
begin
    aux:=1;
    while (aux>0 and aux<=5) do begin
      WriteLn('Ingrese la opcion que desea modificar');
      WriteLn('1 --> Modificar genero.');
      WriteLn('2 --> Modificar nombre.');
      WriteLn('3 --> Modificar duracion.');
      WriteLn('4 --> Modificar director.');
      WriteLn('5 --> Modificar precio.');
      WriteLn('Cualquier otro para salir.');
      Read(aux);
      WriteLn('Ingrese modificacion: ');
      case aux of
        1: read (n.genero);
        2: read (n.nombre);
        3: read (n.duracion);
        4: read (n.director);
        5: read (n.precio);
      end;
    end;
end;

procedure modificar(var a:arc_novelas);
var
    n:novelaR;
    cod:integer;
    esta:boolean;
begin
    Reset(a);
    WriteLn('Ingrese cod de novela a modificar: ');
    read(cod);
    esta:=false;
    while ((not Eof(a)) and (not esta)) do begin
      read(a,n);
      if(n.cod=cod)then
        esta:=true;
    end;
    if esta then begin
      realizar_modif(n);
      seek(a,FilePos(a)-1);
      write(a,n);
    end 
    else 
      WriteLn('No se encontró la novela.');
    Close(a);
end;

{punto b) iii --> dar de baja novela}
procedure baja_novela(var a:arc_novelas);
var
    cod:integer;
    cab,n:novelaR;
    esta:boolean;
begin
    Reset(a);
    WriteLn('Ingrese codigo de la novela a eliminar.');
    read(cod);
    esta:=false;
    Read(a,cab);
    Read(a,n);
    while (not Eof(a)) do begin
      if(n.cod=cod)then begin
        esta:=true;
        n.cod:=cab.cod; {guardo el codigo que tengo en cabecera en el lugar a eliminar}
        Seek(a,FilePos(a)-1);   {vuelvo el puntero para atras}
        cab.cod := FilePos(a)*-1; {pongo la posicion a eliminar en negativo y guardo en cabecera}
        Write(a,n); {guardo en la posicion el archivo con el codigo negativo (elim logica)}
        Seek(a,0); {vuelvo a cabecera}
        Write(a,cab); {guardo cabecera modificada}
      end
      else 
        Read(a,n);
    end;
    if(not esta)then
      WriteLn('La novela que se quiere eliminar no esta en el archivo.');
    Close(a);
end;

{punto c) --> listar novelas que representan la lista de espacio libre.}
procedure listar (var a:arc_novelas;var txt:Text);
var
    n:novelaR;
begin
    Assign(txt,'novelas.txt');
    Rewrite(txt);
    Reset(a);
    Seek(a,1); {salteo la cabecera}
    Read(a,n);
    while (not Eof(a)) do begin
      if(n.cod>0)then 
        WriteLn(txt,'Codigo: ',n.cod,', Nombre: ',n.nombre,', Genero: ',n.genero,' Duracion: ',n.duracion,', Director: ',n.director,' Precio: ',n.precio,'.')
      else 
        WriteLn('Espacio Libre.');
      Read(a,n);
    end;
    Close(a);
    Close(txt);
end;

{programa principal}
var
    a:arc_novelas;
    txt:Text;
begin
    carga(a);
    alta_novela(a);
    modificar(a);
    baja_novela(a);
    listar(a,txt);
end.
~~~

</details>

## 🔵 Punto 4

***Dada la siguiente estructura:***

~~~
type
    reg_flor = record
        nombre: String[45];
        codigo:integer;
    end;
    tArchFlores = file of reg_flor;
~~~
***Las bajas se realizan apilando registros borrados y las altas reutilizando registros borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el número 0 en el campo código implica que no hay registros borrados y -N indica que el próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.***

* ***Implemente el siguiente módulo:***

~~~
{Abre el archivo y agrega una flor, recibida como parámetro manteniendo la política descrita anteriormente}
procedure agregarFlor (var a: tArchFlores ; nombre: string; codigo:integer);
~~~

* ***Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que considere necesario para obtener el listado.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
Program punto4;

type
    reg_flor = record
        nombre: String[45];
        codigo:integer;
    end;
    tArchFlores = file of reg_flor;

{miro el numero cabecera.
    Si cod=0 no tengo espacio entonces agrego al final una flor
    Si cod<>0 tengo espacios, que puedo reutilizar}
procedure agregarFlor (var a: tArchFlores ; nombre: string; codigo:integer);
var
    reg,cab:reg_flor;
begin
    Reset(a);
    Read(a,cab);
    if(cab=0)then begin
      Seek(a,FileSize(a));
      reg.nombre:=nombre;
      reg.codigo:=codigo;
      Write(a,reg);
    end
    else begin
      Seek(a,Abs(cab.codigo)); {voy a la posicion guardada en cabecera}
      Read(a,cab); {me guardo el codigo guardado en pos libre (0 si no hay mas espacios)}
      Seek(a,FilePos(a)-1); {apunto para atras donde tengo libre}
      Write(a,reg); {guardo la flor nueva}
      Seek(a,0); {vuelvo al inicio}
      Write(a,cab); {guardo cabecera nueva}
    end;
end;

{liste el contenido del archivo omitiendo las flores eliminadas.}
procedure listar (var a:tArchFlores; var txt:Text);
var
    reg:reg_flor;
begin
    Assing(txt,'archivo.txt');
    Rewrite(txt);
    while (not Eof(a)) do begin
        read(a,reg);
        if(reg.codigo>0)then
          WriteLn(txt,'Nombre: ',reg.nombre,', Codigo: ',reg.codigo);
    end;
end;

{programa principal}
var
    a:tArchFlores;
    nom:string;
    cod:integer;
    txt:Text;
begin
    {...codigo...}
    agregarFlor(a,nom,cod);
    listar(a,txt);
end.
~~~

</details>

## 🔵 Punto 5

***Dada la estructura planteada en el ejercicio anterior, implemente el siguiente módulo:***

~~~
{Abre el archivo y elimina la flor recibida como parámetro manteniendo la política descripta anteriormente}
procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
~~~

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