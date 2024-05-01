Program punto5;
type
    celR = record
        cod: integer;
        nombre: string[15];
        descr: string[50];
        marca: string[15];
        precio: real;
        stockMin: integer;
        stockDisp: integer;
    end;
    celulares = file of celR;

{asignar nombre al archivo (NOTA1)}
procedure asignar(var arc_cel:celulares);
var
    nombre:string[15];
begin
    WriteLn('Ingrese nombre de archivo: ');
    readln(nombre);
    Assign(arc_cel,nombre);
end;
{carga de registros de celulares (no ordenados) desde un archivo de texto}
procedure carga(var arc_cel:celulares);
var
    txt:Text;
    c:celR;
begin
    asignar(arc_cel); {Asigno nombre al archivo}
    Rewrite(arc_cel); {Abro archivo en donde guardaré los datos (por primera vez)}
    Assignn(txt,'celulares.txt');
    Reset(txt); {Reabro archivo desde donde voy a leer}
    while(not Eof(txt)) do begin {siempre poner los string al final de la linea}
        readln(txt,c.cod,c.precio,c.marca); {carga especificada en NOTA2}
        readln(txt,c.stockDisp,c.stockMin,c.descr);
        readln(txt,c.nombre);
        write(arc_cel, c);
    end;
    Close(arc_cel);
    Close(txt);
end;

procedure imprCel(c:celR);
begin
    WriteLn('Codigo: '+ c.cod + ', Nombre: ' + c.nombre +
    ', Descripción: '+ c.descr + ', Marca: ' + c.marca + 
    ', Precio: ' + c.precio + ', Stock Minimo: ' + c.stockMin + 
    ', Stock Disponible: ' + c.stockDisp);
end;

{Listar en pantalla celulares con un stock menor al stock mínimo.}
procedure listarStkMenor(var arc_cel:celulares);
var
    c:celR;
    aux:Boolean;
begin
    reset(arc_cel);
    aux:=false;
    {Leo uno por uno los celulares del archivo de celulares}
    while (not Eof(arc_cel)) do begin
      Read(arc_cel,c);
      if(c.stockDisp<c.stockMin) then begin {Comparo los stock}
        if(not aux) then begin
          WriteLn('Celulares con un stock menor al stock minimo: ');
          aux:=true;
        end;
        {Muestro en pantalla los que el stock es menor al minimo (PROCED)}
        imprCel(c);
      end;
    end;
    if(not aux)then
      WriteLn('No se encontraron celulares con un stock menor al mínimo.');
    Close(arc_cel);
end;

{Listar en pantalla celulares cuya descripción tenga cadena de caracteres dada por el usuario.}
procedure buscarDesc(var arc_cel:celulares);
var
    des: string[50];
    aux: Boolean;
    c: celR;
begin
    Reset(arc_cel);
    aux:=false;
    WriteLn('Ingrese descripción: ');
    ReadLn(aux);
    while (not Eof(arc_cel)) do begin
      Read(arc_cel,c);
      if(aux = c.descr) then begin
        if(not aux) then begin
            aux:=true;
            WriteLn('Lista de celulares que coinciden con la descripción ingresada: ');
        end;
      end;
      imprCel(c);
    end;
    if(not aux)then 
        WriteLn('No se encontraron coincidencias.');
    Close(arc_cel);
end;

{menu}
procedure menu(var arc_cel: celulares);
var
    opMenu:Integer;
begin
    opMenu:=1;
    while(opMenu>0 and opMenu<=2)do begin
      writeln('Ingrese la opcion que desea');
      writeln('1 --> Listar en pantalla celulares con un stock menor al stock mínimo.');
      writeln('2 --> Listar en pantalla celulares que coincidan con descripción ingresada.');
      writeln('Cualquier otro --> Salir.');
      read(opMenu);
      case opMenu of
        1:listarStkMenor(arc_cel);
        2:buscarDesc(arc_cel);
      end;
    end;
end;
{programa pincipal}
var
    arc_cel:celulares;
begin
    carga(arc_cel);  
end.