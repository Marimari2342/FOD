Program punto3;
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
{cargar empleados hasta ingresar el ape "fin"}
procedure carga(var arc_emp: empleado);
var
    emp:empleR;
begin
    Rewrite(arc_emp);
    WriteLn('Ingrese apellido, numero, edad, dni y nombre: ');
    ReadLn(emp.apell);
    while(emp.apell<>'fin')do begin
      ReadLn(emp.nro);
      ReadLn(emp.edad);
      ReadLn(emp.dni);
      ReadLn(emp.nomb);
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
      writeln('Cualquier otro --> Salir.');
      read(opMenu);
      case opMenu of
        1:buscar(arc_emp);
        2:mostrarTodo(arc_emp);
        3:mayoresSetenta(arc_emp);
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