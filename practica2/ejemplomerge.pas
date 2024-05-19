{N=3 archivos, sin repetición}
Program ejemplomerge;
const
    valorAlto = 'zzzz';
    N = 3;
type   
    alumnoR = record
        nom:string[30];
        dni:string[10];
        direc:string[30];
        carrera:string[10];
    end;
    archivo = file of alumnoR;
    vectDet = array [1..N] of archivo;
    vectAlu = array [1..N] of alumnoR;
procedure leer(var d:archivo;var a:alumnoR);
begin
    if (not eof(d)) then
      read(d,a)
    else
      a.nom := valorAlto;
end;
procedure minimo(var d: vectDet; var a: vectAlu; var min:alumnoR);
var
    i,minIn:integer;
begin
    min.nom:=valorAlto;
    for i := 1 to N do 
        if (a[i].nom <= min.nom) then begin
          min := a[i];
          minIn := i;
        end; 
    read(d[minIn],a[minIn]);
end;
procedure hacerMerge(var d:vectDet; var m:archivo);
var
    i:integer;
    vAlu:vectAlu;
    min:alumnoR;
begin
    Assign(m,'maestro');
    Rewrite(m);
    for i := 1 to N do begin
      Assign(d[i],'detalle',i);
      Reset(d[i]);
      leer(d[i],vAlu[i]);
    end;
    minimo(d,vAlu,min);
    while (min.nom<>valorAlto)do begin
      write(m,min);
      minimo(d,vAlu,min);
    end;
    for i := N downTo 1 do
      close(d[i]);
    close(m);
end;
{programa principal}
var
    d:vectDet;
    m:archivo;
begin
    hacerMerge(d,m);
end.