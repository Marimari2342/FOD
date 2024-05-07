Program punto3;
const
    valorAlto=99999;
type
    productoR = record
        cod:integer;
        nombre:string[20];
        precio:real;
        stockAct:integer;
        stockMin:integer;
    end;
    ventaR = record
        cod:integer;
        cant:integer;
    end;
    productos = file of productoR;
    ventas = file of ventaR;

{programa principal}
var
begin
  
end.