program punto8; {CORTE DE CONTROL}
const
    valorAlto=9999;
type
    clienteR = record
        cod:integer;{.}
        nom:string;
        ape:string;
        anio:integer;{.}
        mes:integer;{.}
        dia:integer;
        monto:real;
    end;
    maestro = file of clienteR;

{procedimientos auxiliares}
procedure leer(var m:maestro;var c:clienteR);
begin
    if(not Eof(m))then
      read(m,c)
    else 
      c.cod:=valorAlto;
end;

procedure generar_reporte(var m:maestro);
var
    codAct,anioAct,mesAct:integer;
    c:clienteR;
    montoMes,montoAnio,montoTotal:real;
begin
    Reset(a);
    leer(a,c);
    montoTotal:=0;
    while (c.cod<>valorAlto) do begin
      codAct:=c.cod;
      WriteLn('Codígo: ',c.cod,'. Cliente: ',c.nom,' ',c.ape);
      while(c.cod=codAct)do begin
        montoAnio:=0;
        anioAct:=c.anio;
        while (c.cod=codAct)and(c.anio=anioAct) do begin
            montoMes:=0;
            mesAct:=c.mes;
            while (mesAct=c.mes)and(c.cod=codAct)and(c.anio=anioAct) do begin
                montoMes:=c.monto;
                leer(m,c);
            end;
            WriteLn('Gastos mensuales de ',mesAct,': ',montoMes);
            montoAnio+=montoMes;
        end;
        WriteLn('Gastos anuales de ',anioAct,': ',montoAnio);
        montoTotal:=montoAnio;
      end;
    end;
    WriteLn('El monto total recaudado por la empresa es: ',montoTotal);
    Close(a);
end;

{programa principal}
var
    m:maestro;
begin
    Assign(m,'maestro');
    generar_reporte(m);
end.