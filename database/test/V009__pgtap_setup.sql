/*
==========================================================
MiGestionSENA
V009__pgtap_setup.sql
==========================================================

Preparación de objetos de prueba para pgTAP.

Dependencias:

V001__schema.sql
V002__catalogos.sql
V003__modelo_mgs.sql
V004__catalogo_tarea_esencial.sql
V008__functions_validation.sql

Compatible con PostgreSQL 16
==========================================================
*/

/*==========================================================
EXTENSIÓN PGTAP
==========================================================*/

CREATE EXTENSION IF NOT EXISTS pgtap;

/*==========================================================
ESQUEMA DE PRUEBAS
==========================================================*/

CREATE SCHEMA IF NOT EXISTS test_mgs_types;

/*==========================================================
LIMPIEZA PREVIA
==========================================================*/

DROP VIEW IF EXISTS test_mgs_types.v_test CASCADE;

DROP TABLE IF EXISTS test_mgs_types.child_multirange CASCADE;
DROP TABLE IF EXISTS test_mgs_types.parent_multirange CASCADE;

DROP TABLE IF EXISTS test_mgs_types.child_range CASCADE;
DROP TABLE IF EXISTS test_mgs_types.parent_range CASCADE;

DROP TABLE IF EXISTS test_mgs_types.child_bad_fk CASCADE;
DROP TABLE IF EXISTS test_mgs_types.child_fk CASCADE;
DROP TABLE IF EXISTS test_mgs_types.parent_fk CASCADE;

DROP TABLE IF EXISTS test_mgs_types.child_bigint CASCADE;
DROP TABLE IF EXISTS test_mgs_types.child_domain CASCADE;
DROP TABLE IF EXISTS test_mgs_types.parent_domain CASCADE;

DROP TABLE IF EXISTS test_mgs_types.parent_no_unique CASCADE;

DROP TABLE IF EXISTS test_mgs_types.parent_array CASCADE;
DROP TABLE IF EXISTS test_mgs_types.child_array CASCADE;

DROP TABLE IF EXISTS test_mgs_types.t_domain_multirange CASCADE;
DROP TABLE IF EXISTS test_mgs_types.t_multirange CASCADE;
DROP TABLE IF EXISTS test_mgs_types.t_range CASCADE;

DROP TABLE IF EXISTS test_mgs_types.t_domain_enum CASCADE;
DROP TABLE IF EXISTS test_mgs_types.t_enum CASCADE;

DROP TABLE IF EXISTS test_mgs_types.t_composite CASCADE;

DROP TABLE IF EXISTS test_mgs_types.t_nested_array_domain CASCADE;
DROP TABLE IF EXISTS test_mgs_types.t_domain_array CASCADE;
DROP TABLE IF EXISTS test_mgs_types.t_text_array CASCADE;

DROP TABLE IF EXISTS test_mgs_types.t_nested_domain CASCADE;
DROP TABLE IF EXISTS test_mgs_types.t_domain CASCADE;

DROP TABLE IF EXISTS test_mgs_types.t_numeric CASCADE;
DROP TABLE IF EXISTS test_mgs_types.t_varchar CASCADE;
DROP TABLE IF EXISTS test_mgs_types.t_uuid CASCADE;
DROP TABLE IF EXISTS test_mgs_types.t_bigint CASCADE;

DROP DOMAIN IF EXISTS test_mgs_types.periodos_domain CASCADE;

DROP DOMAIN IF EXISTS test_mgs_types.estado_enum_domain CASCADE;

DROP DOMAIN IF EXISTS test_mgs_types.ids_c CASCADE;
DROP DOMAIN IF EXISTS test_mgs_types.ids_b CASCADE;
DROP DOMAIN IF EXISTS test_mgs_types.ids_a CASCADE;
DROP DOMAIN IF EXISTS test_mgs_types.ids_base CASCADE;

DROP DOMAIN IF EXISTS test_mgs_types.id_funcionario CASCADE;
DROP DOMAIN IF EXISTS test_mgs_types.id_empleado CASCADE;
DROP DOMAIN IF EXISTS test_mgs_types.id_base CASCADE;
DROP DOMAIN IF EXISTS test_mgs_types.id_sena CASCADE;
DROP DOMAIN IF EXISTS test_mgs_types.id_domain CASCADE;

DROP TYPE IF EXISTS test_mgs_types.identificador_persona CASCADE;
DROP TYPE IF EXISTS test_mgs_types.estado_enum CASCADE;

/*==========================================================
DOMINIOS
==========================================================*/

CREATE DOMAIN test_mgs_types.id_sena
AS bigint;

CREATE DOMAIN test_mgs_types.id_base
AS bigint;

CREATE DOMAIN test_mgs_types.id_empleado
AS test_mgs_types.id_base;

CREATE DOMAIN test_mgs_types.id_funcionario
AS test_mgs_types.id_empleado;

CREATE DOMAIN test_mgs_types.id_domain
AS bigint;

/*==========================================================
ARRAYS Y DOMINIOS SOBRE ARRAYS
==========================================================*/

CREATE DOMAIN test_mgs_types.ids_base
AS bigint[];

CREATE DOMAIN test_mgs_types.ids_a
AS bigint[];

CREATE DOMAIN test_mgs_types.ids_b
AS test_mgs_types.ids_a;

CREATE DOMAIN test_mgs_types.ids_c
AS test_mgs_types.ids_b;

/*==========================================================
ENUMS
==========================================================*/

CREATE TYPE test_mgs_types.estado_enum
AS ENUM (
    'ACTIVO',
    'INACTIVO'
);

CREATE DOMAIN test_mgs_types.estado_enum_domain
AS test_mgs_types.estado_enum;

/*==========================================================
TIPO COMPUESTO
==========================================================*/

CREATE TYPE test_mgs_types.identificador_persona
AS (
    documento text,
    correo text
);

/*==========================================================
MULTIRANGE
==========================================================*/

CREATE DOMAIN test_mgs_types.periodos_domain
AS datemultirange;

/*==========================================================
TABLAS TIPOS BASE
==========================================================*/

CREATE TABLE test_mgs_types.t_bigint (
    id bigint
);

CREATE TABLE test_mgs_types.t_uuid (
    id uuid
);

CREATE TABLE test_mgs_types.t_varchar (
    valor varchar(100)
);

CREATE TABLE test_mgs_types.t_numeric (
    valor numeric(18,2)
);

/*==========================================================
TABLAS DOMINIOS
==========================================================*/

CREATE TABLE test_mgs_types.t_domain (
    id test_mgs_types.id_sena
);

CREATE TABLE test_mgs_types.t_nested_domain (
    id test_mgs_types.id_funcionario
);

/*==========================================================
TABLAS ARRAYS
==========================================================*/

CREATE TABLE test_mgs_types.t_text_array (
    etiquetas text[]
);

CREATE TABLE test_mgs_types.t_domain_array (
    ids test_mgs_types.ids_base
);

CREATE TABLE test_mgs_types.t_nested_array_domain (
    ids test_mgs_types.ids_c
);

/*==========================================================
TABLAS ENUM
==========================================================*/

CREATE TABLE test_mgs_types.t_enum (
    estado test_mgs_types.estado_enum
);

CREATE TABLE test_mgs_types.t_domain_enum (
    estado test_mgs_types.estado_enum_domain
);

/*==========================================================
TABLA COMPOSITE
==========================================================*/

CREATE TABLE test_mgs_types.t_composite (
    persona test_mgs_types.identificador_persona
);

/*==========================================================
TABLAS RANGE
==========================================================*/

CREATE TABLE test_mgs_types.t_range (
    vigencia daterange
);

CREATE TABLE test_mgs_types.parent_range (
    vigencia daterange
);

CREATE TABLE test_mgs_types.child_range (
    vigencia daterange
);

/*==========================================================
TABLAS MULTIRANGE
==========================================================*/

CREATE TABLE test_mgs_types.t_multirange (
    vigencias datemultirange
);

CREATE TABLE test_mgs_types.t_domain_multirange (
    periodos test_mgs_types.periodos_domain
);

CREATE TABLE test_mgs_types.parent_multirange (
    vigencias datemultirange
);

CREATE TABLE test_mgs_types.child_multirange (
    vigencias datemultirange
);

/*==========================================================
FK CORRECTAS
==========================================================*/

CREATE TABLE test_mgs_types.parent_fk (
    id bigint PRIMARY KEY
);

CREATE TABLE test_mgs_types.child_fk (
    id bigint
);

CREATE TABLE test_mgs_types.child_bad_fk (
    id uuid
);

/*==========================================================
FK CON DOMINIOS
==========================================================*/

CREATE TABLE test_mgs_types.parent_domain (
    id test_mgs_types.id_domain PRIMARY KEY
);

CREATE TABLE test_mgs_types.child_domain (
    id test_mgs_types.id_domain
);

CREATE TABLE test_mgs_types.child_bigint (
    id bigint
);

/*==========================================================
FK PADRE NO REFERENCIABLE
==========================================================*/

CREATE TABLE test_mgs_types.parent_no_unique (
    id bigint
);

/*==========================================================
FK ARRAYS
==========================================================*/

CREATE TABLE test_mgs_types.parent_array (
    ids bigint[]
);

CREATE TABLE test_mgs_types.child_array (
    ids bigint[]
);

/*==========================================================
VISTA PARA PRUEBA NEGATIVA
==========================================================*/

CREATE VIEW test_mgs_types.v_test
AS
SELECT
    1::bigint AS id;

/*==========================================================
VERIFICACIONES BÁSICAS
==========================================================*/

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM pg_namespace
        WHERE nspname = 'test_mgs_types'
    )
    THEN
        RAISE EXCEPTION
        'No se creó test_mgs_types';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_type
        WHERE typname = 'estado_enum'
          AND typnamespace =
              'test_mgs_types'::regnamespace
    )
    THEN
        RAISE EXCEPTION
        'No se creó estado_enum';
    END IF;

END;
$$;
