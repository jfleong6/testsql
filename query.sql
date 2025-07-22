use gestion_hospital;

-- query 1
SELECT pm.Cedula_medico, pm.Nombre_medico, count(pm.Cedula_paciente) as Total_pacientes
from pacientes_por_medico pm
group by pm.Cedula_medico 
order by Total_pacientes DESC ;

-- query 2
SELECT  ve.Cedula, ve.Nombre, ve.Estado, sum(Dias) as Dias 
from vacacionesEmpleados ve
group by
	ve.Cedula,
	ve.Estado 
ORDER by Dias desc;
	
-- query 3
SELECT pm.Cedula_medico, pm.Nombre_medico, sum(pm.Cant_hora) as Total_hora
from pacientes_por_medico pm
WHERE pm.Fecha BETWEEN "2025-07-01" and "2025-07-07"
group by pm.Cedula_medico 
order by Total_hora desc;

-- query 4
SELECT pm.Cedula_medico, pm.Nombre_medico, count(pm.Cedula_medico) as Total_sustituciones
from pacientes_por_medico pm
WHERE pm.Tipo_medico = "sustituciones"
group by pm.Cedula_medico 
order by Total_sustituciones desc;

-- query 5
SELECT m.cedula, m.p_nombre, tp.tipo as estado 
from medicos m
join tipo_medico tp on m.id_tipo = tp.id
where tp.tipo = "sustituto";

-- query 6
SELECT  m.cedula, m.p_nombre, d.dia, sum(hc.cant_hora) as Hora_Total
from horas_consulta hc
join medicos m on hc.id_medico = m.cedula
join dias d on hc.id_dia = d.id
group by m.cedula, d.dia
order by Hora_Total;

-- query 7
SELECT pm.Cedula_medico, pm.Nombre_medico, count(pm.Cedula_paciente) as Total_paciente
from pacientes_por_medico pm
group by pm.Cedula_medico 
order by Total_paciente desc;

-- query 8
SELECT ve.Cedula, ve.Nombre, ve.Dias
from vacacionesEmpleados ve
where ve.Dias >10;

-- query 9


-- query 10

SELECT  m.cedula, m.p_nombre, d.dia, avg(hc.cant_hora) as Promedio
from horas_consulta hc
join medicos m on hc.id_medico = m.cedula
join dias d on hc.id_dia = d.id
group by m.cedula, d.dia
order by Promedio;

-- query 11


-- query 12

-- query 13
SELECT ve.Cedula, ve.Nombre, ve.Dias
from vacacionesEmpleados ve

-- query 14
SELECT pm.Cedula_medico, pm.Nombre_medico, sum(pm.Cedula_paciente) as Total_paciente
from pacientes_por_medico pm
group by pm.Cedula_medico 
order by Total_paciente desc;






