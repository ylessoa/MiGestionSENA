Tablas Dataverse
mgs_centroformacion
Campo	Tipo
mgs_centroformacionid	GUID
mgs_codigo	Texto
mgs_nombre	Texto
mgs_regional	Texto
mgs_activo	Sí/No
mgs_dependencia
Campo	Tipo
mgs_dependenciaid	GUID
mgs_nombre	Texto
mgs_centroformacion	Lookup
mgs_activo	Sí/No
mgs_usuario
Campo	Tipo
mgs_usuarioid	GUID
mgs_documento	Texto
mgs_nombrecompleto	Texto
mgs_correo	Correo
mgs_dependencia	Lookup
mgs_rol	Choice
mgs_funcionorganizacional	Choice
mgs_actividad
Campo	Tipo
mgs_actividadid	GUID
mgs_titulo	Texto
mgs_descripcion	Multilinea
mgs_fechaactividad	Fecha
mgs_estado	Choice
mgs_prioridad	Choice
mgs_responsable	Lookup Usuario
mgs_porcentajeavance	Decimal
mgs_evidencia
Campo	Tipo
mgs_evidenciaid	GUID
mgs_actividad	Lookup
mgs_nombrearchivo	Texto
mgs_urlsharepoint	URL
mgs_fechacarga	FechaHora
mgs_proyecto
Campo	Tipo
mgs_proyectoid	GUID
mgs_nombre	Texto
mgs_objetivo	Multilinea
mgs_avance	Decimal
mgs_responsable	Lookup Usuario
mgs_compromisodesempeno
Campo	Tipo
mgs_compromisoid	GUID
mgs_nombre	Texto
mgs_meta	Multilinea
mgs_avance	Decimal
mgs_obligacioncontractual
Campo	Tipo
mgs_obligacionid	GUID
mgs_nombre	Texto
mgs_fechalimite	Fecha
mgs_avance	Decimal
mgs_diariogestion
Campo	Tipo
mgs_diarioid	GUID
mgs_fecha	Fecha
mgs_resumen	Multilinea
mgs_usuario	Lookup Usuario
mgs_auditoria
Campo	Tipo
mgs_auditoriaid	GUID
mgs_tabla	Texto
mgs_accion	Choice
mgs_usuario	Lookup Usuario
mgs_fecha	FechaHora
mgs_estructurajerarquica
Campo	Tipo
mgs_relacionid	GUID
mgs_superior	Lookup Usuario
mgs_dependiente	Lookup Usuario
mgs_tiporelacion	Choice
