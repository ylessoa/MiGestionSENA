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
            MESSAGE = 'Dependencia faltante: mgs.cat_estado
