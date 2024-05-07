Program punto2; {ACTULIZACION DE UN ARCHIVO MAESTRO CON UN ARCHIVO DETALLE}
const
    valorAlto = 99999;
type
    alumnosR = record
        cod:integer;
        apellido:string[20];
        nombre:string[20];
        cantMatCursadas:integer;
        cantMatFinalApr:integer;
    end;
    materiaR = record
        cod:integer;
        cursadaOfinal:char;{c = cursada aprobada // f = final aprobado}
    end;
    alumnos = file of alumnosR;
    materias = file of materiaR;

    procedure asignarArcMyD(var maestro:alumnos;var detalle:materias);
    begin
      Assign(maestro,'archivomaestro.txt');
      Assign(detalle,'archivodetalle.txt');
    end;

    {En proceso....}
    procedure leer(var detalle:alumnos; var mat:materiaR);
    begin
      if (not Eof(detalle)) then 
        read(detalle,mat)        
      else
        mat.cod := valorAlto;
    end;

    procedure actualizar(var maestro:alumnos;var detalle:materias);
    var
        mat:materiaR;
    begin
        Reset(maestro);
        Reset(detalle);
        Leer(detalle,mat);
        Close(maestro);
        Close(detalle);
    end;

    procedure menu (var maestro:alumnos;var detalle:materias);
    var
        opMenu:integer;
    begin
        opMenu:=1;
        while (opMenu>0 and opMenu<=3) do begin
          WriteLn('Ingrese la opción que desea: ');
          WriteLn('1 --> Actualizar el archivo maestro.');
          case opMenu of
            1:actualizar(maestro,detalle);
          end;
        end;
    end;

{programa principal}
var
    detalle:materias;
    maestro:alumnos;
begin
    asignarArcMyD(maestro,detalle);
    menu(maestro,detalle);
end.