program punto7;
type
    aveR = record
        cod:integer;
        nombre:string[15];
        familia:string[15];
        descr:string[30];
        zona:string[15];
    end;
    maestro = file of aveR;

{-->elimine especies de aves, se recibe por teclado las especies a eliminar<--}
{procedimiento que marque los registros a borrar}
procedure marcar(var m:maestro);
var
    cod:integer;
    ave:aveR;
    esta:true;
begin
    Reset(m);
    WriteLn('Indique codigo de ave a eliminar, o 500000 para salir.');
    Read(cod);
    while (cod<>500000) do begin
        esta:=false;
        while ((not Eof(m))and(not esta)) do begin
            Read(m,ave);
            if (m.cod=cod) then begin
              m.nombre:='***'; {marca de ave eliminada}
              esta:=true;
            end;
        end;
        if (not esta) then
            WriteLn('El ave que se busca eliminar no esta en el archivo.');
        WriteLn('Indique codigo de ave a eliminar, o 500000 para salir.');
        Read(cod);
    end;
    Close(m);
end;

{procedimiento que compacte el archivo, quitando los registros marcados (copia el último
registro del archivo en la posición del registro a borrar y luego elimina del archivo el 
último registro para evitar registros duplicados}
procedure compactar(var m:maestro);
var
begin
end;

{programa principal}
var
    m:maestro;
begin
    Assign(m,'maestro');
    marcar(m);
    compactar(m);
end.
