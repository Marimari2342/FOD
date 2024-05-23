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