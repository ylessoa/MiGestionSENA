Script de Construcción Dataverse
TABLA 1
Display Name: Centro de Formación

Schema Name: mgs_centroformacion

Primary Column: Nombre

Campos:

mgs_codigo Tipo: Texto Longitud: 20 Requerido: Sí

mgs_nombre Tipo: Texto Longitud: 250 Requerido: Sí

mgs_regional Tipo: Texto Longitud: 150

mgs_activo Tipo: Sí/No Default: Sí

Alternate Key: mgs_codigo

TABLA 2
Display Name: Dependencia

Schema Name: mgs_dependencia

Primary Column: Nombre

Campos:

mgs_nombre Texto(250)

mgs_descripcion Multilínea

mgs_activo Sí/No

Relación Lookup:

mgs_centroformacionid Lookup → mgs_centroformacion

Alternate Key:

mgs_nombre + mgs_centroformacionid

TABLA 3
Display Name: Usuario

Schema Name: mgs_usuario

Primary Column: Nombre Completo

Campos:

mgs_documento Texto(20)

mgs_nombrecompleto Texto(250)

mgs_correo Correo Electrónico

mgs_cargo Texto(200)

mgs_funcionorganizacional Choice

mgs_rol Choice

mgs_telefono Texto(30)

mgs_activo Sí/No

Lookup:

mgs_dependenciaid → mgs_dependencia

Alternate Keys:

mgs_documento

mgs_correo

TABLA 4
Display Name: Actividad

Schema Name: mgs_actividad

Primary Column: Título

Campos:

mgs_titulo Texto(250)

mgs_descripcion Multilínea

mgs_fechaactividad Fecha

mgs_horainicio FechaHora

mgs_horafin FechaHora

mgs_estado Choice

mgs_prioridad Choice

mgs_porcentajeavance Decimal

mgs_observaciones Multilínea

Lookup:

mgs_responsableid → mgs_usuario

Validaciones:

0 <= mgs_porcentajeavance <= 100

mgs_horafin >= mgs_horainicio

TABLA 5
Display Name: Evidencia

Schema Name: mgs_evidencia

Primary Column: Nombre Archivo

Campos:

mgs_nombrearchivo Texto(250)

mgs_urlsharepoint URL

mgs_fechacarga FechaHora

mgs_descripcion Multilínea

mgs_tamaniokb Número

mgs_tipodocumento Choice

Lookup:

mgs_actividadid → mgs_actividad
