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
    Assign(maestro,'maestro');
    Assign(detalle,'detalle');
    Reset(maestro);
    Reset(detalle);
    Leer(detalle,mat); 
    while (mat.cod<>valorAlto) do begin
      Read(maestro,alu);
      cantC:=0;
      canF:=0;
      while (mat.cod<>alu.cod) do
        Read(maestro,alu); {el alumno en detalle puede estar 0 veces}
      while (mat.cod = alu.cod) do begin
        if(mat.cursadaOfinal='c')then
          canC+=1;
        if(mat.cursadaOfinal='f')then begin
          cantF+=1;
          canC-=1;
        end;
        Leer(detalle,mat);
      end;
      alu.cantMatCursadas+=canC;
      alu.cantMatFinalApr+=canF;
      seek (maestro,filePos (maestro)-1);
      write (maestro,alu);
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
    Assign(txt,'alumnosmasfinales.txt');
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
    Assign(maestro,'archivomaestro');
    Assign(detalle,'archivodetalle');
    Reset(maestro);
    Reset(detalle);
    Leer(detalle,v);
    while (v.cod <> valorAlto) do begin
      Read(maestro,p);
      while (v.cod <> p.cod) do
        Read(maestro,p);
      aux:=0;
      while (v.cod = p.cod) do
        aux+=v.cant;
        Leer(detalle,v);
      p.stockAct-=aux;
      Seek(maestro,FilePos(maestro)-1);
      Write(maestro,p);
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
    Assign(txt,'stock_minimo.txt');
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

procedure Leer(var detalle:agencia;var a: agenciaR);
begin
    if(not Eof(detalle))then
      Read(detalle,a)
    else
      a.nombreProv:=valorAlto;
end;

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

{actualizar archivo maestro desde los dos archivos detalle}
procedure ActualizarMaestro(var maestro:provincia;var detalle1,detalle2: agencia);
var
    min,a1,a2=agenciaR;
    p=provinciaR;
begin
    {asignar}
    Assign(maestro,'archivomaestro');
    Assign(detalle1,'archivodet1');
    Assign(detalle2,'archivodet2');
    {abrir archivos}
    Reset(maestro);
    Reset(detalle1);
    Reset(detalle2);
    {leer de cada archivo detalle para luego buscar el minimo entre ambos}
    Leer(detalle1,a1);
    Leer(detalle2,a2);
    Minimo(a1,a2,min,detalle1,detalle2);
    while (min.nombre <> valorAlto) do begin
        Read(maestro,p);
        while (p.nombre <> min.nombre) do {esto es porque el registro puede estar 0 veces}
          Read(maestro,p);
        while (p.nombre = min.nombre) do begin {esto es porque puede estar más de una vez}
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
    ActualizarMaestro(maestro,detalle1,detalle2);
end.
~~~

</details>

***NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle pueden venir 0, 1 ó más registros por cada provincia.***

>[!TIP]
>
> Punto 4 --> Para ver el .pas completo ir a [*punto4.pas*](/practica2/punto4.pas).

## 🟣 Punto 5

***Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados. De cada producto se almacena: código del producto, nombre, descripción, stock disponible, stock mínimo y precio del producto. Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo maestro. La información que se recibe en los detalles es: código de producto y cantidad vendida. Además, se deberá informar en un archivo de texto: nombre de producto, descripción, stock disponible y precio de aquellos productos que tengan stock disponible por debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el mismo procedimiento de actualización, o realizarlo en un procedimiento separado (analizar ventajas/desventajas en cada caso).***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~
Program punto5;
const
    valorAlto = 9999;
    N = 30;
type
    productoR = record
        cod:Integer;
        nombre:String[20];
        desc:String[40];
        stockDisp:integer;
        stockMin:integer;
        precio:real;
    end;
    prod_sucR = record
        cod:Integer;
        cantVend:Integer;
    end;
    maestro = file of productoR;
    detalle = file of prod_sucR;
    vecDet = array [1..N] of detalle;
    vecProd = array [1..N] of prod_sucR;
    
procedure leer(var d: detalle; var p:prod_sucR);
begin
  if(not eof(d)) then
    read(d,p)
  else 
    p.cod:=valorAlto;
end;

procedure minimo(var d:vecDet; var p:vecProd; var min:prod_sucR);
var
    i,minInd:integer;
begin
    min.cod:=valorAlto;
    for i := 1 to N do
      if (d[i].cod <= min.cod) then begin
        min := d[i];
        minInd := i;
      end;
    read(d[minInd],p[minInd]);
end;

procedure actualizar(var m:maestro; var d:vecDet);
var
    min:prod_sucR;
    i:integer;
    v:vecProd;
    prod:productoR;
begin
    {asignar, abrir y leer}
    Assign(m,'maestro');
    Reset(m);
    for i := 1 to N do begin
      Assign(d[i],'detalle',i);
      Reset(d[i]);
      leer(d[i],v[i]);
    end;
    minimo(d,v,min);
    {codigo}
    while(min.cod<>valorAlto)do begin
      read(m,prod);
      while(prod.cod<>min.cod)do {pueden haber 0 registros para este codigo}
        read(m,prod);
      while(prod.cod=min.cod)do begin
        prod.stockDisp-=min.cantVend;
        minimo(d,v,min);
      end;
      Seek(m,FilePos(m)-1);
      Write(m,prod);
    end;
    {cerrar}
    for i := N downTo 1 do
      Close(d[i]);
    Close(m); 
end;

procedure informarStock(var m:maestro; var txt:Text);
var
    p:productoR;
begin
    Assign(txt,'archivo.txt');
    Rewrite(txt);
    Reset(m);
    while (not Eof(m)) do begin
      read(m,p);
      if(p.stockDisp<p.stockMin)then
        WriteLn(txt,'Nombre: ',p.nombre,', Descripcion: ',p.desc,', Stock Disponible: ',p.stockDisp,', Precio: ',p.precio);
    end;
    Close(m);
    Close(txt);
end;

{programa principal}
var
    m:maestro;
    d:vecDet;
    txt:Text;
begin
    actualizar(m,d);
    informarStock(m,txt);
end.
~~~

</details>

***Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle puede venir 0 o N registros de un determinado producto.***

>[!TIP]
>
> Punto 5 --> Para ver el .pas completo ir a [*punto5.pas*](/practica2/punto5.pas).

## 🟣 Punto 8

***Se cuenta con un archivo que posee información de las ventas que realiza una empresa a los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el cliente. Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por la empresa.***

***El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año, mes, día y monto de la venta. El orden del archivo está dado por: cod cliente, año y mes.***

***NOTA: tenga en cuenta que puede haber meses en los que los clientes no realizaron compras. No es necesario que informe tales meses en el reporte.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~

~~~

</details>

<p align=center>🟣</p>
<p align=center>🟣</p>
<p align=center>🟣</p>


>[!NOTE]
>
> * ***Para descargar la practica (del 2024) en PDF, click [<code>AQUÍ</code>](https://drive.google.com/file/d/1eauEqRcOL4IuguWcrluV2LTto_VK3y78/view?usp=sharing).***

<br>
<br>
<br>

<p><img align="center" src="https://github.com/Marimari2342/Marimari2342/blob/main/firmagith.png" alt="marigit"/></p>
