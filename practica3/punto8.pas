program punto8;
type
    distribucionR = record
        nombre:string[15];
        año:integer;
        numKernel:integer;
        cantDes:integer;
        descr:string[50];
    end;
    maestro = file of distribucionR;

{El nombre de las distribuciones no puede repetirse}
{Este archivo debe ser mantenido realizando bajas lógicas y utilizando lista invertida}

{módulo que recibe por parámetro un nombre y devuelve verdadero si la distribución 
existe en el archivo o falso en caso contrario.}
function ExisteDistribucion(m:maestro;nom:nombre):boolean; {FUNCION --> Solo par por valor, puedo pasar el maestro así???}

{módulo que lee por teclado los datos de una nueva distribución y la agrega al archivo 
reutilizando espacio disponible en caso de que exista. (El control de unicidad lo debe 
realizar con ExisteDistribucion). Si la distribución a que se quiere agregar ya existe 
informar “ya existe la distribución”}
procedure AltaDistribución(var m:maestro);

{módulo que da de baja lógicamente una distribución cuyo nombre se lee por teclado. Para 
marcar una distribución como borrada utilizar campo cantidad de desarrolladores para 
mantener actualizada la lista invertida. Para verificar que la distribución a borrar
exista utilizar módulo ExisteDistribucion. Si no existe informar “Distribución no existente”.}
procedure BajaDistribución(var m:maestro);

{programa principal}
var

begin
  
end.