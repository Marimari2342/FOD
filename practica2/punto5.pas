{actualizar archivo maestro con 30 detalles. --> N=30
0, 1 o más registros por producto en archivo detalle --> valorAlto
además... crear txt con información}
Program punto5;
const
    valorAlto = 9999;
    N = 30;
type
    productoR = record
        cod:Integer;
        nombre:String[20];
        desc:String[40];
        stockDisp:integer;
        stockMin:integer;
        precio:real;
    end;
    prod_sucR = record
        cod:Integer;
        cantVend:Integer;
    end;
    maestro = file of productoR;
    detalle = file of prod_sucR;
    vecDet = array [1..N] of detalle;
    vecProd = array [1..N] of prod_sucR;
    
procedure leer(var d: detalle; var p:prod_sucR);
begin
  if(not eof(d)) then
    read(d,p)
  else 
    p.cod:=valorAlto;
end;

procedure minimo(var d:vecDet; var p:vecProd; var min:prod_sucR);
var
    i,minInd:integer;
begin
    min.cod:=valorAlto;
    for i := 1 to N do
      if (d[i].cod <= min.cod) then begin
        min := d[i];
        minInd := i;
      end;
    leer(d[minInd],p[minInd]);
end;

procedure actualizar(var m:maestro; var d:vecDet);
var
    min:prod_sucR;
    i:integer;
    v:vecProd;
    prod:productoR;
begin
    {asignar, abrir y leer}
    Assign(m,'maestro');
    Reset(m);
    for i := 1 to N do begin
      Assign(d[i],'detalle',i);
      Reset(d[i]);
      leer(d[i],v[i]);
    end;
    minimo(d,v,min);
    {codigo}
    while(min.cod<>valorAlto)do begin
      read(m,prod);
      while(prod.cod<>min.cod)do {pueden haber 0 registros para este codigo}
        read(m,prod);
      while(prod.cod=min.cod)do begin
        prod.stockDisp-=min.cantVend;
        minimo(d,v,min);
      end;
      Seek(m,FilePos(m)-1);
      Write(m,prod);
    end;
    {cerrar}
    for i := N downTo 1 do
      Close(d[i]);
    Close(m); 
end;

procedure informarStock(var m:maestro; var txt:Text);
var
    p:productoR;
begin
    Assign(txt,'archivo.txt');
    Rewrite(txt);
    Reset(m);
    while (not Eof(m)) do begin
      read(m,p);
      if(p.stockDisp<p.stockMin)then
        WriteLn(txt,'Nombre: ',p.nombre,', Descripcion: ',p.desc,', Stock Disponible: ',p.stockDisp,', Precio: ',p.precio);
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
    informarStock(m,txt);
end.