Program punto3;
type
    novelaR = record
        cod:integer;
        genero:String[10];
        nombre:String[20];
        duracion:integer;
        director:string[20];
        precio:real;
    end;
    arc_novelas = file of novelaR;

procedure leer_novela(var nov:novelaR);
begin
  WriteLn('Ingrese codigo, genero, nombre, duracion, director y precio, o -1 para terminar.');
  Read(nov.cod);
  if(nov.cod<>-1)then begin
    Read(nov.genero);
    Read(nov.nombre);
    Read(nov.duracion);
    Read(nov.director);
    Read(nov.precio);
  end;
end;

{punto a) --> Crear el archivo y cargarlo a partir de datos ingresados por teclado. 
(LISTA INVERTIDA: durante la creación del archivo, en el primer registro se debe 
almacenar la cabecera de la lista. Es decir un registro ficticio, inicializando con el 
valor cero (0) el campo correspondiente al código de novela, el cual indica que no hay 
espacio libre dentro del archivo}
procedure carga(var a:arc_novelas);
var
    nov:novelaR;
begin
    Assign(a,'archivo');
    Rewrite(a);
    nov.cod:=0;
    Write(a,nov); {cabecera de la lista}
    leer_novela(nov);
    while (nov.cod<>-1) do begin
      Write(a,nov);
      leer_novela(nov);
    end;
    Close(a);
end;

{punto b) i --> dar de alta una novela (de ser posible)}

{punto b) ii --> modificar novela desde teclado (cod NO)}

{punto c) iii --> dar de baja novela}

{programa principal}
var
    a:arc_novelas;
begin
    carga(a);
end.