program punto8;
type
    distribucionR = record
        nombre:string[15];
        anio:integer;
        numKernel:integer;
        cantDes:integer;
        descr:string[50];
    end;
    maestro = file of distribucionR;

{El nombre de las distribuciones no puede repetirse}
{Este archivo debe ser mantenido realizando bajas lógicas y utilizando lista invertida}

{módulo que recibe por parámetro un nombre y devuelve verdadero si la distribución 
existe en el archivo o falso en caso contrario.}
function ExisteDistribucion(m:maestro;nom:string[15]):boolean; {FUNCION --> Solo par por valor, puedo pasar el maestro así???}
var
    dato:distribucionR;
    esta:Boolean;
begin
    Reset(m);
    esta:=false;
    while (not Eof(m)) and (not esta) do begin
      read (m,dato);
      if (dato.nombre = nom) then 
        esta:=true;
    end;
    Close(m);
    return := esta;
end;

{otros procesos necesarios}
procedure leer(var dato:distribucionR);
begin
    WriteLn('Ingrese nombre, año lanzamiento, num del kernel, cantidad desarrolladores y descripción.');
    Read(dato.nombre);
    Read(dato.anio);
    Read(dato.numKernel);
    Read(dato.cantDes);
    Read(dato.descr);
end;

procedure agregar(var m:maestro; var dato:distribucionR);
var
    cab:distribucionR;
begin
    Reset(m);
    Read(m,cab);
    if(cab.cantDes=0)then begin
      Seek(m,FileSize(m));
      Write(m,dato);
    end
    else begin  {s r s w s w}
      Seek(m,Abs(cab.cantDes));
      read(m,cab);
      Seek(m,FilePos(m)-1);
      Write(m,dato);
      Seek(m,0);
      Write(m,cab);
    end;
    Close(m);
end;

{módulo que lee por teclado los datos de una nueva distribución y la agrega al archivo 
reutilizando espacio disponible en caso de que exista. (El control de unicidad lo debe 
realizar con ExisteDistribucion). Si la distribución a que se quiere agregar ya existe 
informar “ya existe la distribución”}
procedure AltaDistribucion(var m:maestro);
var
    nuevo:distribucionR;
begin
    Reset(a);
    leer(nuevo);
    if(not ExisteDistribucion(m,dato.nombre))then
      agregar(m,dato)
    else 
      WriteLn('Ya existe la distribución.');
    Close(a);
end;

{módulo que da de baja lógicamente una distribución cuyo nombre se lee por teclado. Para 
marcar una distribución como borrada utilizar campo cantidad de desarrolladores para 
mantener actualizada la lista invertida. Para verificar que la distribución a borrar
exista utilizar módulo ExisteDistribucion. Si no existe informar “Distribución no existente”.}
procedure BajaDistribucion(var m:maestro);
var
    nom:string[15];
    cab,aux:distribucionR;
begin
    WriteLn('Ingrese nombre de la distribucion a eliminar.');
    Read(nom);
    Reset(m);
    Read(m,cab);
    if (ExisteDistribucion(m,nom)) then begin {si existe la distribucion a eliminar}
      read(m,aux);  {leo primer registro (despues de cabecera)}
      while (nom<>aux.nombre) do {mientras no encuentre el que quiero eliminar}
        read(m,aux);    {leo otro registro --> hasta encontrar el que quiero eliminar}
      aux.cantDes:=cab.cantDes; {guardo en aux la dir del proximo esp libre}
      Seek(a,FilePos(a)-1); {vuelvo el puntero para atras}
      cab.cantDes:=FilePos(a)*-1;   {guardo en cabecera la pos del registro a eliminar (neg)}
      Write(a,aux); {guardo aux en el registro en la posicion del registro a eliminar}
      Seek(a,0);    {vuelvo a la cabecera}
      Write(a,cab); {guardo la nueva cabecera}
    end
    else 
        WriteLn('Distribución no existente.');
    Close(m);
end;

{programa principal}
var
    m:maestro;
begin
    Assign(m,'maestro');
    {supongo que el archivo ya tiene previamente registros de distribuciones cargados}
    AltaDistribucion(m);
    BajaDistribucion(m);
end.