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

procedure minimo (var d:vecDet; var v:vecArcRap; var min:archiRapiR);
var
    i,minInd:integer;
begin  
    min.dni_alumno:=valorAlto;
    for i := 1 to N do begin
      if(d[i].dni_alumno<=min.dni_alumno)then begin
        min:=d[i];
        minInd:=i;
      end;
    end;
    read(d[minInd],v[minInd]);
end;

{procedimiento a) Se debe realizar un procedimiento que dado el archivo con información
de los alumnos inscriptos y los N archivos que envía RapiPago, actualice la información
de lo que ha pagado cada alumno hasta el momento en cada carrera inscripto}
procedure actualizar (var m:maestro; var d:vecDet);
var
    aV:vecArcRap;
    min:archiRapiR;
    i:integer;
    alu:alumnoR;
    carreraAct:string[4];
begin
    Assign(m,'maestro');
    Reset(m);
    for i := 1 to N do begin
      Assign(d[i],'detalle',i);
      Reset(d[i]);
      leer(d[i],v[i]);
    end;
    minimo(d,v,min);
    while(min.dni_alumno<>valorAlto)do begin
      read(m,alu);
      while(m.dni_alumno<>min.dni_alumno)do {esto es porque pueden haber 0 registros en el archivo detalle}
        read(m,alu);
      while(m.dni_alumno=min.dni_alumno)do begin
        carreraAct:=min.codigo_carrera;
        while (carreraAct=min.codigo_carrera) do begin
          m.monto_total_pagado+=min.monto_cuota;
          minimo(d,v,min);
        end;
      end;
    end;
    for i := N downTo 1 do 
        Close(d[i]);
    Close(m);
end;

{procedimiento b)Realice otro procedimiento que reciba el archivo con información de los
alumnos inscriptos y genere un archivo de texto con los alumnos que aún no han pagado
nada en las carreras que están inscriptos.}
procedure morosos(var m:maestro; var txt:Text);
var
    alu,aluAct:alumnoR;
    moroso:Boolean;
begin
    Assign(txt,'morosos.txt');
    Rewrite(txt);
    Reset(m);
    while (not Eof(m)) do begin
      read(m,alu);
      aluAct.dni_alumno:=alu.dni_alumno;
      moroso:=true;
      while (aluAct.dni_alumno=alu.dni_alumno)and(moroso) do begin
        if (alu.monto_total_pagado<>0) then
          moroso:=false;
        read(m,alu);
      end;
      if (moroso) then
        WriteLn(txt,aluAct.dni_alumno,' ',aluAct.codigo_carrera,' alumno moroso.');
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
    morosos(m,txt);
end.