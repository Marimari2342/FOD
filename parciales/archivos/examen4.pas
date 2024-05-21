Program examen4;
const
    valorAlto = 9999;
type
    log = record
        numUs:integer;
        nomUs:string[20];
        nombre:string[10];
        apellido:string[10];
        cant:integer;
    end;
    arc = record
        numUs:integer;
        cuentaDes:string[20];
        cuerpoMsj:string[50];
    end;
    maestro = file of log;
    detalle = file of arc;

{PRECONDICIONES
Un usuario puede enviar cero, uno o mas mails por dia.
Los usuarios que aparecen en el archivo de envíos diarios seguro existen el logmail.dat
Un unico archivo detalle.}

procedure leer (var d:detalle; var a:arc);
begin
  if(not Eof(d)) then
    read(d,a)
  else 
    d.numUs:=valorAlto;
end;

{realice el procedimiento necesario para actualizar la información del log}
procedure punto_a (var m:maestro; var d:detalle);
var
    regM:log;
    regD:ar;
begin
    Reset(m);
    Reset(d);
    leer(d,regD);
    while (d.numUs<>valorAlto)do begin
      Read(m,regM);
      while (regM.numUs<>regD.numUs) do
        Read(m,regM);
      while (regM.numUs=regD.numUs) do begin
        regM.cant+=1;
        leer(d,regD);
      end;
    end;
    Close(d);
    Close(m);
end;

{realice un procedimiento que genere un archivo de texto}

procedure menu (var m:maestro; var d:detalle);
var
    opMenu:integer;
begin
    opMenu:=1;
    while(opMenu>0 and opMenu<=2)do begin
      WriteLn('Ingrese la opción que desea:');
      WriteLn('1 --> Actualizar.');
      WriteLn('2 --> ');
      WriteLn('Cualquier otra opción para cerrar.');
      read(opMenu);
      case opMenu of
        1:punto_a(m,d);
        2:punto_b(m,d);
      end;
    end;
end;

{programa principal}
var
    m:maestro;
    d:detalle;
begin
    Assign(m,'/var/log/logsmall.dat');
    Assign(d,'6junio2017.dat');
    menu(m,d);
end.