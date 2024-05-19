Program punto3;
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

procedure Leer(var detalle:ventas; var v:ventaR);
begin
    if(not Eof(detalle)) then
      read(detalle,v)
    else 
      v.cod := valorAlto;
end;

{punto a) --> Actualizar el archivo maestro con el archivo detalle}
procedure actualizar(var maestro:productos; var detalle:ventas);
var
    v:ventaR;
    p:productoR;
    aux:integer;
begin
    Assign(maestro,'archivomaestro');
    Assign(detalle,'archivodetalle');
    Reset(maestro);
    Reset(detalle);
    Leer(detalle,v);
    while (v.cod <> valorAlto) do begin
      Read(maestro,p);
      while (v.cod <> p.cod) do
        Read(maestro,p);
      aux:=0;
      while (v.cod = p.cod) do
        aux+=v.cant;
        Leer(detalle,v);
      p.stockAct-=aux;
      Seek(maestro,FilePos(maestro)-1);
      Write(maestro,p);
    end;
    Close(maestro);
    Close(detalle);
end;

{punto b) --> Listar en txt los productos con stock actual por debajo del stock mínimo.}
procedure listarStock(var maestro:productos; var txt:Text);
var
    p:productoR;
begin
    Assign(txt,'stock_minimo.txt');
    Rewrite(txt);
    Reset(maestro);
    while (not Eof(maestro)) do begin
      Read(maestro,p);
      if(p.stockAct<p.stockMin)then
        WriteLn(txt,p.cod,p.precio,p.stockAct,p.stockMin,p.nombre);
    end;
    Close(txt);
    Close(maestro);
end;

{menu de opciones}
procedure menu(var maestro:productos; var detalle:ventas; var txt:Text);
var
    opMenu:integer;
begin
    opMenu:=1;
    while (opMenu>0 and opMenu<=2) do begin
      WriteLn('Ingrese la opción que desea: ');
      WriteLn('1 --> Actualizar el archivo maestro.');
      WriteLn('2 --> Listar en archivo de texto productos con stock actual por debajo del stock mínimo.');
      WriteLn('Cualquier otro numero para salir.');
      case opMenu of
        1:actualizar(maestro,detalle);
        2:listarStock(maestro,txt);
      end;
    end;
end;

{programa principal}
var
    maestro:productos;
    detalle:ventas;
    txt:Text;
begin
    menu(maestro,detalle,txt); {realizar un programa con opciones para --> menu??}
end.