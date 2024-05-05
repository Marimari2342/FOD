Program punto1;
type
    empR = record
        cod:integer;
        nombre:string[15];
        monto:real;
    end;
    comisiones = file of empR;
procedure Compactar();
var
    comisiones:Text;
    arc_comp:Text;
begin
    {asignar a variable y abrir archivo que voy a leer}
    Assign(comisiones,'comisiones.txt');
    Reset(comisiones);
    {asignar a variable y crear archivo donde voy a guardar}
    Assign(arc_comp,'compactado.txt');
    Rewrite(arc_comp);
    

    {cerrar archivos}
    Close(arc_comp);
    Close(comisiones);
end;

{programa principal}
begin
    Compactar();
end.