# Fundamentos de la Organización de Datos - Practica 2

## 🟣 Punto 1

***Una empresa posee un archivo con información de los ingresos percibidos por diferentes empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado, nombre y monto de la comisión. La información del archivo se encuentra ordenada por código de empleado y cada empleado puede aparecer más de una vez en el archivo de comisiones.***

***Realice un procedimiento que reciba el archivo anteriormente descrito y lo compacte. En consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una única vez con el valor total de sus comisiones.***

***NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser recorrido una única vez.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
Program punto1;
type
    empR = record
        cod:integer;
        nombre:string[15];
        monto:real;
    end;

procedure Compactar(var comisiones, arc_comp:Text);
var
    eLei,eAcum:empR;
begin
    {asignar a variable y abrir archivo que voy a leer}
    Assign(comisiones,'comisiones.txt');
    Reset(comisiones);
    {asignar a variable y crear archivo donde voy a guardar}
    Assign(arc_comp,'compactado.txt');
    Rewrite(arc_comp);
    Read(comisiones,eLei.cod,eLei.nombre,eLei.monto);
    while (not Eof(comisiones)) do begin
      eAcum.cod := eLei.cod;
      eAcum.monto := 0;
      while (not Eof(comisiones))and(eLei.cod = eAcum.cod) do begin
        eAcum.monto+=eLei.monto;
        Read(comisiones,eLei.cod,eLei.nombre,eLei.monto);
      end;
      WriteLn(arc_comp,eAcum.cod,' ',eAcum.monto:0:2,' ',eAcum.nombre);
    end;
    {cerrar archivos}
    Close(arc_comp);
    Close(comisiones);
end;

{programa principal}
var
    comisiones:Text;
    arc_comp:Text;
begin
    Compactar(comisiones,arc_comp);
end.
~~~

</details>

>[!TIP]
>
> Punto 1 --> Para ver el .pas ir a [*punto1.pas*](/practica2/punto1.pas).

## 🟣 Punto 2

***Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias (cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene un archivo detalle con el código de alumno e información correspondiente a una materia (esta información indica si aprobó la cursada o aprobó el final).***

***Todos los archivos están ordenados por código de alumno y en el archivo detalle puede haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un programa con opciones para:***

* ***Actualizar el archivo maestro de la siguiente manera:***

***i. Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado, y se decrementa en uno la cantidad de materias sin final aprobado.***

***ii. Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin final.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
procedure leer(var detalle:alumnos; var mat:materiaR);
begin
  if (not Eof(detalle)) then 
    read(detalle,mat)        
  else
    mat.cod := valorAlto;
end;

procedure actualizar(var maestro:alumnos;var detalle:materias);
var
    mat:materiaR;
    alu:alumnosR;
    canC,canF:integer;
begin
    Reset(maestro);
    Reset(detalle);
    Leer(detalle,mat); 
    while (mat.cod<>valorAlto) do begin
      Read(maestro,alu);
      cantC:=0;
      canF:=0;
      while (mat.cod = alu.cod) do begin
        if(mat.cursadaOfinal='c')then
          canC+=1;
        if(mat.cursadaOfinal='f')then begin
          cantF+=1;
          canC-=1;
        end;
      end;
      alu.cantMatCursadas+=canC;
      alu.cantMatFinalApr+=canF;
      seek (maestro,filePos (maestro)-1);
      write (maestro,alu);
      Leer(detalle,mat); 
    end;
    Close(maestro);
    Close(detalle);
end;
~~~

</details>

* ***Listar en un archivo de texto aquellos alumnos que tengan más materias con finales aprobados que materias sin finales aprobados. Teniendo en cuenta que este listado es un reporte de salida (no se usa con fines de carga), debe informar todos los campos de cada alumno en una sola línea del archivo de texto.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
procedure listarAlu(var maestro:alumnos; var txt:Text);
var
    alu:alumnosR;
begin
    Reset(maestro);
    Rewrite(txt);
    while (not Eof(maestro)) do begin
      Read(maestro,alu);
      if(alu.cantMatFinalApr>alu.cantMatCursadas)then
        WriteLn(txt,alu.cod,alu.cantMatCursadas,alu.cantMatFinalApr,alu.apellido,alu.nombre);
    end;
    Close(maestro);
    Close(txt);
end;
~~~

</details>

***NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.***

>[!TIP]
>
> Punto 2 --> Para ver el .pas completo ir a [*punto2.pas*](/practica2/punto2.pas).


## 🟣 Punto 3

***El encargado de ventas de un negocio de productos de limpieza desea administrar el stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los productos que comercializa. De cada producto se maneja la siguiente información: código de producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se genera un archivo detalle donde se registran todas las ventas de productos realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide realizar un programa con opciones para:***

* ***Actualizar el archivo maestro con el archivo detalle, sabiendo que:***

***i. Ambos archivos están ordenados por código de producto.***

***ii. Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del archivo detalle.***

***iii. El archivo detalle sólo contiene registros que están en el archivo maestro.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
procedure Leer(var detalle:ventas; var v:ventaR);
begin
    if(not Eof(detalle)) then
      read(detalle,v)
    else 
      v.cod := valorAlto;
end;

{punto a) --> Actualizar el archivo maestro con el archivo detalle}
procedure actualizar(var maestro:productos; var detalle:ventas);
var
    v:ventaR;
    p:productoR;
    aux:integer;
begin
    Reset(maestro);
    Reset(detalle);
    Leer(detalle,v);
    while (v.cod <> valorAlto) do begin
      Read(maestro,p);
      aux:=0;
      while (v.cod = p.cod) do
        aux+=v.cant;
      p.stockAct-=aux;
      Seek(maestro,FilePos(maestro)-1);
      Write(maestro,p);
      Leer(detalle,v);
    end;
    Close(maestro);
    Close(detalle);
end;
~~~

</details>

* ***Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo stock actual esté por debajo del stock mínimo permitido.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
{punto b) --> Listar en txt los productos con stock actual por debajo del stock mínimo.}
procedure listarStock(var maestro:productos; var txt:Text);
var
    p:productoR;
begin
    Rewrite(txt);
    Reset(maestro);
    while (not Eof(maestro)) do begin
      Read(maestro,p);
      if(p.stockAct<p.stockMin)then
        WriteLn(txt,p.cod,p.precio,p.stockAct,p.stockMin,p.nombre);
    end;
    Close(txt);
    Close(maestro);
end;
~~~

</details>

>[!TIP]
>
> Punto 3 --> Para ver el .pas completo ir a [*punto3.pas*](/practica2/punto3.pas).

## 🟣 Punto 4

***A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
Program punto4;
const
    valorAlto = 'ZZZZ';
type
    provinciaR = record
        nombre:string;
        cantALf:integer;
        cantEnc:integer;
    end;
    agenciaR = record
        nombreProv:string;
        codLoc:integer;
        cantAlf:integer;
        cantEnc:integer;
    end;
    provincia = file of provinciaR;
    agencia = file of agenciaR;

procedure Minimo(var a1,a2,min:agenciaR; var detalle1,detalle2:agencia);
begin
    if(a1.nombreProv <= a2.nombreProv)then begin
      min := a1;
      Leer(detalle1,a1);
    end
    else begin
      min := a2;
      Leer(detalle2,a2);
    end;
end;

procedure Leer(var detalle:agencia;var a: agenciaR);
begin
    if(not Eof(detalle))then
      Read(detalle,a)
    else
      a.nombreProv:=valorAlto;
end;

{actualizar archivo maestro desde los dos archivos detalle}
procedure ActualizarMaestro(var maestro:provincia;var detalle1,detalle2: agencia);
var
    min,a1,a2=agenciaR;
    p=provinciaR;
begin
    {abrir archivos}
    Reset(maestro);
    Reset(detalle1);
    Reset(detalle2);

    Leer(detalle1,a1);
    Leer(detalle2,a2);
    Minimo(a1,a2,min);
    while (min.nombre <> valorAlto) do begin
        Read(maestro,p);
        while (p.nombre <> min.nombre) do 
          Read(maestro,p);
        while (p.nombre = min.nombre) do begin
          p.cantALf += min.cantALf;
          p.cantEnc += min.cantEnc;
          Minimo(a1,a2,min);
        end;
        Seek(maestro,FilePos(maestro)-1);
        Write(maestro,p);
    end;

    {cerrar archivos}
    Close(maestro);
    Close(detalle1);
    Close(detalle2);
end;

{programa principal}
var
    maestro:provincia;
    detalle1,detalle2:agencia;
begin
    Assign(maestro,'archivomaestro');
    Assign(detalle1,'archivodet1');
    Assign(detalle2,'archivodet2');
    {CargarDet1(detalle1);
    CargarDet2(detalle2);  --> tendré que cargar los archivos detalle desde un txt ??}
    ActualizarMaestro(maestro,detalle1,detalle2);
end.
~~~

</details>

***NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle pueden venir 0, 1 ó más registros por cada provincia.***

## 🟣 Punto 5

***Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados. De cada producto se almacena: código del producto, nombre, descripción, stock disponible, stock mínimo y precio del producto. Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo maestro. La información que se recibe en los detalles es: código de producto y cantidad vendida. Además, se deberá informar en un archivo de texto: nombre de producto, descripción, stock disponible y precio de aquellos productos que tengan stock disponible por debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el mismo procedimiento de actualización, o realizarlo en un procedimiento separado (analizar ventajas/desventajas en cada caso).***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~

~~~

</details>

***Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle puede venir 0 o N registros de un determinado producto.***

<br>
<br>
<br>

<p><img align="center" src="https://github.com/Marimari2342/Marimari2342/blob/main/firmagith.png" alt="marigit"/></p>
