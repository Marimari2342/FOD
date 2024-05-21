Program examen2;
const
    valorAlto = '9999999';
    N = 100;
type
    alumnoR = record
        dni_alumno:string[7];
        codigo_carrera:string[4];
        monto_total_pagado:real;
    end;
    archiRapiR = record
        dni_alumno:string[7];
        codigo_carrera:string[4];
        monto_cuota:real;
    end;
    maestro = file of alumnoR;
    detalle = file of archiRapiR;
    vecDet = array [1..N] of detalle;
    vecArcRap = array [1..N] of archiRapiR;

procedure leer (var d:detalle;var dato:archiRapiR);
begin
  if(not Eof(d)) then
    read(d,dato)
  else  
    dato.dni_alumno:=valorAlto;
end;

procedure minimo (var d:detalle; var v:vecArcRap; var min:archiRapiR);
var
    i,minInd:integer;
begin  
    {codigo}
end;

{procedimiento a) Se debe realizar un procedimiento que dado el archivo con información
de los alumnos inscriptos y los N archivos que envía RapiPago, actualice la información
de lo que ha pagado cada alumno hasta el momento en cada carrera inscripto}
procedure actualizar (var m:maestro; var d:vecDet);
var
    aV:vecArcRap;
    min:archiRapiR;
    i:integer;
begin
    Assign(m,'maestro');
    Reset(m);
    for i := 1 to N do begin
      Assign(d[i],'detalle',i);
      Reset(d[i]);
      leer(d[i],v[i]);
    end;
    {codigo}
end;

{procedimiento b)}

{programa principal}
var
    m:maestro;
    d:vecDet;
begin
    actualizar(m,d);
end.