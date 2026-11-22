/*
==========================================================
MiGestionSENA
V005__roles_permisos.sql
==========================================================
*/

SET search_path TO mgs;

-- --------------------------------------------------------
-- ROLES
-- --------------------------------------------------------

DO $$
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

DO $$
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

DO $$
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

DO $$
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

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname='mgs_supervisor'
    ) THEN
        CREATE ROLE mgs_supervisor NOINHERIT;
    END IF;
END;
$$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname='mgs_ordenador_gasto'
    ) THEN
        CREATE ROLE mgs_ordenador_gasto NOINHERIT;
    END IF;
END;
$$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname='mgs_app'
    ) THEN
        CREATE ROLE mgs_app NOINHERIT;
    END IF;
END;
$$;

DO $$
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

-- --------------------------------------------------------
-- USAGE SCHEMA
-- --------------------------------------------------------

GRANT USAGE ON SCHEMA mgs TO
mgs_admin,
mgs_funcionario,
mgs_contratista,
mgs_coordinador,
mgs_supervisor,
mgs_ordenador_gasto,
mgs_app,
mgs_readonly;

-- --------------------------------------------------------
-- ADMINISTRADOR
-- --------------------------------------------------------

GRANT ALL PRIVILEGES
ON ALL TABLES IN SCHEMA mgs
TO mgs_admin;

GRANT ALL PRIVILEGES
ON ALL SEQUENCES IN SCHEMA mgs
TO mgs_admin;

-- --------------------------------------------------------
