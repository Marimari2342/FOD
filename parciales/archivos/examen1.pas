{CORREGIDO}
Program examen1;
const
    valorAlto = 9999;
    N = 30;
type
    ventaR = record
        cod_farmaco:integer;
        nombre:string[20];
        fecha:string[5];
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
      if (v[i].cod_farmaco<=min.cod_farmaco)or((v[i].cod_farmaco<=min.cod_farmaco)and(v[i].fecha<=min.fecha)) then begin
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
    min,act:ventaR;
    canMax,cantAct,codAct:integer;
    nomMax:string[20];
begin
    for i := 1 to N do begin
      Reset(d[i]);
      leer(d[i],v[i]);
    end; 
    minimo(d,v,min);
    canMax:=0;
    while(min.cod_farmaco<>valorAlto)do begin
      act.cantidad_vendida:=0;
      act.cod_farmaco:=min.cod_farmaco;
      while(codAct=min.cod_farmaco)do begin
        cantAct+=min.cantidad_vendida;
        minimo(d,v,min);
      end;
      if (act.cantidad_vendida>=canMax) then begin
        canMax:=act.cantidad_vendida;
        nomMax:=act.nombre;
      end;
    end;
    WriteLn('El farmaco más vendido es el ',nomMax,' con ',canMax,' ventas');
    for i := N downTo 1 do
      Close(d[i]); 
end;

{Recibe los 30 archivos de ventas y guarda en un archivo de texto un resumen de ventas por
fecha y fármaco con el siguiente formato: cod_farmaco, nombre, fecha, cantidad_total_vendida
(el archivo de texto deberá estar organizado de manera tal que al tener que utilizarlo
pueda recorrer el archivo realizando la menor cantidad de lecturas posibles).}
procedure punto_b (var d:vecDet; var txt:Text);
var
  i,cantAct:integer;
  v:vecVent;
  min,act:ventaR;
begin
  Assign(txt,'archivo.txt');
  Rewrite(txt);
  for i := 1 to N do begin
    Reset(d[i]);
    leer(d[i],v[i]);
  end;
  minimo(d,v,min);
  while (min.cod_farmaco<>valorAlto) do begin
    act.cod_farmaco:=min.cod_farmaco;
    cantAct:=0;
    while(min.cod_farmaco=act.cod_farmaco)do begin
        cantAct+=min.cantidad_vendida;
        minimo(d,v,min);
    end;
    WriteLn(txt,act.cod_farmaco,act.fecha,cantAct,act.nombre);
  end;
  for i := N downTo 1 do
      Close(d[i]);
  Close(txt);
end;

{programa principal}
var
  i:integer;
  d:vecDet;
  txt:Text;
begin
  for i := 1 to N do
    Assign(d[i],'detalle',i); {preguntar si se concatenaba así o como}
  punto_a(d);
  punto_b(d,txt);
end.