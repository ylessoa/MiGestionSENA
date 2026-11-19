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
==========================================================
*/

/*==========================================================
VALIDACIÓN DE DEPENDENCIAS
==========================================================*/

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'mgs'
          AND table_name = 'actividad'
    )
    THEN
        RAISE EXCEPTION USING
            ERRCODE = '42P01',
            MESSAGE = 'Dependencia faltante: mgs.actividad';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'mgs'
          AND table_name = 'usuario'
    )
    THEN
        RAISE EXCEPTION USING
            ERRCODE = '42P01',
            MESSAGE = 'Dependencia faltante: mgs.usuario';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'mgs'
          AND table_name = 'catalogo_tarea_esencial'
    )
    THEN
        RAISE EXCEPTION USING
            ERRCODE = '42P01',
            MESSAGE = 'Dependencia faltante: mgs.catalogo_tarea_esencial';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'mgs'
          AND table_name = 'usuario_tarea_esencial'
    )
    THEN
        RAISE EXCEPTION USING
            ERRCODE = '42P01',
            MESSAGE = 'Dependencia faltante: mgs.usuario_tarea_esencial';
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
    )
    THEN
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
    )
    THEN
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
    )
    THEN
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
    )
    THEN
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
    u.nombre_completo
