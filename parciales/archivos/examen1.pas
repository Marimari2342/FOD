Program examen1;
const
    valorAlto = '9999';
    N = 30;
type
    ventaR = record
        cod_farmaco:string[4];
        nombre:string[20];
        fecha:string[10];
        cantidad_vendida:integer;
        forma_pago:string[7];
    end;
    detalle = file of ventaR;
    vecDet = array [1..N] of detalle;
    vecVent = array [1..N] of ventaR;

procedure leer (var d:detalle; var v:ventaR);
begin
    if (not Eof(d)) then
      read(d,v)
    else 
      v.cod_farmaco := valorAlto;
end;

procedure minimo (var d:vecDet; var v:vecVent; var min: ventaR);
var
    i,minInd:integer;
begin
    min.cod_farmaco:=valorAlto;
    for i := 1 to N do begin
      if (v[i].cod_farmaco<=min.cod_farmaco)then begin
        min:=v[i];
        minInd:=i;
      end;
    end;
    read(d[minInd],v[minInd]);
end;

{programa principal}
var

begin
  
end.