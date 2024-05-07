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

~~~

</details>

* ***Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo stock actual esté por debajo del stock mínimo permitido.***

<details><summary> <code> Respuesta 🖱 </code></summary><br>

~~~

~~~

</details>

<br>
<br>
<br>

<p><img align="center" src="https://github.com/Marimari2342/Marimari2342/blob/main/firmagith.png" alt="marigit"/></p>
