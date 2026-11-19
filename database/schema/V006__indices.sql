/*
==========================================================
MiGestionSENA
V006__indices.sql
==========================================================
*/

SET search_path TO mgs;

/*--------------------------------------------------------
DEPENDENCIA
--------------------------------------------------------*/

CREATE INDEX IF NOT EXISTS idx_dependencia_centro
ON dependencia(centro_formacion_id);

/*--------------------------------------------------------
USUARIO
--------------------------------------------------------*/

CREATE INDEX IF NOT EXISTS idx_usuario_documento
ON usuario(documento);

CREATE INDEX IF NOT EXISTS idx_usuario_correo
ON usuario(correo_institucional);

CREATE INDEX IF NOT EXISTS idx_usuario_dependencia
ON usuario(dependencia_id);

CREATE INDEX IF NOT EXISTS idx_usuario_clase
ON usuario(clase_vinculacion_id);

CREATE INDEX IF NOT EXISTS idx_usuario_activo
ON usuario(activo);

/*--------------------------------------------------------
PROYECTO
--------------------------------------------------------*/

CREATE INDEX IF NOT EXISTS idx_proyecto_responsable
ON proyecto(responsable_id);

CREATE INDEX IF NOT EXISTS idx_proyecto_activo
ON proyecto(activo);

/*--------------------------------------------------------
ACTIVIDAD
--------------------------------------------------------*/

CREATE INDEX IF NOT EXISTS idx_actividad_responsable
ON actividad(responsable_id);

CREATE INDEX IF NOT EXISTS idx_actividad_fecha
ON actividad(fecha_actividad);

CREATE INDEX IF NOT EXISTS idx_actividad_estado
ON actividad(estado_actividad_id);

CREATE INDEX IF NOT EXISTS idx_actividad_prioridad
ON actividad(prioridad_id);

CREATE INDEX IF NOT EXISTS idx_actividad_tarea_esencial
ON actividad(tarea_esencial_id);

CREATE INDEX IF NOT EXISTS idx_actividad_activo
ON actividad(activo);

CREATE INDEX IF NOT EXISTS idx_actividad_responsable_fecha
ON actividad(
    responsable_id,
    fecha_actividad
);

/*--------------------------------------------------------
CATALOGO TAREA ESENCIAL
--------------------------------------------------------*/

CREATE INDEX IF NOT EXISTS idx_catalogo_tarea_area
ON catalogo_tarea_esencial(area_funcional);

CREATE INDEX IF NOT EXISTS idx_catalogo_tarea_categoria
ON catalogo_tarea_esencial(categoria_tarea);

CREATE INDEX IF NOT EXISTS idx_catalogo_tarea_nivel
ON catalogo_tarea_esencial(nivel);

CREATE INDEX IF NOT EXISTS idx_catalogo_tarea_grado
ON catalogo_tarea_esencial(grado);

CREATE INDEX IF NOT EXISTS idx_catalogo_tarea_activa
ON catalogo_tarea_esencial(activa);

/*
NO crear índice para codigo_tarea.
Ya existe por la restricción UNIQUE.
*/

/*--------------------------------------------------------
USUARIO TAREA ESENCIAL
--------------------------------------------------------*/

CREATE INDEX IF NOT EXISTS idx_usuario_tarea_usuario
ON usuario_tarea_esencial(usuario_id);

CREATE INDEX IF NOT EXISTS idx_usuario_tarea_catalogo
ON usuario_tarea_esencial(tarea_esencial_id);
