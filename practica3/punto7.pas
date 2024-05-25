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
            if (ave.cod=cod) then begin
              ave.nombre:='***'; {marca de ave eliminada}
              Seek(m,FilePos(m)-1);
              Write(m,ave);
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
    ave,aveB:aveR;
    a,b:integer;
    ok:boolean;
begin
    Reset(m);
    a:=0;
    b:=FileSize(m)-1;
    ok:=false;
    while ((a<b)and(not ok)) do begin
      Seek(m,a);
      Read(m,ave);
      a+=1;
      if(ave.nombre='***')then begin{registro a eliminar}
        ok:=true;
        Seek(m,b);  {apunto al final}
        read(m,aveB); {leo el ave del final}
        b-=1; {decremento el final}
        while (aveB.cod='***') do begin {me aseguro que el registro final no este marcado para eliminar}
          Seek(m,b);
          read(m,aveB);
          b-=1;
        end;
        if (aveB.cod<>'***') and (a-1<=b) then begin
            Seek(m,a-1);    {voy a la posicion del registro a eliminar}
            write(m,aveB);  {reescribo con el registro que tengo en la posicion b}
            Seek(m,b+1);    {voy a la ultima posicion sin registros a eliminar}
            Write(m,ave);   {pongo el registro a eliminar aqui}
            ok:=false;
        end 
        else 
            a:=a-1;
      end;
    end;
    seek(m,a);
    read(m,ave);
    if (ave.codigo<>'***') then 
        a:=a+1;
    seek(m,a);
    truncate(m);
    Close(m);
end;

{programa principal}
var
    m:maestro;
begin
    Assign(m,'maestro');
    marcar(m);
    compactar(m);
end.
