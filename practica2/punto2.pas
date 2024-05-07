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
        alu:alumnosR;
        canC,canF:integer;
    begin
        Reset(maestro);
        Reset(detalle);
        Leer(detalle,mat); 
        while (mat.cod<>valorAlto) do begin
          Read(maestro,alu);
          cantC:=0;
          canF:=0;
          while (mat.cod = alu.cod) do begin
            if(mat.cursadaOfinal='c')then
              canC+=1;
            if(mat.cursadaOfinal='f')then begin
              cantF+=1;
              canC-=1;
            end;
          end;
          alu.cantMatCursadas+=canC;
          alu.cantMatFinalApr+=canF;
	      seek (maestro,filePos (maestro)-1);
	      write (maestro,alu);
          Leer(detalle,mat); 
        end;
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