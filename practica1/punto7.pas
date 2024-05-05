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
procedure carga(var arc_nov: novelas; var txt: Text);
var
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

procedure leerNov(var n:novelaR);
begin
  WriteLn('Ingrese codigo, precio, genero y nombre en ese orden: ');
  ReadLn(n.cod);
  ReadLn(n.precio);
  ReadLn(n.genero);
  ReadLn(n.nombre);
end;

{agregar una novela --> No me indica como, voy a suponer que por teclado}
procedure agregarNov(var arc_nov:novelas);
var
    n:novelaR;
begin
    Reset(arc_nov);
    leerNov(n);
    Seek(arc_nov,FileSize(arc_nov));
    Write(arc_nov,n);
    Close(arc_nov);
end;

{modificar una novela existente}
procedure modificarNov(var arc_nov:novelas);
var
    n:novelaR;
    cod:Integer;
    encontre:Boolean;
begin
    Reset(arc_nov);
    WriteLn('Ingrese codigo de novela que quiere modificar: ');
    ReadLn(cod);
    encontre:=false;
    while (not Eof(arc_nov)and not encontre) do begin
      Write(arc_nov,n);
      if (n.cod = cod) then
        encontre:=true;
    end;
    if (encontre) then begin
      WriteLn('Ingrese nuevos datos de la novela: ');
      leerNov(n);
      Seek(arc_nov,FilePos(arc_nov)-1);
      Write(arc_nov,n);
    end
    else
      WriteLn('No se encontró la novela.');
    Close(arc_nov);
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
    arc_nov : novelas;
    txt : Text;
begin
    carga(arc_nov,txt);
    menu(arc_nov);
end.