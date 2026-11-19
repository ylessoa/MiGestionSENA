GRANT SELECT
ON mgs.vw_actividades_pendientes
TO
    mgs_readonly,
    mgs_coordinador,
    mgs_supervisor,
    mgs_ordenador_gasto;

GRANT SELECT
ON mgs.vw_resumen_usuario
TO
    mgs_readonly,
    mgs_coordinador,
    mgs_supervisor,
    mgs_ordenador_gasto;

GRANT SELECT
ON mgs.vw_tareas_esenciales_usuario
TO
    mgs_readonly,
    mgs_coordinador,
    mgs_supervisor,
    mgs_ordenador_gasto;

GRANT SELECT
ON mgs.vw_actividad_tarea_esencial
TO
    mgs_readonly,
    mgs_coordinador,
    mgs_supervisor,
    mgs_ordenador_gasto;
