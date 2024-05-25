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



{programa principal}
var

begin
  
end.