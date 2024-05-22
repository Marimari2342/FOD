Program examen8;
const
    valorAlto=9999;
    N = 20;
type
    productoR = record
        cod:integer;
        nombre:string[10];
        precio:real;
        stockAct:integer;
        stockMin:integer;
    end;
    ventaR = record
        cod:integer;
        cantVend:integer;
    end;
    maestro = file of productoR;
    detalle = file of ventaR;
    vecDet = array [1..N] of detalle;
    vecVent = array [1..N] of ventaR;

{PRECONDICIONES
Todos los archivos se encuentran ordenados por codigo de producto.
En un archivo detalle pueden haber 0, 1 o N registros de un producto determinado.
Cada archivo detalle sólo contiene productos que seguro existen en el archivo maestro.}
procedure leer(var d:detalle; var v:ventaR);
begin
  if(not Eof(d)) then
    Read(d,v)
  else 
    v.cod:=valorAlto;
end;

procedure minimo(var d:vecDet; var v:vecVent; var min: ventaR);
var
    i,minIn:integer;
begin
    min.cod:=valorAlto;
    for i := 1 to N do begin
      if (v[i].cod <= min.cod) then begin
        min:=v[i];
        minIn:=i;
      end;
    end;
    leer(d[minIn],v[minIn]);
end;

{Procedimiento que actualice el stock en el archivo maestro con la información disponible
en los archivos detalles y que informe en un archivo de texto aquellos productos cuyo 
monto total vendido en el día supere los $10000}
procedure actualizar_informar(var m: maestro; var d: vecDet; var txt:Text);
var
    v:vecVent;
    i:integer;
    min:ventaR;
    regM:productoR;
    gasto:real;
begin
    Assign(txt,'archivo.txt');
    Rewrite(txt);
    Assign(m,'maestro');
    Reset(m);
    for i := 1 to N do begin
      Assign(d[v],'detalle',i);
      Reset(d[i]);
      leer(d[i],v[i]);
    end;
    minimo(d,v,min);
    while (min.cod<>valorAlto) do begin
      Read(m,regM);
      while (regM.cod<>min.cod) do
        Read(m,regM);
      gasto:=0;
      while (regM.cod=min.cod) do begin
        regM.stockAct-=min.cantVend;
        gasto:=gasto+regM.precio*min.cantVend;
        minimo(d,v,min);
      end;
      if(gasto>10000)then
        WriteLn(txt,regM.cod,regM.precio,regM.stockAct,regM.stockMin,regM.nombre);
    end;
    for i := N downTo 1 do
      Close(d[i]);
    Close(m);
    Close(txt);
end;

{programa principal}
var
    m:maestro;
    d:vecDet;
    txt:Text;
begin
    actualizar_informar(m,d,txt);
end.