Program punto1;
type
    empR = record
        cod:integer;
        nombre:string[15];
        monto:real;
    end;

procedure Compactar();
var
    comisiones:Text;
    arc_comp:Text;
    eLei,eAcum:empR;
begin
    {asignar a variable y abrir archivo que voy a leer}
    Assign(comisiones,'comisiones.txt');
    Reset(comisiones);
    {asignar a variable y crear archivo donde voy a guardar}
    Assign(arc_comp,'compactado.txt');
    Rewrite(arc_comp);
    Read(comisiones,eLei.cod,eLei.monto,eLei.nombre);
    while (not Eof(comisiones)) do begin
      eAcum.cod := eLei.cod;
      eAcum.monto := 0;
      while (not Eof(comisiones))and(eLei.cod = eAcum.cod) do begin
        eAcum.monto+=eLei.monto;
        Read(comisiones,eLei.cod,eLei.monto,eLei.nombre);
      end;
      WriteLn(arc_comp,eAcum.cod,' ',eAcum.monto:0:2,' ',eAcum.nombre);
    end;
    {cerrar archivos}
    Close(arc_comp);
    Close(comisiones);
end;

{programa principal}
begin
    Compactar();
end.