Program punto1;
type
    numeros = file of integer;
procedure recorro(var aN:numeros);
var 
	num:integer;
begin
	reset(aN);
	while (not eof(aN)) do begin
        read(aN,num); 
        writeln(num);
    end;
    close(aN);
end;
var
    archivoN : numeros;
    num : integer;
    nombre : string;
begin
    writeln ('Ingrese el nombre del archivo');
    read(nombre);
    Assign(archivoN,nombre);
    Rewrite(archivoN);
    read(num);
    while (num <> 30000) do begin
        write(archivoN,num);
        read(num);
    end;
    close(archivoN);
    recorro(archivoN);
end.