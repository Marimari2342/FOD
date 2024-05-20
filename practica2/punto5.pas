{actualizar archivo maestro con 30 detalles. --> N=30
0, 1 o más registros por producto en archivo detalle --> valorAlto
además... crear txt con información
}
Program punto5;
const
    valorAlto = 99999;
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
    {---en proceso---}
{programa principal}
var
begin
  
end.