{actualizar un archivo maestro a partir de dos detalle
ordenados por nombre de provincia
0, 1 o más registros por provincia en los archivos detalle --> valorAlto}
  Program punto4;
const
    valorAlto = 'ZZZZ';
type
    provinciaR = record
        nombre:string;
        cantALf:integer;
        cantEnc:integer;
    end;
    agenciaR = record
        nombreProv:string;
        codLoc:integer;
        cantAlf:integer;
        cantEnc:integer;
    end;
    provincia = file of provinciaR;
    agencia = file of agenciaR;

procedure Leer(var detalle:agencia;var a: agenciaR);
begin
    if(not Eof(detalle))then
      Read(detalle,a)
    else
      a.nombreProv:=valorAlto;
end;

procedure Minimo(var a1,a2,min:agenciaR; var detalle1,detalle2:agencia);
begin
    if(a1.nombreProv <= a2.nombreProv)then begin
      min := a1;
      Leer(detalle1,a1);
    end
    else begin
      min := a2;
      Leer(detalle2,a2);
    end;
end;

{actualizar archivo maestro desde los dos archivos detalle}
procedure ActualizarMaestro(var maestro:provincia;var detalle1,detalle2: agencia);
var
    min,a1,a2=agenciaR;
    p=provinciaR;
begin
    {asignar}
    Assign(maestro,'archivomaestro');
    Assign(detalle1,'archivodet1');
    Assign(detalle2,'archivodet2');
    {abrir archivos}
    Reset(maestro);
    Reset(detalle1);
    Reset(detalle2);
    {leer de cada archivo detalle para luego buscar el minimo entre ambos}
    Leer(detalle1,a1);
    Leer(detalle2,a2);
    Minimo(a1,a2,min,detalle1,detalle2);
    while (min.nombre <> valorAlto) do begin
        Read(maestro,p);
        while (p.nombre <> min.nombre) do {esto es porque el registro puede estar 0 veces}
          Read(maestro,p);
        while (p.nombre = min.nombre) do begin {esto es porque puede estar más de una vez}
          p.cantALf += min.cantALf;
          p.cantEnc += min.cantEnc;
          Minimo(a1,a2,min);
        end;
        Seek(maestro,FilePos(maestro)-1);
        Write(maestro,p);
    end;
    {cerrar archivos}
    Close(maestro);
    Close(detalle1);
    Close(detalle2);
end;

{programa principal}
var
    maestro:provincia;
    detalle1,detalle2:agencia;
begin
    ActualizarMaestro(maestro,detalle1,detalle2);
end.