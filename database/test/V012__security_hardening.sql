/*
==========================================================
MiGestionSENA
V012__security_hardening.sql
==========================================================

Security Hardening

Objetivos:

- Revocar permisos PUBLIC.
- Crear roles especializados.
- Aplicar principio de mínimo privilegio.
- Restringir funciones administrativas.
- Separar accesos de aplicación,
  automatización, BI y auditoría.

Compatible con PostgreSQL 16.
==========================================================
*/

BEGIN;

/*==========================================================
ROLES ESPECIALIZADOS
==========================================================*/

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'mgs_app_read'
    )
    THEN
        CREATE ROLE mgs_app_read;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'mgs_app_write'
    )
    THEN
        CREATE ROLE mgs_app_write;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'mgs_bi'
    )
    THEN
        CREATE ROLE mgs_bi;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'mgs_automation'
    )
    THEN
        CREATE ROLE mgs_automation;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'mgs_auditor'
    )
    THEN
        CREATE ROLE mgs_auditor;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'mgs_data_quality'
    )
    THEN
        CREATE ROLE mgs_data_quality;
    END IF;

END;
$$;

/*==========================================================
REVOCAR ACCESOS PUBLIC
==========================================================*/

REVOKE ALL
ON SCHEMA mgs
FROM PUBLIC;

REVOKE ALL
ON ALL TABLES IN SCHEMA mgs
FROM PUBLIC;

REVOKE ALL
ON ALL SEQUENCES IN SCHEMA mgs
FROM PUBLIC;

REVOKE ALL
ON ALL FUNCTIONS IN SCHEMA mgs
FROM PUBLIC;

/*==========================================================
USAGE DEL ESQUEMA
==========================================================*/

GRANT USAGE
ON SCHEMA mgs
TO
    mgs_admin,
    mgs_app_read,
    mgs_app_write,
    mgs_bi,
    mgs_automation,
    mgs_auditor,
    mgs_readonly;

/*==========================================================
LECTURA
==========================================================*/

GRANT SELECT
ON ALL TABLES IN SCHEMA mgs
TO
    mgs_app_read,
    mgs_bi,
    mgs_auditor,
    mgs_readonly;

/*==========================================================
ESCRITURA APLICACIÓN
==========================================================*/

GRANT
    SELECT,
    INSERT,
    UPDATE
ON ALL TABLES IN SCHEMA mgs
TO
    mgs_app_write,
    mgs_automation;

/*==========================================================
SECUENCIAS
==========================================================*/

GRANT
    USAGE,
    SELECT
ON ALL SEQUENCES IN SCHEMA mgs
TO
    mgs_app_write,
    mgs_automation,
    mgs_admin;

/*==========================================================
PROTEGER FUNCIONES DE VALIDACIÓN
==========================================================*/

/*
V008
*/

REVOKE ALL
ON FUNCTION mgs.fn_resolve_regtype_safe(text)
FROM PUBLIC;

REVOKE ALL
ON FUNCTION mgs.fn_resolve_type_hierarchy(regtype)
FROM PUBLIC;

/*
Ajustar las firmas exactamente
si V008 difiere.
*/

GRANT EXECUTE
ON FUNCTION mgs.fn_resolve_regtype_safe(text)
TO
    mgs_admin,
    mgs_app_write;

GRANT EXECUTE
ON FUNCTION mgs.fn_resolve_type_hierarchy(regtype)
TO
    mgs_admin,
    mgs_app_write;

/*==========================================================
VISTAS
==========================================================*/

GRANT SELECT
ON ALL TABLES IN SCHEMA mgs
TO
    mgs_bi;

GRANT SELECT
ON ALL TABLES IN SCHEMA mgs
TO
    mgs_auditor;

/*==========================================================
PERMISOS FUTUROS
==========================================================*/

ALTER DEFAULT PRIVILEGES
IN SCHEMA mgs
REVOKE ALL ON TABLES
FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
IN SCHEMA mgs
REVOKE ALL ON SEQUENCES
FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
IN SCHEMA mgs
REVOKE ALL ON FUNCTIONS
FROM PUBLIC;

/*==========================================================
DEFAULT PRIVILEGES APP READ
==========================================================*/

ALTER DEFAULT PRIVILEGES
IN SCHEMA mgs
GRANT SELECT ON TABLES
TO
    mgs_app_read,
    mgs_bi,
    mgs_readonly;

/*==========================================================
DEFAULT PRIVILEGES APP WRITE
==========================================================*/

ALTER DEFAULT PRIVILEGES
IN SCHEMA mgs
GRANT
    SELECT,
    INSERT,
    UPDATE
ON TABLES
TO
    mgs_app_write,
    mgs_automation;

/*==========================================================
VERIFICACIONES
==========================================================*/

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'mgs_app_read'
    )
    THEN
        RAISE EXCEPTION
            'No fue posible crear mgs_app_read';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'mgs_bi'
    )
    THEN
        RAISE EXCEPTION
            'No fue posible crear mgs_bi';
    END IF;

END;
$$;

COMMIT;
