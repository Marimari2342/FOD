Program punto2;
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
        {nombreMat:string[20];-->será necesario???}
        cursadaOfinal:char;{c = cursada aprobada // f = final aprobado}
    end;
    alumnos = file of alumnosR;
    materias = file of materiaR;

    {En proceso....}

{programa principal}
var
begin
  
end.