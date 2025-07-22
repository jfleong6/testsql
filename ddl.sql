use gestion_hospital;
create table if not exists tipo_medico(
	id integer primary key auto_increment,
	tipo varchar(50) not null
);

create table if not exists medicos(
	id integer primary key auto_increment,
	cedula bigint unique,
	p_nombre varchar(50) not null,
	s_nombre varchar(50) not null,
	p_apellido varchar(50) not null,
	s_apellido varchar(50) not null,
	especialidad varchar(100) not null,
	id_tipo integer not null references tipo_medico(id)
);
create table if not exists pacientes(
	id integer primary key auto_increment,
	cedula bigint unique,
	p_nombre varchar(50) not null,
	s_nombre varchar(50) not null,
	p_apellido varchar(50) not null,
	s_apellido varchar(50) not null
);
create table if not exists dias(
	id integer primary key auto_increment,
	dia varchar(20) not null
);
drop table horas_consulta;
create table if not exists horas_consulta(
	id integer primary key auto_increment,
	id_medico integer not null references medicos(cedula),
	id_dia integer not null references dias(id),
	hora integer not null,
	cant_hora integer not null,
	estado integer default 1 check (estado = 1 or estado = 0)
);

create table if not exists citas(
	id integer primary key auto_increment,
	id_paciente integer not null references pacientes(cedula),
	id_medicos integer not null references medicos(cedula),
	fecha date not null,
	id_hora_consulta integer not null references horas_consulta(id),
	estado integer default 0 check (estado = 0 or estado = 1 or estado =2)
);
create table if not exists tipo_empleado(
	id integer primary key auto_increment,
	tipo varchar(50) not null
);
create table if not exists empleados(
	id integer primary key auto_increment,
	cedula bigint unique,
	p_nombre varchar(50) not null,
	s_nombre varchar(50) not null,
	p_apellido varchar(50) not null,
	s_apellido varchar(50) not null,
	id_tipo integer not null references tipo_empleado(id)
);

create table if not exists estado_vacaciones(
	id integer primary key auto_increment,
	estado varchar(20) not null
);

create table if not exists vacaciones_empleados(
	id integer primary key auto_increment,
	id_empleado integer not null references empleados(cedula),
	fecha_inicio date not null,
	fecha_fin date not null,
	dias_total integer not null,
	id_estado integer not null references estado_vacaciones(id)
);

create table if not exists vacaciones_medicos(
	id integer primary key auto_increment,
	id_medico integer not null references medicos(cedula),
	fecha_inicio date not null,
	fecha_fin date not null,
	dias_total integer not null,
	id_estado integer not null references estado_vacaciones(id)
);

create view pacientes_por_medico as 
	select m.cedula as Cedula_medico, m.p_nombre as Nombre_medico, 
    m.especialidad As Especilidad
			p.cedula as Cedula_paciente, p.p_nombre as Nombre_paciente, 
			c.fecha as Fecha, 
			d.dia, hc.hora as Hora, 
			hc.cant_hora as Cant_hora, tm.tipo as Tipo_medico
	from citas c
	join medicos m on c.id_medicos = m.cedula
	join pacientes p on c.id_paciente = p.cedula
	join horas_consulta hc on c.id_hora_consulta = hc.id
	join tipo_medico tm on m.id_tipo = tm.id
	join dias d on hc.id_dia = d.id;

CREATE view vacacionesMedicos as
	select m.cedula as Cedula, m.p_nombre as Nombre, 
			vm.fecha_inicio as Fecha_Inicio, vm.fecha_fin as Fecha_fin, 
            vm.dias_total as Dias,
			ev.estado as Estado
	from vacaciones_medicos vm
	join medicos m on vm.id_medico = m.cedula
	join estado_vacaciones ev on vm.id_estado = ev.id;
		
CREATE view vacacionesEmpleados as
	select e.cedula as Cedula, e.p_nombre as Nombre, 
			ve.fecha_inicio as Fecha_Inicio, ve.fecha_fin as Fecha_fin, 
            ve.dias_total as Dias,
			ev.estado as Estado
	from vacaciones_empleados ve
	join empleados e on ve.id_empleado = e.cedula
	join estado_vacaciones ev on ve.id_estado = ev.id;
