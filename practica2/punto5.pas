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
    read(d[minInd],p[minInd]);
end;


{programa principal}
var
begin
  
end.