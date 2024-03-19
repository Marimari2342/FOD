Program punto2;
type
    numeros = file of integer;
procedure procesar(var aN:numeros; var prom:real; var men:integer);
var 
	num,suma,cant:integer;
begin
	reset(aN);
    suma:=0;
	while (not eof(aN)) do begin
        read(aN,num); 
        writeln(num);
        suma:=suma+num;     {suma y cant son para sacar el promedio}
        cant:=cant+1;
        if (num<1500)then 
            men:=men+1
    end;
    close(aN);
    if (cant<>0) then
        prom:=suma/cant;
end;
var
    archivoN : numeros;
    prom: real;
    num,men: integer;
    nombre : string;
begin
    writeln ('Ingrese el nombre del archivo'); {ingreso nombre y lo asigno al archivo}
    read(nombre);
    Assign(archivoN,nombre);    {conecto nombre fisico y nombre logico}
    Rewrite(archivoN);          {creo el archivo}
    read(num);
    while (num <> 30000) do begin
        write(archivoN,num);
        read(num);
    end;
    close(archivoN);            {cierro el archivo}
    men:=0;
    procesar(archivoN,prom,men);
    WriteLn('Cantidad de numeros menores a 1500: ',men);
    WriteLn('Promedio de los numeros ingresados: ',prom);
end.