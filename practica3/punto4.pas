Program punto4;

type
    reg_flor = record
        nombre: String[45];
        codigo:integer;
    end;
    tArchFlores = file of reg_flor;

{miro el numero cabecera.
    Si cod=0 no tengo espacio entonces agrego al final una flor
    Si cod<>0 tengo espacios, que puedo reutilizar}
procedure agregarFlor (var a: tArchFlores ; nombre: string; codigo:integer);
var
    reg,cab:reg_flor;
begin
    Reset(a);
    Read(a,cab);
    if(cab=0)then begin
      Seek(a,FileSize(a));
      reg.nombre:=nombre;
      reg.codigo:=codigo;
      Write(a,reg);
    end
    else begin
      Seek(a,Abs(cab.codigo)); {voy a la posicion guardada en cabecera}
      Read(a,cab); {me guardo el codigo guardado en pos libre (0 si no hay mas espacios)}
      Seek(a,FilePos(a)-1); {apunto para atras donde tengo libre}
      Write(a,reg); {guardo la flor nueva}
      Seek(a,0); {vuelvo al inicio}
      Write(a,cab); {guardo cabecera nueva}
    end;
end;

{liste el contenido del archivo omitiendo las flores eliminadas.}
procedure listar (var a:tArchFlores; var txt:Text);
var
    reg:reg_flor;
begin
    Assing(txt,'archivo.txt');
    Rewrite(txt);
    while (not Eof(a)) do begin
        read(a,reg);
        if(reg.codigo>0)then
          WriteLn(txt,'Nombre: ',reg.nombre,', Codigo: ',reg.codigo);
    end;
end;

{programa principal}
var
    a:tArchFlores;
    nom:string;
    cod:integer;
    txt:Text;
begin
    {...codigo...}
    agregarFlor(a,nom,cod);
    listar(a,txt);
end.