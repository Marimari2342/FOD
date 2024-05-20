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

{Recibe los 30 archivos de ventas e informa por pantalla el fármaco con mayor 
cantidad_vendida. --> corte de control}
procedure punto_a (var d:vecDet);
var
    i:integer;
    v:vecVent;
    min,farmMasVend,act:ventaR;
    cantAct,codAct:integer;
begin
    for i := 1 to N do begin
      Reset(d[i]);
      leer(d[i],v[i]);
    end; 
    minimo(d,v,min);
    farmMasVend.cantidad_vendida:=0;
    while(min.cod_farmaco<>valorAlto)do begin
      act.cantidad_vendida:=0;
      act.cod_farmaco:=min.cod_farmaco;
      while(codAct=min.cod_farmaco)do begin
        cantAct+=min.cantidad_vendida;
        minimo(d,v,min);
      end;
      if (act.cantidad_vendida>=farmMasVend.cantidad_vendida) then
        farmMasVend:=act;
    end;
    WriteLn('El farmaco más vendido es el ',farmMasVend.nombre,' con ',farmMasVend.cantidad_vendida,' ventas');
    for i := N downTo 1 do
      Close(d[i]); {preguntar si necesito cerrar los detalles también}
end;

{codigo del b y c}

{programa principal}
var
  i:integer;
  d:vecDet;
begin
  for i := 1 to N do
    Assign(d[i],'detalle',i); {preguntar si se concatenaba así o como}
  punto_a(d);
end.