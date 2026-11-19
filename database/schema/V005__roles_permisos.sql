/*
==========================================================
MiGestionSENA
V005__roles_permisos.sql
==========================================================
*/

SET search_path TO mgs;

/*--------------------------------------------------------
ROLES
--------------------------------------------------------*/

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname='mgs_admin'
    ) THEN

        CREATE ROLE mgs_admin NOINHERIT;

    END IF;

END;
$$;

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname='mgs_funcionario'
    ) THEN

        CREATE ROLE mgs_funcionario NOINHERIT;

    END IF;

END;
$$;

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname='mgs_contratista'
    ) THEN

        CREATE ROLE mgs_contratista NOINHERIT;

    END IF;

END;
$$;

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname='mgs_coordinador'
    ) THEN

        CREATE ROLE mgs_coordinador NOINHERIT;

    END IF;

END;
$$;

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname='mgs_readonly'
    ) THEN

        CREATE ROLE mgs_readonly NOINHERIT;

    END IF;

END;
$$;

/*--------------------------------------------------------
PERMISOS ESQUEMA
--------------------------------------------------------*/

GRANT USAGE ON SCHEMA mgs TO
mgs_admin,
mgs_funcionario,
mgs_contratista,
mgs_coordinador,
mgs_readonly;

/*--------------------------------------------------------
ADMIN
--------------------------------------------------------*/

GRANT ALL PRIVILEGES
ON ALL TABLES IN SCHEMA mgs
TO mgs_admin;

GRANT ALL PRIVILEGES
ON ALL SEQUENCES IN SCHEMA mgs
TO mgs_admin;

/*--------------------------------------------------------
SOLO LECTURA
--------------------------------------------------------*/

GRANT SELECT
ON ALL TABLES IN SCHEMA mgs
TO mgs_readonly;

/*--------------------------------------------------------
FUNCIONARIO
--------------------------------------------------------*/

GRANT SELECT,
      INSERT,
      UPDATE
ON actividad
TO mgs_funcionario;

/*--------------------------------------------------------
CONTRATISTA
--------------------------------------------------------*/

GRANT SELECT,
      INSERT,
      UPDATE
ON actividad
TO mgs_contratista;

/*--------------------------------------------------------
COORDINADOR
--------------------------------------------------------*/

GRANT SELECT
ON ALL TABLES IN SCHEMA mgs
TO mgs_coordinador;

/*--------------------------------------------------------
DEFAULT PRIVILEGES
--------------------------------------------------------*/

ALTER DEFAULT PRIVILEGES
IN SCHEMA mgs
GRANT SELECT
ON TABLES
TO mgs_readonly;
