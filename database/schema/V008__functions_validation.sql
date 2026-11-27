/*
==========================================================
MiGestionSENA
V008__functions_validation.sql
==========================================================

Funciones incluidas

- mgs.fn_resolve_regtype_safe
- mgs.fn_resolve_type_hierarchy
- mgs.fn_assert_column_definition
- mgs.fn_assert_fk_compatible

Compatible con PostgreSQL 16.
==========================================================
*/

/*==========================================================
fn_resolve_regtype_safe
==========================================================*/

CREATE OR REPLACE FUNCTION
mgs.fn_resolve_regtype_safe(
    p_type_name text
)
RETURNS oid
LANGUAGE plpgsql
STABLE
AS
$$
DECLARE
    v_oid oid;
BEGIN

    IF p_type_name IS NULL THEN
        RETURN NULL;
    END IF;

    v_oid := to_regtype(p_type_name);

    IF v_oid IS NULL THEN

        RAISE EXCEPTION USING
            ERRCODE = '42704',
            MESSAGE = format(
                'Tipo "%s" no existe o requiere nombre calificado',
                p_type_name
            );

    END IF;

    RETURN v_oid;

END;
$$;

/*==========================================================
fn_resolve_type_hierarchy
==========================================================*/

CREATE OR REPLACE FUNCTION
mgs.fn_resolve_type_hierarchy(
    p_type_oid oid
)
RETURNS TABLE(

    declared_type_oid oid,

    root_type_oid oid,

    root_type_name text,

    declared_t.typtype::text,
    
    root_t.typtype::text

    is_array boolean,

    root_element_oid oid,

    root_element_name text,

    is_range boolean,

    is_multirange boolean

)
LANGUAGE plpgsql
STABLE
AS
$$
DECLARE

    v_current oid;
    v_depth integer := 0;

BEGIN

    IF p_type_oid IS NULL THEN

        RAISE EXCEPTION USING
            ERRCODE='22004',
            MESSAGE='OID de tipo no puede ser NULL';

    END IF;

    v_current := p_type_oid;

    LOOP

        v_depth := v_depth + 1;

        IF v_depth > 32 THEN

            RAISE EXCEPTION USING
                ERRCODE='54001',
                MESSAGE='Jerarquía de dominios excede profundidad máxima';

        END IF;

        EXIT
        WHEN NOT EXISTS (
            SELECT 1
            FROM pg_type
            WHERE oid = v_current
              AND typbasetype <> 0
        );

        SELECT typbasetype
          INTO v_current
        FROM pg_type
        WHERE oid = v_current;

        IF NOT FOUND THEN

            RAISE EXCEPTION USING
                ERRCODE='42704',
                MESSAGE='Tipo intermedio no encontrado';

        END IF;

    END LOOP;

    RETURN QUERY
    SELECT

        p_type_oid,

        root_t.oid,

        format_type(root_t.oid,NULL),

        declared_t.typtype::text,
        
        root_t.typtype::text,

    
        (root_t.typelem <> 0),

        NULLIF(root_t.typelem,0),

        CASE
            WHEN root_t.typelem <> 0
            THEN format_type(root_t.typelem,NULL)
            ELSE NULL
        END,

        EXISTS (
            SELECT 1
            FROM pg_range r
            WHERE r.rngtypid = root_t.oid
        ),

        EXISTS (
            SELECT 1
            FROM pg_range r
            WHERE r.rngmultitypid = root_t.oid
        )

    FROM pg_type declared_t
    CROSS JOIN pg_type root_t

    WHERE declared_t.oid = p_type_oid
      AND root_t.oid = v_current;

END;
$$;

/*==========================================================
fn_assert_column_definition
==========================================================*/

CREATE OR REPLACE FUNCTION
mgs.fn_assert_column_definition(

    p_schema text,
    p_table text,
    p_column text,

    p_expected_type text DEFAULT NULL,

    p_expected_category char DEFAULT NULL,

    p_allow_domains boolean DEFAULT TRUE,

    p_allow_arrays boolean DEFAULT TRUE,

    p_expected_array_elem text DEFAULT NULL

)
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE

    v_type_oid oid;

    declared_typtype text
    root_typtype text

    v_root_oid oid;
    v_root_name text;

    v_root_element_oid oid;
    v_root_element_name text;

    v_expected_type_oid oid;
    v_expected_array_oid oid;

    v_is_array boolean;
    v_is_range boolean;
    v_is_multirange boolean;

BEGIN

    IF p_schema IS NULL
       OR p_table IS NULL
       OR p_column IS NULL
    THEN

        RAISE EXCEPTION USING
            ERRCODE='22004',
            MESSAGE='Parámetros obligatorios no pueden ser NULL';

    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_namespace
        WHERE nspname = p_schema
    )
    THEN

        RAISE EXCEPTION USING
            ERRCODE='3F000',
            MESSAGE=format(
                'Esquema "%s" no existe',
                p_schema
            );

    END IF;

    IF NOT EXISTS (

        SELECT 1
        FROM pg_class c
        JOIN pg_namespace n
            ON n.oid = c.relnamespace

        WHERE n.nspname = p_schema
          AND c.relname = p_table
          AND c.relkind IN ('r','p','f')

    )
    THEN

        RAISE EXCEPTION USING
            ERRCODE='42P01',
            MESSAGE=format(
                'Tabla %s.%s no existe',
                p_schema,
                p_table
            );

    END IF;

    SELECT a.atttypid
      INTO v_type_oid
    FROM pg_attribute a
    JOIN pg_class c
      ON c.oid = a.attrelid
    JOIN pg_namespace n
      ON n.oid = c.relnamespace
    WHERE n.nspname = p_schema
      AND c.relname = p_table
      AND a.attname = p_column
      AND a.attnum > 0
      AND NOT a.attisdropped;

    IF v_type_oid IS NULL THEN

        RAISE EXCEPTION USING
            ERRCODE='42703',
            MESSAGE=format(
                'Columna %s.%s.%s no existe',
                p_schema,
                p_table,
                p_column
            );

    END IF;

    SELECT
        declared_typtype,
        root_typtype,
        root_type_oid,
        root_type_name,
        is_array,
        root_element_oid,
        root_element_name,
        is_range,
        is_multirange
    INTO
        v_declared_typtype,
        v_root_typtype,
        v_root_oid,
        v_root_name,
        v_is_array,
        v_root_element_oid,
        v_root_element_name,
        v_is_range,
        v_is_multirange
    FROM mgs.fn_resolve_type_hierarchy(
        v_type_oid
    );

    IF NOT FOUND THEN

        RAISE EXCEPTION USING
            ERRCODE='42704',
            MESSAGE='No fue posible resolver metadatos del tipo';

    END IF;

    IF p_expected_type IS NOT NULL THEN

        v_expected_type_oid :=
            mgs.fn_resolve_regtype_safe(
                p_expected_type
            );

    END IF;

    IF p_expected_array_elem IS NOT NULL THEN

        v_expected_array_oid :=
            mgs.fn_resolve_regtype_safe(
                p_expected_array_elem
            );

    END IF;

    IF v_declared_typtype = 'd'
       AND NOT p_allow_domains
    THEN

        RAISE EXCEPTION USING
            ERRCODE='0A000',
            MESSAGE=format(
                '%s.%s.%s utiliza dominio',
                p_schema,
                p_table,
                p_column
            );

    END IF;

    IF v_is_array THEN

        IF NOT p_allow_arrays THEN

            RAISE EXCEPTION USING
                ERRCODE='0A000',
                MESSAGE=format(
                    '%s.%s.%s es array',
                    p_schema,
                    p_table,
                    p_column
                );

        END IF;

        IF p_expected_array_elem IS NOT NULL
           AND v_root_element_oid <> v_expected_array_oid
        THEN

            RAISE EXCEPTION USING
                ERRCODE='42804',
                MESSAGE=format(
                    '%s.%s.%s es array de %s, esperado %s',
                    p_schema,
                    p_table,
                    p_column,
                    v_root_element_name,
                    p_expected_array_elem
                );

        END IF;

    ELSIF p_expected_array_elem IS NOT NULL THEN

        RAISE EXCEPTION USING
            ERRCODE='42804',
            MESSAGE=format(
                '%s.%s.%s no es un array',
                p_schema,
                p_table,
                p_column
            );

    END IF;

    IF p_expected_category IS NOT NULL THEN

        CASE p_expected_category

            WHEN 'r' THEN

                IF NOT v_is_range THEN

                    RAISE EXCEPTION USING
                        ERRCODE='22023',
                        MESSAGE='Tipo RANGE esperado';

                END IF;

            WHEN 'm' THEN

                IF NOT v_is_multirange THEN

                    RAISE EXCEPTION USING
                        ERRCODE='22023',
                        MESSAGE='Tipo MULTIRANGE esperado';

                END IF;

            ELSE

                IF v_root_typtype <> p_expected_category THEN

                    RAISE EXCEPTION USING
                        ERRCODE='22023',
                        MESSAGE=format(
                            'Categoría inválida. Encontrado %s, esperado %s',
                            v_root_typtype,
                            p_expected_category
                        );

                END IF;

        END CASE;

    END IF;

    IF p_expected_type IS NOT NULL
       AND v_root_oid <> v_expected_type_oid
    THEN

        RAISE EXCEPTION USING
            ERRCODE='42804',
            MESSAGE=format(
                '%s.%s.%s tipo incompatible. Encontrado %s, esperado %s',
                p_schema,
                p_table,
                p_column,
                v_root_name,
                p_expected_type
            );

    END IF;

END;
$$;

/*==========================================================
fn_assert_fk_compatible
==========================================================*/

CREATE OR REPLACE FUNCTION
mgs.fn_assert_fk_compatible(

    p_parent_schema text,
    p_parent_table text,
    p_parent_column text,

    p_child_schema text,
    p_child_table text,
    p_child_column text

)
RETURNS void
LANGUAGE plpgsql
AS
$$
DECLARE

    v_parent_oid oid;
    v_child_oid oid;

    v_parent_root oid;
    v_child_root oid;

    v_parent_typtype text;
    v_child_typtype text;

    v_parent_element oid;
    v_child_element oid;

    v_parent_array boolean;
    v_child_array boolean;

    v_parent_range boolean;
    v_child_range boolean;

    v_parent_multirange boolean;
    v_child_multirange boolean;

BEGIN

    IF p_parent_schema IS NULL
       OR p_parent_table IS NULL
       OR p_parent_column IS NULL
       OR p_child_schema IS NULL
       OR p_child_table IS NULL
       OR p_child_column IS NULL
    THEN

        RAISE EXCEPTION USING
            ERRCODE='22004',
            MESSAGE='Parámetros obligatorios no pueden ser NULL';

    END IF;

    PERFORM mgs.fn_assert_column_definition(
        p_parent_schema,
        p_parent_table,
        p_parent_column
    );

    PERFORM mgs.fn_assert_column_definition(
        p_child_schema,
        p_child_table,
        p_child_column
    );

    SELECT a.atttypid
    INTO v_parent_oid
    FROM pg_attribute a
    JOIN pg_class c ON c.oid = a.attrelid
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = p_parent_schema
      AND c.relname = p_parent_table
      AND a.attname = p_parent_column
      AND a.attnum > 0
      AND NOT a.attisdropped;

    SELECT a.atttypid
    INTO v_child_oid
    FROM pg_attribute a
    JOIN pg_class c ON c.oid = a.attrelid
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = p_child_schema
      AND c.relname = p_child_table
      AND a.attname = p_child_column
      AND a.attnum > 0
      AND NOT a.attisdropped;

    SELECT
        root_type_oid,
        root_typtype,
        root_element_oid,
        is_array,
        is_range,
        is_multirange
    INTO
        v_parent_root,
        v_parent_typtype,
        v_parent_element,
        v_parent_array,
        v_parent_range,
        v_parent_multirange
    FROM mgs.fn_resolve_type_hierarchy(v_parent_oid);

    IF NOT FOUND THEN
        RAISE EXCEPTION USING
            ERRCODE='42704',
            MESSAGE='No fue posible resolver el tipo de la columna padre';
    END IF;

    SELECT
        root_type_oid,
        root_typtype,
        root_element_oid,
        is_array,
        is_range,
        is_multirange
    INTO
        v_child_root,
        v_child_typtype,
        v_child_element,
        v_child_array,
        v_child_range,
        v_child_multirange
    FROM mgs.fn_resolve_type_hierarchy(v_child_oid);

    IF NOT FOUND THEN
        RAISE EXCEPTION USING
            ERRCODE='42704',
            MESSAGE='No fue posible resolver el tipo de la columna hija';
    END IF;

    IF v_parent_array OR v_child_array THEN
        RAISE EXCEPTION USING
            ERRCODE='42804',
            MESSAGE='Las claves foráneas no pueden definirse sobre arrays';
    END IF;

    IF v_parent_range OR v_child_range THEN
        RAISE EXCEPTION USING
            ERRCODE='42804',
            MESSAGE='Las claves foráneas no pueden definirse sobre RANGE';
    END IF;

    IF v_parent_multirange OR v_child_multirange THEN
        RAISE EXCEPTION USING
            ERRCODE='42804',
            MESSAGE='Las claves foráneas no pueden definirse sobre MULTIRANGE';
    END IF;

    IF v_parent_root <> v_child_root THEN

        RAISE EXCEPTION USING
            ERRCODE='42804',
            MESSAGE=format(
                'Tipos raíz incompatibles: padre=%s hijo=%s',
                v_parent_root,
                v_child_root
            );

    END IF;

    IF v_parent_typtype <> v_child_typtype THEN

        RAISE EXCEPTION USING
            ERRCODE='42804',
            MESSAGE=format(
                'Categorías incompatibles: padre=%s hijo=%s',
                v_parent_typtype,
                v_child_typtype
            );

    END IF;

    IF COALESCE(v_parent_element,0)
       <> COALESCE(v_child_element,0)
    THEN

        RAISE EXCEPTION USING
            ERRCODE='42804',
            MESSAGE=format(
                'Elementos incompatibles: padre=%s hijo=%s',
                COALESCE(v_parent_element,0),
                COALESCE(v_child_element,0)
            );

    END IF;

    IF NOT EXISTS (

        SELECT 1

        FROM pg_constraint pc

        JOIN pg_class t
            ON t.oid = pc.conrelid

        JOIN pg_namespace n
            ON n.oid = t.relnamespace

        JOIN LATERAL unnest(pc.conkey)
            AS cols(attnum)
            ON TRUE

        JOIN pg_attribute a
            ON a.attrelid = t.oid
           AND a.attnum = cols.attnum

        WHERE n.nspname = p_parent_schema
          AND t.relname = p_parent_table
          AND a.attname = p_parent_column
          AND pc.contype IN ('p','u')
          AND array_length(pc.conkey,1) = 1

    )
    THEN

        RAISE EXCEPTION USING
            ERRCODE='42830',
            MESSAGE=format(
                'La columna %s.%s.%s debe ser PRIMARY KEY o UNIQUE de una sola columna',
                p_parent_schema,
                p_parent_table,
                p_parent_column
            );

    END IF;

END;
$$;
