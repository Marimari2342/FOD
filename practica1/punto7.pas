{Crear un archivo binario a partir de la información almacenada en un archivo de texto. 
El nombre del archivo de texto es: “novelas.txt”. La información en el archivo de texto
consiste en: código de novela, nombre, género y precio de diferentes novelas argentinas.
Los datos de cada novela se almacenan en dos líneas en el archivo de texto. La primera
línea contendrá la siguiente información: código novela, precio y género, y la 
segunda línea almacenará el nombre de la novela.}
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
    
end;
{programa principal}
var
    arc_nov = novelas;
begin
    carga(arc_nov);
end.