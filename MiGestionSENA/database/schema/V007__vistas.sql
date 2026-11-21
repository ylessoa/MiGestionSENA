/*
==========================================================
MiGestionSENA
V007__vistas.sql
==========================================================

Dependencias:
V001__schema.sql
V002__catalogos.sql
V003__modelo_mgs.sql
V004__catalogo_tarea_esencial.sql
V005__roles_permisos.sql
V006__indices.sql

Objetivo:
- Crear vistas operativas para Power BI, Power Apps y consultas.
- Validar dependencias antes del despliegue.
- Otorgar permisos explícitos.
- Verificar creación correcta de las vistas.

Compatible con PostgreSQL 16.
==========================================================
*/

/*==========================================================
VALIDACIÓN DE TABLAS REQUERIDAS
==========================================================*/

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'mgs'
          AND table_name = 'actividad'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE = '42P01',
            MESSAGE = 'Dependencia faltante: mgs.actividad';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'mgs'
          AND table_name = 'usuario'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE = '42P01',
            MESSAGE = 'Dependencia faltante: mgs.usuario';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'mgs'
          AND table_name = 'catalogo_tarea_esencial'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE = '42P01',
            MESSAGE = 'Dependencia faltante: mgs.catalogo_tarea_esencial';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'mgs'
          AND table_name = 'usuario_tarea_esencial'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE = '42P01',
            MESSAGE = 'Dependencia faltante: mgs.usuario_tarea_esencial';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'mgs'
          AND table_name = 'cat_estado_actividad'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE = '42P01',
            MESSAGE = 'Dependencia faltante: mgs.cat_estado_actividad';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'mgs'
          AND table_name = 'cat_prioridad'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE = '42P01',
            MESSAGE = 'Dependencia faltante: mgs.cat_prioridad';
    END IF;

END;
$$;

/*==========================================================
VALIDACIÓN DE COLUMNAS CRÍTICAS
==========================================================*/

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema='mgs'
          AND table_name='actividad'
          AND column_name='responsable_id'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE='42703',
            MESSAGE='Dependencia faltante: actividad.responsable_id';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema='mgs'
          AND table_name='actividad'
          AND column_name='estado_actividad_id'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE='42703',
            MESSAGE='Dependencia faltante: actividad.estado_actividad_id';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema='mgs'
          AND table_name='actividad'
          AND column_name='prioridad_id'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE='42703',
            MESSAGE='Dependencia faltante: actividad.prioridad_id';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema='mgs'
          AND table_name='actividad'
          AND column_name='tarea_esencial_id'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE='42703',
            MESSAGE='Dependencia faltante: actividad.tarea_esencial_id';
    END IF;

END;
$$;

/*==========================================================
VW ACTIVIDADES PENDIENTES
==========================================================*/

CREATE OR REPLACE VIEW mgs.vw_actividades_pendientes
AS
SELECT

    a.id,
    a.codigo_actividad,
    a.titulo,
    a.fecha_actividad,
    a.avance,

    u.id AS usuario_id,
    u.nombre_completo,

    e.codigo AS estado_codigo,
    e.nombre AS estado_nombre,

    p.nombre AS prioridad_nombre

FROM mgs.actividad a

INNER JOIN mgs.usuario u
    ON u.id = a.responsable_id

INNER JOIN mgs.cat_estado_actividad e
    ON e.id = a.estado_actividad_id

INNER JOIN mgs.cat_prioridad p
    ON p.id = a.prioridad_id

WHERE
    a.activo = TRUE
    AND u.activo = TRUE
    AND e.codigo <> 'FIN';

/*==========================================================
VW RESUMEN USUARIO
==========================================================*/

CREATE OR REPLACE VIEW mgs.vw_resumen_usuario
AS
SELECT

    u.id,
    u.documento,
    u.nombre_completo,

    COUNT(a.id)::BIGINT AS total_actividades,

    COALESCE(
        ROUND(
            AVG(a.avance)::NUMERIC,
            2
        ),
        0
    )::NUMERIC(5,2) AS avance_promedio

FROM mgs.usuario u

LEFT JOIN mgs.actividad a
    ON a.responsable_id = u.id
   AND a.activo = TRUE

WHERE
    u.activo = TRUE

GROUP BY
    u.id,
    u.documento,
    u.nombre_completo;

/*==========================================================
VW TAREAS ESENCIALES USUARIO
==========================================================*/

CREATE OR REPLACE VIEW mgs.vw_tareas_esenciales_usuario
AS
SELECT

    u.id AS usuario_id,
    u.documento,
    u.nombre_completo,

    te.id AS tarea_esencial_id,
    te.codigo_tarea,
    te.titulo_tarea,
    te.area_funcional,
    te.categoria_tarea,

    ute.responsable_principal,
    ute.fecha_asignacion

FROM mgs.usuario_tarea_esencial ute

INNER JOIN mgs.usuario u
    ON u.id = ute.usuario_id

INNER JOIN mgs.catalogo_tarea_esencial te
    ON te.id = ute.tarea_esencial_id

WHERE
    ute.activo = TRUE
    AND u.activo = TRUE
    AND te.activa = TRUE;

/*==========================================================
VW ACTIVIDAD TAREA ESENCIAL
==========================================================*/

CREATE OR REPLACE VIEW mgs.vw_actividad_tarea_esencial
AS
SELECT

    a.id,
    a.codigo_actividad,
    a.titulo,
    a.fecha_actividad,
    a.avance,

    a.tarea_esencial_id,

    u.id AS usuario_id,
    u.nombre_completo,

    te.codigo_tarea,
    te.titulo_tarea,
    te.area_funcional,
    te.categoria_tarea

FROM mgs.actividad a

INNER JOIN mgs.usuario u
    ON u.id = a.responsable_id

LEFT JOIN mgs.catalogo_tarea_esencial te
    ON te.id = a.tarea_esencial_id

WHERE
    a.activo = TRUE
    AND u.activo = TRUE;

/*==========================================================
PERMISOS SOBRE VISTAS
==========================================================*/

GRANT SELECT
ON mgs.vw_actividades_pendientes
TO
    mgs_readonly,
    mgs_coordinador,
    mgs_supervisor,
    mgs_ordenador_gasto,
    mgs_app;

GRANT SELECT
ON mgs.vw_resumen_usuario
TO
    mgs_readonly,
    mgs_coordinador,
    mgs_supervisor,
    mgs_ordenador_gasto,
    mgs_app;

GRANT SELECT
ON mgs.vw_tareas_esenciales_usuario
TO
    mgs_readonly,
    mgs_coordinador,
    mgs_supervisor,
    mgs_ordenador_gasto,
    mgs_app;

GRANT SELECT
ON mgs.vw_actividad_tarea_esencial
TO
    mgs_readonly,
    mgs_coordinador,
    mgs_supervisor,
    mgs_ordenador_gasto,
    mgs_app;

/*==========================================================
VALIDACIÓN POST DESPLIEGUE
==========================================================*/

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM pg_views
        WHERE schemaname='mgs'
          AND viewname='vw_actividades_pendientes'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE='42P01',
            MESSAGE='No se creó vw_actividades_pendientes';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_views
        WHERE schemaname='mgs'
          AND viewname='vw_resumen_usuario'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE='42P01',
            MESSAGE='No se creó vw_resumen_usuario';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_views
        WHERE schemaname='mgs'
          AND viewname='vw_tareas_esenciales_usuario'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE='42P01',
            MESSAGE='No se creó vw_tareas_esenciales_usuario';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_views
        WHERE schemaname='mgs'
          AND viewname='vw_actividad_tarea_esencial'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE='42P01',
            MESSAGE='No se creó vw_actividad_tarea_esencial';
    END IF;

END;
$$;
