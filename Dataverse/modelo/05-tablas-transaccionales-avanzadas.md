Tablas Transaccionales Avanzadas
mgs_proyecto
Primary Column: mgs_nombre

Campos:

mgs_nombre Texto(250)

mgs_objetivo Multilinea

mgs_fechainicio Fecha

mgs_fechafin Fecha

mgs_avance Decimal(5,2)

mgs_responsableid Lookup -> mgs_usuario

mgs_activo Si/No

mgs_compromisodesempeno
Primary Column: mgs_nombre

Campos:

mgs_nombre Texto(250)

mgs_meta Multilinea

mgs_avance Decimal

mgs_funcionarioid Lookup -> mgs_usuario

mgs_fechainicio Fecha

mgs_fechafin Fecha

mgs_obligacioncontractual
Primary Column: mgs_nombre

Campos:

mgs_nombre

mgs_descripcion

mgs_fechalimite

mgs_avance

mgs_contratistaid Lookup -> mgs_usuario

mgs_diariogestion
Primary Column: mgs_fecha

Campos:

mgs_fecha

mgs_resumen

mgs_usuarioid Lookup -> mgs_usuario

mgs_auditoria
Primary Column: mgs_tabla

Campos:

mgs_tabla

mgs_accion

mgs_usuarioid Lookup -> mgs_usuario

mgs_fecha

mgs_detalle

mgs_estructurajerarquica
Primary Column: mgs_tiporelacion

Campos:

mgs_superiorid Lookup -> mgs_usuario

mgs_dependienteid Lookup -> mgs_usuario

mgs_tiporelacion Choice
