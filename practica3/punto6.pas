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
    cod:integer;
    p,cab:prendaR;
begin
    Reset(m);
    Reset(d);
    read(m,cab);
    while (not Eof(d)) do begin {archivo no ordenado}
      read(d,cod);
      while (not Eof(m)) do begin
        read(m,p);
        if(p.cod_prenda=cod)then begin
          p.cod_prenda:=cab.cod_prenda; {baja logica}
          Seek(m,FilePos(m)-1);
          cab.cod_prenda:=Abs(FilePos(m))*-1;
          Write(m,p);
          Seek(m,0);
          Write(m,cab);
        end;
      end;
    end;
    Close(d);
    Close(m);
end;

{copiar las prendas que no están marcadas como borradas --> compactación del archivo 
renombrar el archivo nuevo con el nombre del archivo maestro original}
procedure compactar (var m,mN:maestro);
var
    p:prendaR;
begin
    Reset(m);
    Rewrite(mN);
    Seek(m,1); {salteo cabecera}
    while (not Eof(m)) do begin
        Read(m,p);
        if(p.cod_prenda>0)then
          Write(mN,p);
    end;
    Close(mN);
    Close(m);
    Erase(m);
    Rename(mN,'maestro');
end;

{programa principal}
var
    m,mN:maestro;
    d:detalle;
begin
    Assign(m,'maestro');
    Assign(d,'detalle');
    Assign(mN,'maestro_auxiliar');
    baja_prenda(m,d);
    compactar(m,mN);
end.