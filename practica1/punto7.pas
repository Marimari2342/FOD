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

{agregar una novela}
procedure agregarNov(var arc_nov:novelas);
var

begin
end;

{modificar una novela existente}
procedure modificarNov(var arc_nov:novelas);
var

begin
end;

{menu}
procedure menu(var arc_nov:novelas);
var
    opMenu:integer;
begin
    opMenu:=1;
    while(opMenu>0 and opMenu<=2)do begin
      writeln('Ingrese la opcion que desea');
      writeln('1 --> Agregar una novela.');
      writeln('2 --> Modificar una novela existente.');
      writeln('Cualquier otro --> Salir.');
      read(opMenu);
      case opMenu of
        1:agregarNov(arc_nov);
        2:modificarNov(arc_nov);
      end;
    end;
end;

{programa principal}
var
    arc_nov = novelas;
begin
    carga(arc_nov);
    menu(arc_nov);
end.