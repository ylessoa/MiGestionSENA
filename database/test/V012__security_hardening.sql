/*
==========================================================
MiGestionSENA
V012__security_hardening.sql
==========================================================

Security Hardening

Objetivos:

- Revocar accesos PUBLIC.
- Aplicar principio de mínimo privilegio.
- Crear roles especializados.
- Segregar acceso aplicación/BI/automatización.
- Proteger funciones internas.
- Configurar privilegios por defecto.

Dependencias:

V001__schema.sql
V005__roles_permisos.sql
V008__functions_validation.sql

Compatible con PostgreSQL 16
==========================================================
*/

BEGIN;

/*==========================================================
VERIFICAR ROLES BASE
==========================================================*/

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'mgs_admin'
    )
    THEN
        RAISE EXCEPTION
            USING
                ERRCODE = '42501',
                MESSAGE =
                'Rol requerido no existe: mgs_admin';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'mgs_readonly'
    )
    THEN
        RAISE EXCEPTION
            USING
                ERRCODE = '42501',
                MESSAGE =
                'Rol requerido no existe: mgs_readonly';
    END IF;

END;
$$;

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
REVOCACIÓN GLOBAL
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
    mgs_data_quality,
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
ESCRITURA CONTROLADA
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
    mgs_admin,
    mgs_app_write,
    mgs_automation;

/*==========================================================
FUNCIONES
==========================================================*/

GRANT EXECUTE
ON ALL FUNCTIONS IN SCHEMA mgs
TO
    mgs_admin;

GRANT EXECUTE
ON ALL FUNCTIONS IN SCHEMA mgs
TO
    mgs_app_write;

GRANT EXECUTE
ON ALL FUNCTIONS IN SCHEMA mgs
TO
    mgs_automation;

/*==========================================================
RESTRICCIÓN EXPLÍCITA
==========================================================*/

REVOKE EXECUTE
ON ALL FUNCTIONS IN SCHEMA mgs
FROM
    mgs_readonly,
    mgs_bi,
    mgs_auditor,
    mgs_data_quality;

/*==========================================================
DEFAULT PRIVILEGES - TABLAS
==========================================================*/

ALTER DEFAULT PRIVILEGES
IN SCHEMA mgs
REVOKE ALL
ON TABLES
FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
IN SCHEMA mgs
GRANT SELECT
ON TABLES
TO
    mgs_app_read,
    mgs_bi,
    mgs_readonly,
    mgs_auditor;

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
DEFAULT PRIVILEGES - SECUENCIAS
==========================================================*/

ALTER DEFAULT PRIVILEGES
IN SCHEMA mgs
REVOKE ALL
ON SEQUENCES
FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
IN SCHEMA mgs
GRANT
    USAGE,
    SELECT
ON SEQUENCES
TO
    mgs_admin,
    mgs_app_write,
    mgs_automation;

/*==========================================================
DEFAULT PRIVILEGES - FUNCIONES
==========================================================*/

ALTER DEFAULT PRIVILEGES
IN SCHEMA mgs
REVOKE ALL
ON FUNCTIONS
FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
IN SCHEMA mgs
GRANT EXECUTE
ON FUNCTIONS
TO
    mgs_admin,
    mgs_app_write,
    mgs_automation;

/*==========================================================
VERIFICACIONES FINALES
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
        WHERE rolname = 'mgs_app_write'
    )
    THEN
        RAISE EXCEPTION
            'No fue posible crear mgs_app_write';
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

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'mgs_auditor'
    )
    THEN
        RAISE EXCEPTION
            'No fue posible crear mgs_auditor';
    END IF;

END;
$$;

/*==========================================================
MARCA DE HARDENING
==========================================================*/

COMMENT ON SCHEMA mgs IS
'Esquema protegido mediante V012 Security Hardening';

COMMIT;
