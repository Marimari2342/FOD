Program punto3y4;
type
    empleR = record
        nro:integer;
        edad:integer;
        dni:integer;
        apell:string[20];
        nomb:string[20];
    end;
    empleado = file of empleR;
{asignar nombre a archivo}
procedure asignar(var arc_emp:empleado);
var
    nombre:string[15];
begin
    WriteLn('Ingrese nombre de archivo: ');
    readln(nombre);
    Assign(arc_emp,nombre);
end;
{PUNTO4 --> verificar si el empleado a agregar existe o no}
function existe(arc_emp:empleado;integer: nro):boolean;
var
    aux:boolean;
    emp:empleR;
begin
    reset(arc_emp);
    aux:=false;
    while(not eof(arc_emp) and (aux=false)) do begin
      Read(arc_emp,emp);
      if(emp.nro = nro) then
        aux:=true;
    end;
    return := aux;
end;
{cargar empleados hasta ingresar el ape "fin"}
procedure carga(var arc_emp: empleado);
var
    emp:empleR;
begin
    Rewrite(arc_emp);
    writeLn('Ingrese apellido, numero, edad, dni y nombre: ');
    ReadLn(emp.apell);
    while(emp.apell<>'fin')do begin
      ReadLn(emp.nro);
      ReadLn(emp.edad);
      ReadLn(emp.dni);
      ReadLn(emp.nomb);
      if (existe(arc_emp,emp.nro)) then {PUNTO4 --> acá pregunto si el nuevo empleado existe}
        writeLn('El empleado ya se encuentra registrado.')
      else
        write(arc_emp,emp);  
      ReadLn(emp.apell);
    end;
    Close(arc_emp);
end;
{muestra un empleado en pantalla}
procedure mostrarEmpl(emp:empleR);
begin
    WriteLn('Apellido: ',emp.apell,' | Nombre: ',emp.nomb,' | Nro de empleado: ',
    emp.nro,' | Edad: ',emp.edad,' | DNI: ',emp.dni);
end;
{buscar un empleado a partir de un nombre o un apellido}
procedure buscar(var arc_emp:empleado);
var
    nom_ape:string[20];
    emp:empleR;
begin
    WriteLn('Ingrese nombre o apellido: ');
    ReadLn(nom_ape);
    Reset(arc_emp);
    while(not eof(arc_emp)) do begin
      Read(arc_emp,emp);
      if (emp.nomb=nom_ape)or(emp.apell=nom_ape) then
        mostrarEmpl(emp);
    end;
    Close(arc_emp);
end;
{muestra todos los empleados cargados}
procedure mostrarTodo(var arc_emp:empleado);
var
    emp:empleR;
begin
    Reset(arc_emp);
    while(not eof(arc_emp))do begin
        Read(arc_emp,emp);
        mostrarEmpl(emp);
    end;
    Close(arc_emp);
end;
{mostrar empleados mayores de 70 años}
procedure mayoresSetenta(var arc_emp:empleado);
var
    emp:empleR;
begin
    Reset(arc_emp);
    while (not eof(arc_emp)) do begin
        Read(arc_emp,emp);
        if(emp.edad>70)then
          mostrarEmpl(emp);
    end;
    Close(arc_emp);
end;
{PUNTO4 --> modificar la edad de un empleado dado}
procedure cambioEdad(var arc_emp:empleado);
var
    numEmp,edad:integer;
    emp:empleR;
    aux:Boolean;
begin
    aux:=false;
    WriteLn('Ingrese numero de empleado: ');
    ReadLn(numEmp);
    Reset(arc_emp);
    while(not eof(arc_emp) and aux=false) do begin
      Read(arc_emp,emp);
      if (emp.num=numEmp) then 
        aux:=true;
    end;
    if (aux) then begin
        WriteLn('Ingrese nueva edad de empleado: ');
        ReadLn(edad);
        seek(arc_emp,FilePos(arc_emp)-1);
        emp.edad:=edad;
        Write(arc_emp,emp);
    end
    else 
        WriteLn('El numero ingresado no coincide con ningún empleado registrado.');
    Close(arc_emp);
end;

{PUNTO4 --> exportar a archivo de texto}
procedure exportar(var arc_emp:empleado);
var
    txt: Text;
    emp:empleR;
begin 
    Assign(txt, 'todos_empleados.txt');
    reset(arc_emp);
    Rewrite(txt);
    while (not eof(arc_emp)) do 
        begin 
            read(arc_emp, emp);
            writeln(txt,
            ' ',emp.nro,
            ' ',emp.edad,
            ' ',emp.dni,
            ' ',emp.apell,
            ' ',emp.nomb
            );
        end;
    close(arc_emp);
    close(txt);
end;

{menu}
procedure menu(var arc_emp:empleado);
var
    opMenu:integer;
begin
    opMenu:=4;
    while(opMenu<>0)do begin
      writeln('Ingrese la opcion que desea');
      writeln('1 --> Buscar empleado por nombre o apellido.');
      writeln('2 --> Mostrar todos los empleados.');
      writeln('3 --> Mostrar los empleados mayores de 70 años.');
      writeln('4 --> Agregar un nuevo empleado al final de la lista.'); {PUNTO4}
      writeln('5 --> Cambiar la edad de un empleado'); {PUNTO4}
      writeln('6 --> Exportar archivo a un archivo de texto “todos_empleados.txt”.'); {PUNTO4}
      writeln('Cualquier otro --> Salir.');
      read(opMenu);
      case opMenu of
        1:buscar(arc_emp);
        2:mostrarTodo(arc_emp);
        3:mayoresSetenta(arc_emp);
        4:carga(arc_emp); {PUNTO4 --> cargo uno o más empleados nuevos}
        5:cambioEdad(arc_emp); {PUNTO4 --> cambio la edad de un empleado}
        6:exportar(arc_emp); {PUNTO04 --> exportar a un archivo de texto}
      end;
    end;
end;
{programa principal}
var
    arc_emp:empleado;
begin
    asignar(arc_emp);
    carga(arc_emp);
    menu(arc_emp);
end.