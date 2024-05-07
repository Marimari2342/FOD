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

{crear los archivos maestro y detalle (vamos a suponer que se cargan desde un txt)}
procedure crearMaestro(var maestro:productos);
var
begin
end;

procedure crearDetalle(var detalle:ventas);
var
begin
end;

{punto a) --> Actualizar el archivo maestro con el archivo detalle}
procedure actualizar(var maestro:productos; var detalle:ventas);
var
begin
end;

{punto b) --> Listar en txt los productos con stock actual por debajo del stock mínimo.}
procedure listarStock(var maestro:productos; var txt:Text);
var
begin
end;

{menu de opciones}
procedure menu(var maestro:productos; var detalle:ventas; var txt:Text);
var
    opMenu:integer;
begin
    opMenu:=1;
    while (opMenu>0 and opMenu<=2) do begin
      WriteLn('Ingrese la opción que desea: ');
      WriteLn('1 --> Generar archivos binarios maestro y detalle.');
      WriteLn('2 --> Actualizar el archivo maestro.');
      WriteLn('3 --> Listar en archivo de texto productos con stock actual por debajo del stock mínimo.');
      case opMenu of
        1: begin
            crearMaestro(maestro);
            crearDetalle(detalle);
        end;
        2:actualizar(maestro,detalle);
        3:listarStock(maestro,txt);
      end;
    end;
end;

{programa principal}
var
    maestro:productos;
    detalle:ventas;
    txt:Text;
begin
    Assign(maestro,'archivomaestro');
    Assign(detalle,'archivodetalle');
    Assign(txt,'stock_minimo.txt');
    menu(maestro,detalle,txt); {realizar un programa con opciones para --> menu??}
end.