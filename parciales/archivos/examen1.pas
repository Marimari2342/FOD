Program examen1;
const
    valorAlto = '9999';
    N = 30;
type
    subDia = 1..31;
    subMes = 1..12;
    fechR = record
        dia:subDia;
        mes:subMes;
    end;
    ventaR = record
        cod_farmaco:string[4];
        nombre:string[20];
        fecha:fecR;
        cantidad_vendida:integer;
        forma_pago:string[7];
    end;
    detalle = file of ventaR;
    vecDet = array [1..N] of detalle;
    vecVent = array [1..N] of ventaR;
    vecFech = array [1..31] of integer; 

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
{Hago un corte de control farmaco por farmaco y me guardo el que tiene más ventas.}
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

{Recibe los 30 archivos de ventas e informa por pantalla la fecha en la que se produjeron
más ventas al contado mostrando fecha y cantidad de pagos contado.}
{Armo un vector contador en donde cargo los pagos al contado para cada fecha.
Luego recorro el vector buscando el máximo.
Supongo que no puedo hacer corte de control porque primeramente se ordena por codigo. ??}
procedure punto_b (var d:vecDet);
var
    vF:vecFech;
    i,maxCant,maxDia:integer;
    min:ventaR;
begin
    {poner en cero el vector contador de ventas}
    for i := 1 to subDia do
        vF[i] := 0;
    for i := 1 to N do begin
      Reset(d[i]);
      leer(d[i],v[i]);
    end; 
    minimo(d,v,min);
    while (min.cod_farmaco<>valorAlto) do begin
      if(min.forma_pago='contado') then
        vF[min.fecha.subDia]+=1;
      minimo(d,v,min);
    end;
    maxCant:=0;
    for i := 1 to subDia do
      if (vF[i]>maxCant) then begin
        maxCant := vF[i];
        maxDia := i;
      end;
    WriteLn('La fecha en la que se produjeron más ventas es: ',maxDia,' con ',maxCant,' ventas.');
end;

{codigo del c}

{programa principal}
var
  i:integer;
  d:vecDet;
begin
  for i := 1 to N do
    Assign(d[i],'detalle',i); {preguntar si se concatenaba así o como}
  punto_a(d);
end.