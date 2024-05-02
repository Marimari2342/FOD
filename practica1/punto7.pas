Program punto7;
type
    novelaR = record
        cod:Integer;
        nombre:string[30];
        genero:string[30];
        precio:real;
    end;
    novelas = file of novelaR;

{nombrar archivo binario}
procedure asignarNombre(var arc_nov: novelas);
var
    nombre:String;
begin
    WriteLn('Ingrese el nombre del archivo: ');
    ReadLn(nombre);
    Assign(arc_nov,nombre);
end;

{cargar archivo binario a partir del archivo de texto}
procedure carga(var arc_nov: novelas);
var
    txt: Text;
    n:novelaR;
begin
    {asignar nombre a archivo binario y abrir}
    asignarNombre(arc_nov);
    Rewrite(arc_nov);
    {asignar a txt = “novelas.txt” y abrir archivo de texto}
    Assign(txt,'novelas.txt');
    Reset(txt);
    {mientras no se termine el archivo de texto, cargar el archivo binario} 
    while (not Eof(txt)) do begin
        readLn(txt,n.cod,n.precio,n.genero);
        readLn(txt,n.nombre);
        write(arc_nov,n);
    end;
    {cerrar archivos}
    Close(arc_nov);
    Close()
end;

{programa principal}
var
    arc_nov = novelas;
begin
    carga(arc_nov);
end.