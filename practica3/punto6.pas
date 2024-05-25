program punto6;
type
    prendaR = record
        cod_prenda:integer;
        descripción:string[30];
        colores:string[10];
        tipo_prenda:string[10];
        stock:integer;
        precio_unitario:real;
    end;
    maestro = file of prendaR;
    detalle = file of integer;

{actualizar prendas con un archivo que indica cod_prenda de las prendas que 
quedan obsoletas --> ELIMINAR
baja logica --> modificar el stock de la prenda correspondiente a valor negativo}
procedure baja_prenda (var m:maestro; var d:detalle);
var
begin
end;

{copiar las prendas que no están marcadas como borradas --> compactación del archivo 
renombrar el archivo nuevo con el nombre del archivo maestro original}
procedure compactar (var m,mN:maestro);
var
begin
end;

{programa principal}
var
    m,mN:maestro;
    d:detalle;
begin
    baja_prenda(m,d);
    compactar(m,mN);
end.