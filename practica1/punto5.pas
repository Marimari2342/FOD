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
        readln(txt,c.cod,c.precio,c.marca);
        readln(txt,c.stockMin,c.stockDisp,c.descr);
        readln(txt,c.nombre);
        write(arc_cel, c);
    end;
    Close(arc_cel);
    Close(txt);
end;


{menu}

{programa pincipal}
var
    arc_cel:celulares;
begin
    carga(arc_cel);  
end.