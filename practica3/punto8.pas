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

{módulo que lee por teclado los datos de una nueva distribución y la agrega al archivo 
reutilizando espacio disponible en caso de que exista. (El control de unicidad lo debe 
realizar con ExisteDistribucion). Si la distribución a que se quiere agregar ya existe 
informar “ya existe la distribución”}
procedure AltaDistribución(var m:maestro);
var
    nuevo:distribucionR;
begin
    Reset(a);
    leer(nuevo);
    if(not ExisteDistribucion(m,dato.nombre))then
      agregar(m,dato);
    Close(a);
end;

{módulo que da de baja lógicamente una distribución cuyo nombre se lee por teclado. Para 
marcar una distribución como borrada utilizar campo cantidad de desarrolladores para 
mantener actualizada la lista invertida. Para verificar que la distribución a borrar
exista utilizar módulo ExisteDistribucion. Si no existe informar “Distribución no existente”.}
procedure BajaDistribución(var m:maestro);

{programa principal}
var

begin
  
end.