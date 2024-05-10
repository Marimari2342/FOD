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

procedure Leer(var detalle:agencia;var a: agenciaR);
begin
    if(not Eof(detalle))then
      Read(detalle,a)
    else
      a.nombreProv:=valorAlto;
end;

{actualizar archivo maestro desde los dos archivos detalle}
procedure ActualizarMaestro(var maestro:provincia;var detalle1,detalle2: agencia);
var
    min,a1,a2=agenciaR;
    p=provinciaR;
begin
    {abrir archivos}
    Reset(maestro);
    Reset(detalle1);
    Reset(detalle2);

    Leer(detalle1,a1);
    Leer(detalle2,a2);
    Minimo(a1,a2,min);
    while (min.nombre <> valorAlto) do begin
        Read(maestro,p);
        while (p.nombre <> min.nombre) do 
          Read(maestro,p);
        while (p.nombre = min.nombre) do begin
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
    Assign(maestro,'archivomaestro');
    Assign(detalle1,'archivodet1');
    Assign(detalle2,'archivodet2');
    {CargarDet1(detalle1);
    CargarDet2(detalle2);  --> tendré que cargar los archivos detalle desde un txt ??}
    ActualizarMaestro(maestro,detalle1,detalle2);
end.