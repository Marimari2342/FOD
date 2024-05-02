Program punto5y6;
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

{Exportar el archivo creado en a) al archivo de texto: “celulares.txt”, respetando el formato dado en la NOTA 2.}
procedure exportar(var arc_cel: celulares);
var
    txt: Text;
    c: celR;
begin
    {abro el archivo creado en a)}
    Reset(arc_cel);
    {creo y abro el archivo “celulares.txt”}
    Assign(txt,'celulares.txt');
    Rewrite(txt);
    {voy leyendo y exportando los celulares uno a uno (NOTA2)}
    while (not Eof(arc_cel)) do begin
      Read(arc_cel,c);
      WriteLn(txt,c.cod,' ',c.precio,' ',c.marca); {NOTA 2 --> Linea1: código, precio y marca}
      WriteLn(txt,c.stockDisp,' ', c.stockMin, ' ', c.descr); {NOTA 2 --> Linea2: stock disponible, stock mínimo y descripción}
      WriteLn(txt,c.nombre,' '); {NOTA 2 --> Linea3: nombre}
    end;
    {cierro ambos archivos}
    Close(arc_cel);
    Close(txt);
end;

{PUNTO6}
procedure leerCel(var c:celR);
begin
    WriteLn('Ingrese codigo, precio, marca, stock disponible, stock minimo, descripcion y nombre');
    readln(c.cod);
    readln(c.precio);
    readln(c.marca);
    readln(c.stockDisp);
    readln(c.stockMin);
    readln(c.descr);
    readln(c.nombre);
end;

{PUNTO6: Añadir uno o más celulares al final del archivo con datos ingresados por teclado.}
procedure añadir(var arc_cel: celulares);
var
    c:celR;
    opcion:Char;
    ok:Boolean;
begin
    ok:=true;
    Reset(arc_cel);
    Seek(arc_cel,FileSize(arc_cel));
    while (ok) do begin
      leerCel(c);
      WriteLn('Indique si quiere ingresar otro celular [s/n]');
      ReadLn(opcion);
      if(opcion='n')then
        ok:=false;
      Write(arc_cel,c);
    end;
    Close(arc_cel);
end;

{PUNTO6: Modificar el stock de un celular dado.}
procedure modificarStock(var arc_cel:celulares);
var
    c:celR;
    aux:string[15];
    encontre:Boolean;
begin
    Reset(arc_cel);
    encontre:=false;
    {Pedir que ingrese el nombre del celular}
    WriteLn('Ingrese el nombre del celular que busca: ');
    ReadLn(aux);
    {Recorrer el archivo de celulares para buscar el celular}
    while (not Eof(arc_cel) and (not encontre)) do begin
      read(arc_cel,c);
      if(c.nombre=aux) then
        encontre:=true;
    end;
    if(encontre)then begin {Si encuentro el celular}
      WriteLn ('Ingrese nuevo stock'); {Cambio el stock}
      ReadLn(c.stockDisp);
      Write(arc_cel,c); 
    end
    else {si no lo encuentro}
      WriteLn('El celular no se encuentra en el archivo.'); {aviso que no lo encontre}
    Close(arc_cel);
end;

{Exportar al archivo "SinStock.txt" los celulares con stock = 0}
procedure exportarSinStock(var arc_cel:celulares)
var
    txt:Text;
    c:celR;
begin
    Reset(arc_cel);
    {Crear archivo "SinStock.txt"}
    Assign(txt,'SinStock.txt');
    Rewrite(txt);
    {Recorrer el archivo de celulares y fijarme los que tienen stock = 0}
    while (not Eof(arc_cel)) do begin
      Read(arc_cel,c);
      {Si hay algun stock = 0 lo guardo en el archivo nuevo}
      if(c.stockDisp = 0) then begin
        WriteLn(txt,c.cod,' ',c.precio,' ',c.marca); {NOTA 2 --> Linea1: código, precio y marca}
        WriteLn(txt,c.stockDisp,' ', c.stockMin, ' ', c.descr); {NOTA 2 --> Linea2: stock disponible, stock mínimo y descripción}
        WriteLn(txt,c.nombre,' '); {NOTA 2 --> Linea3: nombre}
      end;
    end;
    Close(arc_cel);
    Close(txt);
end;

{menu}
procedure menu(var arc_cel: celulares);
var
    opMenu:Integer;
begin
    opMenu:=1;
    while(opMenu>0 and opMenu<=6)do begin
      writeln('Ingrese la opcion que desea');
      writeln('1 --> Listar en pantalla celulares con un stock menor al stock mínimo.');
      writeln('2 --> Listar en pantalla celulares que coincidan con descripción ingresada.');
      writeln('3 --> Exportar al archivo “celulares.txt”.');
      writeln('4 --> Añadir celulares al archivo.');
      writeLn('5 --> Modificar el stock de un celular dado.');
      writeLn('6 --> Exportar al archivo "SinStock.txt" los celulares con stock = 0.');
      writeln('Cualquier otro --> Salir.');
      read(opMenu);
      case opMenu of
        1:listarStkMenor(arc_cel);
        2:buscarDesc(arc_cel);
        3:exportar(arc_cel);
        4:añadir(arc_cel);
        5:modificarStock(arc_cel);
        6:exportarSinStock(arc_cel);
      end;
    end;
end;
{programa pincipal}
var
    arc_cel:celulares;
begin
    carga(arc_cel);
    menu(arc_cel);
end.