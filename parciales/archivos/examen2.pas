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
{programa principal}
var

begin
  
end.