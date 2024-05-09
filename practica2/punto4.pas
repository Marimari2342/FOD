Program punto4;
const
    valorAlto = 99999;
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

{programa principal}
var
begin
  
end.