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

{codigo}

{cargar archivo detalle 1 desde un txt}

{cargar archivo detalle 2 desde un txt}

procedure Leer(var detalle:agencia;var a: agenciaR);
var
begin
    if(not Eof(detalle))then
      Read(detalle,a)
    else
      a.nombreProv:=valorAlto;
end;

{actualizar archivo maestro desde los dos archivos detalle}
procedure ActualizarMaestro(var maestro:provincia;var detalle1,detalle2: agencia);
var
    a1,a2=agenciaR;
begin
    {abrir archivos}
    Reset(maestro);
    Reset(detalle1);
    Reset(detalle2);
    Leer(detalle1,a1);
    Leer(detalle2,a2);

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
    CargarDet1(detalle1);
    CargarDet2(detalle2);
    ActualizarMaestro(maestro,detalle1,detalle2);
end.