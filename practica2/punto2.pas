{ACTULIZACION DE UN ARCHIVO MAESTRO CON UN ARCHIVO DETALLE
- 1 archivo detalle.
- El alumno puede aparecer 0,1 o más veces --> necesito un valorAlto}
Program punto2;
const
    valorAlto = 9999;
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
        Assign(maestro,'maestro');
        Assign(detalle,'detalle');
        Reset(maestro);
        Reset(detalle);
        Leer(detalle,mat); 
        while (mat.cod<>valorAlto) do begin
          Read(maestro,alu);
          cantC:=0;
          canF:=0;
          while (mat.cod<>alu.cod) do
            Read(maestro,alu); {el alumno en detalle puede estar 0 veces}
          while (mat.cod = alu.cod) do begin
            if(mat.cursadaOfinal='c')then
              canC+=1;
            if(mat.cursadaOfinal='f')then begin
              cantF+=1;
              canC-=1;
            end;
            Leer(detalle,mat);
          end;
          alu.cantMatCursadas+=canC;
          alu.cantMatFinalApr+=canF;
	        seek (maestro,filePos (maestro)-1);
	        write (maestro,alu);
        end;
        Close(maestro);
        Close(detalle);
    end;

    procedure listarAlu(var maestro:alumnos; var txt:Text);
    var
        alu:alumnosR;
    begin
        Assign(txt,'alumnosmasfinales.txt');
        Reset(maestro);
        Rewrite(txt);
        while (not Eof(maestro)) do begin
          Read(maestro,alu);
          if(alu.cantMatFinalApr>alu.cantMatCursadas)then
            WriteLn(txt,alu.cod,alu.cantMatCursadas,alu.cantMatFinalApr,alu.apellido,alu.nombre);
        end;
        Close(maestro);
        Close(txt);
    end;

    procedure menu (var maestro:alumnos;var detalle:materias; var txt:Text);
    var
        opMenu:integer;
    begin
        opMenu:=1;
        while (opMenu>0 and opMenu<=2) do begin
          WriteLn('Ingrese la opción que desea: ');
          WriteLn('1 --> Actualizar el archivo maestro.');
          WriteLn('2 --> Listar en archivo de texto alumnos con más finales aprobados que finales sin aprobar.');
          WriteLn('Cualquier otro número para salir');
          case opMenu of
            1:actualizar(maestro,detalle);
            2:listarAlu(maestro,txt);
          end;
        end;
    end;

{programa principal}
var
    detalle:materias;
    maestro:alumnos;
    txt:Text;
begin
    menu(maestro,detalle,txt);
end.