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

<br>
<br>
<br>

<p><img align="center" src="https://github.com/Marimari2342/Marimari2342/blob/main/firmagith.png" alt="marigit"/></p>
