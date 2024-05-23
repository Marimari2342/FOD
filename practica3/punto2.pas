Program punto2;
type
    asistenteR = record
        nroAsis:integer;
        apeNomb:string[20];
        email:string[15];
        tel:integer;
        dni:integer;
    end;
    archivo = file of asistenteR;

procedure cargar (var a:asistenteR);
begin
  WriteLn('Ingrese nroAsist, apellido y nombre, email, tel y dni, o 0 para salir');
  Read(a.nroAsis);
  if(a.nroAsis<>0)then begin
    Read(a.apeNomb);
    Read(a.email);
    Read(a.tel);
    Read(a.dni);
  end;
end;

{generar un archivo con registros de longitud fija conteniendo información de asistentes
a un congreso a partir de la información obtenida por teclado.}
procedure generar(var a:archivo);
var
    asistR = asistenteR;
begin
    Assign(a,'archivo_asistentes');
    Rewrite(a);
    cargar(asistR);
    while (asistR.nroAsis<>0) do begin
        Write(a,asistR);
        cargar(asistR);
    end;
    Close(a);
end;

{elimine de forma lógica todos los asistentes con nro de asistente inferior a 1000}
procedure eliminar_logico(var a:archivo);
var
    
begin
  
end;

{programa principal}
var
    a:archivo;
begin
    generar(a);
    eliminar_logico(a);
end.