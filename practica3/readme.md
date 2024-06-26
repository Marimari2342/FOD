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

>[!TIP]
>
> Punto 3 --> El procedimiento se encuenta en [*punto3.pas*](/practica3/punto3.pas).

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

>[!TIP]
>
> Punto 4 --> El procedimiento se encuenta en [*punto4y5.pas*](/practica3/punto4y5.pas).

## 🔵 Punto 5

***Dada la estructura planteada en el ejercicio anterior, implemente el siguiente módulo:***

~~~
{Abre el archivo y elimina la flor recibida como parámetro manteniendo la política descripta anteriormente}
procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
~~~

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
var
    cab,aux:reg_flor;
    esta:boolean;
begin
    Reset(a);
    Seek(a,cab);
    read(a,aux);
    esta:=false;
    while((not Eof(a)) and (not esta))do 
      if(aux.codigo=flor.codigo)then begin
        esta:=true;
        aux.codigo:=cab.codigo;
        Seek(a,FilePos(a)-1);
        cab.codigo:=FilePos(a)*-1;
        Write(a,aux);
        Seek(a,0);
        Write(a,cab);
      end
      else 
        read(a,aux);
    if(not esta)then
      WriteLn('La flor que se quiere eliminar no se encuentra en el archivo');
    Close(a);
end;
~~~

</details>

>[!TIP]
>
> Punto 5 --> El procedimiento se encuenta junto con el punto 4 en [*punto4y5.pas*](/practica3/punto4y5.pas).

## 🔵 Punto 6

***Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con la información correspondiente a las prendas que se encuentran a la venta. De cada prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y precio_unitario. Ante un eventual cambio de temporada, se deben actualizar las prendas a la venta. Para ello reciben un archivo conteniendo: cod_prenda de las prendas que quedarán obsoletas. Deberá implementar un procedimiento que reciba ambos archivos y realice la baja lógica de las prendas, para ello deberá modificar el stock de la prenda correspondiente a valor negativo.***

***Adicionalmente, deberá implementar otro procedimiento que se encargue de efectivizar las bajas lógicas que se realizaron sobre el archivo maestro con la información de las prendas a la venta. Para ello se deberá utilizar una estructura auxiliar (esto es, un archivo nuevo), en el cual se copien únicamente aquellas prendas que no están marcadas como borradas. Al finalizar este proceso de compactación del archivo, se deberá renombrar el archivo nuevo con el nombre del archivo maestro original.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
program punto6;
type
    prendaR = record
        cod_prenda:integer;
        descripción:string[30];
        colores:string[10];
        tipo_prenda:string[10];
        stock:integer;
        precio_unitario:real;
    end;
    maestro = file of prendaR;
    detalle = file of integer;

{actualizar prendas con un archivo que indica cod_prenda de las prendas que 
quedan obsoletas --> ELIMINAR
baja logica --> modificar el stock de la prenda correspondiente a valor negativo}
procedure baja_prenda (var m:maestro; var d:detalle);
var
    cod:integer;
    p,cab:prendaR;
begin
    Reset(m);
    Reset(d);
    read(m,cab);
    while (not Eof(d)) do begin {archivo no ordenado}
      read(d,cod);
      while (not Eof(m)) do begin
        read(m,p);
        if(p.cod_prenda=cod)then begin
          p.cod_prenda:=cab.cod_prenda; {baja logica}
          Seek(m,FilePos(m)-1);
          cab.cod_prenda:=Abs(FilePos(m))*-1;
          Write(m,p);
          Seek(m,0);
          Write(m,cab);
        end;
      end;
    end;
    Close(d);
    Close(m);
end;

{copiar las prendas que no están marcadas como borradas --> compactación del archivo 
renombrar el archivo nuevo con el nombre del archivo maestro original}
procedure compactar (var m,mN:maestro);
var
    p:prendaR;
begin
    Reset(m);
    Rewrite(mN);
    Seek(m,1); {salteo cabecera}
    while (not Eof(m)) do begin
        Read(m,p);
        if(p.cod_prenda>0)then
          Write(mN,p);
    end;
    Close(mN);
    Close(m);
    Erase(m);
    Rename(mN,'maestro');
end;

{programa principal}
var
    m,mN:maestro;
    d:detalle;
begin
    Assign(m,'maestro');
    Assign(d,'detalle');
    Assign(mN,'maestro_auxiliar');
    baja_prenda(m,d);
    compactar(m,mN);
end.
~~~

</details>

>[!TIP]
>
> Punto 6 --> El procedimiento se encuenta en [*punto6.pas*](/practica3/punto6.pas).

## 🔵 Punto 7

***Se cuenta con un archivo que almacena información sobre especies de aves en vía de extinción, para ello se almacena: código, nombre de la especie, familia de ave, descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice un programa que elimine especies de aves, para ello se recibe por teclado las especies a eliminar. Deberá realizar todas las declaraciones necesarias, implementar todos los procedimientos que requiera y una alternativa para borrar los registros. Para ello deberá implementar dos procedimientos, uno que marque los registros a borrar y posteriormente otro procedimiento que compacte el archivo, quitando los registros marcados. Para quitar los registros se deberá copiar el último registro del archivo en la posición del registro a borrar y luego eliminar del archivo el último registro de forma tal de evitar registros duplicados.***

***NOTA: Las bajas deben finalizar al recibir el código 500000.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
program punto7;
type
    aveR = record
        cod:integer;
        nombre:string[15];
        familia:string[15];
        descr:string[30];
        zona:string[15];
    end;
    maestro = file of aveR;

{-->elimine especies de aves, se recibe por teclado las especies a eliminar<--}
{procedimiento que marque los registros a borrar}
procedure marcar(var m:maestro);
var
    cod:integer;
    ave:aveR;
    esta:true;
begin
    Reset(m);
    WriteLn('Indique codigo de ave a eliminar, o 500000 para salir.');
    Read(cod);
    while (cod<>500000) do begin
        esta:=false;
        while ((not Eof(m))and(not esta)) do begin
            Read(m,ave);
            if (ave.cod=cod) then begin
              ave.nombre:='***'; {marca de ave eliminada}
              Seek(m,FilePos(m)-1);
              Write(m,ave);
              esta:=true;
            end;
        end;
        if (not esta) then
            WriteLn('El ave que se busca eliminar no esta en el archivo.');
        WriteLn('Indique codigo de ave a eliminar, o 500000 para salir.');
        Read(cod);
    end;
    Close(m);
end;

{procedimiento que compacte el archivo, quitando los registros marcados (copia el último
registro del archivo en la posición del registro a borrar y luego elimina del archivo el 
último registro para evitar registros duplicados}
procedure compactar(var m:maestro);
var
    ave,aveB:aveR;
    a,b:integer;
    ok:boolean;
begin
    Reset(m);
    a:=0;
    b:=FileSize(m)-1;
    ok:=false;
    while ((a<b)and(not ok)) do begin
      Seek(m,a);
      Read(m,ave);
      a+=1;
      if(ave.nombre='***')then begin{registro a eliminar}
        ok:=true;
        Seek(m,b);  {apunto al final}
        read(m,aveB); {leo el ave del final}
        b-=1; {decremento el final}
        while (aveB.cod='***') do begin {me aseguro que el registro final no este marcado para eliminar}
          Seek(m,b);
          read(m,aveB);
          b-=1;
        end;
        if (aveB.cod<>'***') and (a-1<=b) then begin
            Seek(m,a-1);    {voy a la posicion del registro a eliminar}
            write(m,aveB);  {reescribo con el registro que tengo en la posicion b}
            Seek(m,b+1);    {voy a la ultima posicion sin registros a eliminar}
            Write(m,ave);   {pongo el registro a eliminar aqui}
            ok:=false;
        end 
        else 
            a:=a-1;
      end;
    end;
    seek(m,a);
    read(m,ave);
    if (ave.codigo<>'***') then 
        a:=a+1;
    seek(m,a);
    truncate(m);
    Close(m);
end;

{programa principal}
var
    m:maestro;
begin
    Assign(m,'maestro');
    marcar(m);
    compactar(m);
end.
~~~

</details>

>[!TIP]
>
> Punto 7 --> El procedimiento se encuenta en [*punto7.pas*](/practica3/punto7.pas).

## 🔵 Punto 8

***Se cuenta con un archivo con información de las diferentes distribuciones de linux existentes. De cada distribución se conoce: nombre, año de lanzamiento, número de versión del kernel, cantidad de desarrolladores y descripción. El nombre de las distribuciones no puede repetirse. Este archivo debe ser mantenido realizando bajas lógicas y utilizando la técnica de reutilización de espacio libre llamada lista invertida. Escriba la definición de las estructuras de datos necesarias y los siguientes
procedimientos:***

* ***ExisteDistribucion: módulo que recibe por parámetro un nombre y devuelve verdadero si la distribución existe en el archivo o falso en caso contrario.***

* ***AltaDistribución: módulo que lee por teclado los datos de una nueva distribución y la agrega al archivo reutilizando espacio disponible en caso de que exista. (El control de unicidad lo debe realizar utilizando el módulo anterior). En caso de que la distribución que se quiere agregar ya exista se debe informar “ya existe la distribución”.***

* ***BajaDistribución: módulo que da de baja lógicamente una distribución cuyo nombre se lee por teclado. Para marcar una distribución como borrada se debe utilizar el campo cantidad de desarrolladores para mantener actualizada la lista invertida. Para verificar que la distribución a borrar exista debe utilizar el módulo ExisteDistribucion. En caso de no existir se debe informar “Distribución no existente”.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
program punto8;
type
    distribucionR = record
        nombre:string[15];
        anio:integer;
        numKernel:integer;
        cantDes:integer;
        descr:string[50];
    end;
    maestro = file of distribucionR;

{El nombre de las distribuciones no puede repetirse}
{Este archivo debe ser mantenido realizando bajas lógicas y utilizando lista invertida}

{módulo que recibe por parámetro un nombre y devuelve verdadero si la distribución 
existe en el archivo o falso en caso contrario.}
function ExisteDistribucion(m:maestro;nom:string[15]):boolean; {FUNCION --> Solo par por valor, puedo pasar el maestro así???}
var
    dato:distribucionR;
    esta:Boolean;
begin
    Reset(m);
    esta:=false;
    while (not Eof(m)) and (not esta) do begin
      read (m,dato);
      if (dato.nombre = nom) then 
        esta:=true;
    end;
    Close(m);
    return := esta;
end;

{otros procesos necesarios}
procedure leer(var dato:distribucionR);
begin
    WriteLn('Ingrese nombre, año lanzamiento, num del kernel, cantidad desarrolladores y descripción.');
    Read(dato.nombre);
    Read(dato.anio);
    Read(dato.numKernel);
    Read(dato.cantDes);
    Read(dato.descr);
end;

procedure agregar(var m:maestro; var dato:distribucionR);
var
    cab:distribucionR;
begin
    Reset(m);
    Read(m,cab);
    if(cab.cantDes=0)then begin
      Seek(m,FileSize(m));
      Write(m,dato);
    end
    else begin  {s r s w s w}
      Seek(m,Abs(cab.cantDes));
      read(m,cab);
      Seek(m,FilePos(m)-1);
      Write(m,dato);
      Seek(m,0);
      Write(m,cab);
    end;
    Close(m);
end;

{módulo que lee por teclado los datos de una nueva distribución y la agrega al archivo 
reutilizando espacio disponible en caso de que exista. (El control de unicidad lo debe 
realizar con ExisteDistribucion). Si la distribución a que se quiere agregar ya existe 
informar “ya existe la distribución”}
procedure AltaDistribucion(var m:maestro);
var
    nuevo:distribucionR;
begin
    Reset(a);
    leer(nuevo);
    if(not ExisteDistribucion(m,dato.nombre))then
      agregar(m,dato)
    else 
      WriteLn('Ya existe la distribución.');
    Close(a);
end;

{módulo que da de baja lógicamente una distribución cuyo nombre se lee por teclado. Para 
marcar una distribución como borrada utilizar campo cantidad de desarrolladores para 
mantener actualizada la lista invertida. Para verificar que la distribución a borrar
exista utilizar módulo ExisteDistribucion. Si no existe informar “Distribución no existente”.}
procedure BajaDistribucion(var m:maestro);
var
    nom:string[15];
    cab,aux:distribucionR;
begin
    WriteLn('Ingrese nombre de la distribucion a eliminar.');
    Read(nom);
    Reset(m);
    Read(m,cab);
    if (ExisteDistribucion(m,nom)) then begin {si existe la distribucion a eliminar}
      read(m,aux);  {leo primer registro (despues de cabecera)}
      while (nom<>aux.nombre) do {mientras no encuentre el que quiero eliminar}
        read(m,aux);    {leo otro registro --> hasta encontrar el que quiero eliminar}
      aux.cantDes:=cab.cantDes; {guardo en aux la dir del proximo esp libre}
      Seek(a,FilePos(a)-1); {vuelvo el puntero para atras}
      cab.cantDes:=FilePos(a)*-1;   {guardo en cabecera la pos del registro a eliminar (neg)}
      Write(a,aux); {guardo aux en el registro en la posicion del registro a eliminar}
      Seek(a,0);    {vuelvo a la cabecera}
      Write(a,cab); {guardo la nueva cabecera}
    end
    else 
        WriteLn('Distribución no existente.');
    Close(m);
end;

{programa principal}
var
    m:maestro;
begin
    Assign(m,'maestro');
    {supongo que el archivo ya tiene previamente registros de distribuciones cargados}
    AltaDistribucion(m);
    BajaDistribucion(m);
end.
~~~

</details>

>[!TIP]
>
> Punto 8 --> El procedimiento se encuenta en [*punto8.pas*](/practica3/punto8.pas).

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