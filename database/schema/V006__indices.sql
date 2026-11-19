/*
==========================================================
MiGestionSENA
V006__indices.sql
==========================================================
*/

SET search_path TO mgs;

CREATE INDEX IF NOT EXISTS idx_usuario_documento
ON usuario(documento);

CREATE INDEX IF NOT EXISTS idx_usuario_correo
ON usuario(correo_institucional);

CREATE INDEX IF NOT EXISTS idx_usuario_dependencia
ON usuario(dependencia_id);

CREATE INDEX IF NOT EXISTS idx_dependencia_centro
ON dependencia(centro_formacion_id);

CREATE INDEX IF NOT EXISTS idx_actividad_responsable
ON actividad(responsable_id);

CREATE INDEX IF NOT EXISTS idx_actividad_fecha
ON actividad(fecha_actividad);

CREATE INDEX IF NOT EXISTS idx_actividad_estado
ON actividad(estado_actividad_id);

CREATE INDEX IF NOT EXISTS idx_actividad_prioridad
ON actividad(prioridad_id);

CREATE INDEX IF NOT EXISTS idx_catalogo_tarea_area
ON catalogo_tarea_esencial(area_funcional);

CREATE INDEX IF NOT EXISTS idx_catalogo_tarea_categoria
ON catalogo_tarea_esencial(categoria_tarea);

CREATE UNIQUE INDEX IF NOT EXISTS idx_catalogo_tarea_codigo
ON catalogo_tarea_esencial(codigo_tarea);

CREATE INDEX IF NOT EXISTS idx_usuario_tarea_usuario
ON usuario_tarea_esencial(usuario_id);

CREATE INDEX IF NOT EXISTS idx_usuario_tarea_catalogo
ON usuario_tarea_esencial(tarea_esencial_id);
