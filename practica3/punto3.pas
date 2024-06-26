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
procedure alta_novela(var a:arc_novelas);
var 
    nueva,nov,cab:novelaR;
begin
    Reset(a);
    leer_novela(nueva);
    read(a,nov);
    if (nov.cod=0) then begin
      Seek(a,FileSize(a));
      Write(a,nueva);
    end
    else begin
      Seek(a,abs(nov.cod)); {voy a la posicion en donde quiero guardar la nueva novela}
      Read(a,cab); {leo el registro de esa posicion y me lo guardo en cab}
      Seek(a,FilePos(a)-1); {vuelvo a apuntar donde tengo espacio}
      Write(a,nueva); {guardo la novela nueva}
      Seek(a,0); {voy a la posicion cabecera}
      Write(a,cab); {guardo la variable cabecera que tiene otra posicion libre (o el 0)}
    end;
    Close(a);
end;

{punto b) ii --> modificar novela desde teclado (cod NO)}
procedure realizar_modif(var n:novela);
var
    aux:integer;
begin
    aux:=1;
    while (aux>0 and aux<=5) do begin
      WriteLn('Ingrese la opcion que desea modificar');
      WriteLn('1 --> Modificar genero.');
      WriteLn('2 --> Modificar nombre.');
      WriteLn('3 --> Modificar duracion.');
      WriteLn('4 --> Modificar director.');
      WriteLn('5 --> Modificar precio.');
      WriteLn('Cualquier otro para salir.');
      Read(aux);
      WriteLn('Ingrese modificacion: ');
      case aux of
        1: read (n.genero);
        2: read (n.nombre);
        3: read (n.duracion);
        4: read (n.director);
        5: read (n.precio);
      end;
    end;
end;

procedure modificar(var a:arc_novelas);
var
    n:novelaR;
    cod:integer;
    esta:boolean;
begin
    Reset(a);
    WriteLn('Ingrese cod de novela a modificar: ');
    read(cod);
    esta:=false;
    while ((not Eof(a)) and (not esta)) do begin
      read(a,n);
      if(n.cod=cod)then
        esta:=true;
    end;
    if esta then begin
      realizar_modif(n);
      seek(a,FilePos(a)-1);
      write(a,n);
    end 
    else 
      WriteLn('No se encontró la novela.');
    Close(a);
end;

{punto b) iii --> dar de baja novela}
procedure baja_novela(var a:arc_novelas);
var
    cod:integer;
    cab,n:novelaR;
    esta:boolean;
begin
    Reset(a);
    WriteLn('Ingrese codigo de la novela a eliminar.');
    read(cod);
    esta:=false;
    Read(a,cab);
    Read(a,n);
    while (not Eof(a)) do begin
      if(n.cod=cod)then begin
        esta:=true;
        n.cod:=cab.cod; {guardo el codigo que tengo en cabecera en el lugar a eliminar}
        Seek(a,FilePos(a)-1);   {vuelvo el puntero para atras}
        cab.cod := FilePos(a)*-1; {pongo la posicion a eliminar en negativo y guardo en cabecera}
        Write(a,n); {guardo en la posicion el archivo con el codigo negativo (elim logica)}
        Seek(a,0); {vuelvo a cabecera}
        Write(a,cab); {guardo cabecera modificada}
      end
      else 
        Read(a,n);
    end;
    if(not esta)then
      WriteLn('La novela que se quiere eliminar no esta en el archivo.');
    Close(a);
end;

{punto c) --> listar novelas que representan la lista de espacio libre.}
procedure listar (var a:arc_novelas;var txt:Text);
var
    n:novelaR;
begin
    Assign(txt,'novelas.txt');
    Rewrite(txt);
    Reset(a);
    Seek(a,1); {salteo la cabecera}
    Read(a,n);
    while (not Eof(a)) do begin
      if(n.cod>0)then 
        WriteLn(txt,'Codigo: ',n.cod,', Nombre: ',n.nombre,', Genero: ',n.genero,' Duracion: ',n.duracion,', Director: ',n.director,' Precio: ',n.precio,'.')
      else 
        WriteLn('Espacio Libre.');
      Read(a,n);
    end;
    Close(a);
    Close(txt);
end;

{programa principal}
var
    a:arc_novelas;
    txt:Text;
begin
    carga(a);
    alta_novela(a);
    modificar(a);
    baja_novela(a);
    listar(a,txt);
end.