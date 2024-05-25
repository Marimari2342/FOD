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
    arc_prenda = file of prendaR;
    arc_bajas = file of integer;

{actualizar prendas con un archivo que indica cod_prenda de las prendas que 
quedan obsoletas --> ELIMINAR
baja logica --> modificar el stock de la prenda correspondiente a valor negativo}
procedure baja_prenda (var arc_p:arc_prenda; var arc_b:arc_bajas);

{programa principal}
var

begin
  
end.