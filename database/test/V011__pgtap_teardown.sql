/*
==========================================================
MiGestionSENA
V011__pgtap_teardown.sql
==========================================================

Limpieza completa del entorno pgTAP.

Dependencias:
- V009__pgtap_setup.sql

Compatible con PostgreSQL 16.
==========================================================
*/

/*==========================================================
ELIMINAR ESQUEMA DE PRUEBAS
==========================================================*/

DROP SCHEMA IF EXISTS test_mgs_types CASCADE;

/*==========================================================
VERIFICACIÓN FINAL
==========================================================*/

DO
$$
BEGIN

    IF EXISTS (
        SELECT 1
        FROM pg_namespace
        WHERE nspname = 'test_mgs_types'
    )
    THEN

        RAISE EXCEPTION USING
            ERRCODE = '55006',
            MESSAGE = 'No fue posible eliminar el esquema test_mgs_types';

    END IF;

END;
$$;
