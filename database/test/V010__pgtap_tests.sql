/*
==========================================================
MiGestionSENA
V010__pgtap_tests.sql
==========================================================

Suite pgTAP para:

- fn_resolve_regtype_safe
- fn_assert_column_definition
- fn_assert_fk_compatible

Compatible con PostgreSQL 16
==========================================================
*/

BEGIN;

SELECT plan(38);

----------------------------------------------------------
-- TIPOS BASE
----------------------------------------------------------

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    'test_mgs_types',
    't_bigint',
    'id',
    'pg_catalog.int8'
)
$$,
'bigint valido'
);

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    'test_mgs_types',
    't_uuid',
    'id',
    'pg_catalog.uuid'
)
$$,
'uuid valido'
);

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    'test_mgs_types',
    't_varchar',
    'valor'
)
$$,
'varchar valido'
);

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    'test_mgs_types',
    't_numeric',
    'valor'
)
$$,
'numeric valido'
);

----------------------------------------------------------
-- ERRORES METADATOS
----------------------------------------------------------

SELECT throws_ok(
$$
SELECT mgs.fn_assert_column_definition(
    'schema_inexistente',
    'x',
    'y'
)
$$,
'3F000',
'^Esquema .* no existe$',
'esquema inexistente'
);

SELECT throws_ok(
$$
SELECT mgs.fn_assert_column_definition(
    'test_mgs_types',
    'tabla_fantasma',
    'id'
)
$$,
'42P01',
'^Tabla .* no existe$',
'tabla inexistente'
);

SELECT throws_ok(
$$
SELECT mgs.fn_assert_column_definition(
    'test_mgs_types',
    't_bigint',
    'columna_fantasma'
)
$$,
'42703',
'^Columna .* no existe$',
'columna inexistente'
);

SELECT throws_ok(
$$
SELECT mgs.fn_assert_column_definition(
    NULL,
    't_bigint',
    'id'
)
$$,
'22004',
'^Parámetros obligatorios no pueden ser NULL$',
'parametros null'
);

----------------------------------------------------------
-- DOMINIOS
----------------------------------------------------------

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    'test_mgs_types',
    't_domain',
    'id',
    'pg_catalog.int8'
)
$$,
'dominio simple'
);

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    'test_mgs_types',
    't_nested_domain',
    'id',
    'pg_catalog.int8'
)
$$,
'dominio anidado'
);

SELECT throws_ok(
$$
SELECT mgs.fn_assert_column_definition(
    'test_mgs_types',
    't_domain',
    'id',
    NULL,
    NULL,
    FALSE
)
$$,
'0A000',
'.*utiliza dominio.*',
'dominio prohibido'
);

----------------------------------------------------------
-- ARRAYS
----------------------------------------------------------

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema => 'test_mgs_types',
    p_table  => 't_text_array',
    p_column=>'etiquetas',
    p_expected_array_elem=>'pg_catalog.text'
)
$$,
'array text'
);

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_uuid_array',
    p_column=>'ids',
    p_expected_array_elem=>'pg_catalog.uuid'
)
$$,
'array uuid'
);

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_domain_array',
    p_column=>'ids',
    p_expected_array_elem=>'pg_catalog.int8'
)
$$,
'dominio array'
);

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_nested_array_domain',
    p_column=>'ids',
    p_expected_array_elem=>'pg_catalog.int8'
)
$$,
'dominio array anidado'
);

SELECT throws_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_text_array',
    p_column=>'etiquetas',
    p_allow_arrays=>FALSE
)
$$,
'0A000',
'.*array.*',
'array prohibido'
);

SELECT throws_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_uuid_array',
    p_column=>'ids',
    p_expected_array_elem=>'pg_catalog.int8'
)
$$,
'42804',
'.*esperado.*',
'elemento array incorrecto'
);

----------------------------------------------------------
-- ENUM
----------------------------------------------------------

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_enum',
    p_column=>'estado',
    p_expected_category=>'e'
)
$$,
'enum'
);

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_domain_enum',
    p_column=>'estado',
    p_expected_category=>'e'
)
$$,
'dominio enum'
);

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_nested_domain_enum',
    p_column=>'estado',
    p_expected_category=>'e'
)
$$,
'dominio enum anidado'
);

----------------------------------------------------------
-- COMPOSITE
----------------------------------------------------------

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_composite',
    p_column=>'persona',
    p_expected_category=>'c'
)
$$,
'composite'
);

----------------------------------------------------------
-- RANGE
----------------------------------------------------------

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_range',
    p_column=>'vigencia',
    p_expected_category=>'r'
)
$$,
'range'
);

SELECT throws_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_range',
    p_column=>'vigencia',
    p_expected_category=>'m'
)
$$,
'22023',
'.*MULTIRANGE.*',
'range no es multirange'
);

----------------------------------------------------------
-- MULTIRANGE
----------------------------------------------------------

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_multirange',
    p_column=>'vigencias',
    p_expected_category=>'m'
)
$$,
'multirange'
);

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_domain_multirange',
    p_column=>'periodos',
    p_expected_category=>'m'
)
$$,
'dominio multirange'
);

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    p_schema=>'test_mgs_types',
    p_table=>'t_nested_multirange_domain',
    p_column=>'periodos',
    p_expected_category=>'m'
)
$$,
'dominio multirange anidado'
);

----------------------------------------------------------
-- TABLA PARTICIONADA
----------------------------------------------------------

SELECT lives_ok(
$$
SELECT mgs.fn_assert_column_definition(
    'test_mgs_types',
    'parent_partitioned',
    'id',
    'pg_catalog.int8'
)
$$,
'tabla particionada'
);

----------------------------------------------------------
-- VISTA DEBE FALLAR
----------------------------------------------------------

SELECT throws_ok(
$$
SELECT mgs.fn_assert_column_definition(
    'test_mgs_types',
    'v_test',
    'id'
)
$$,
'42P01',
'.*Tabla.*no existe.*',
'vista rechazada'
);

----------------------------------------------------------
-- FK COMPATIBLE
----------------------------------------------------------

SELECT lives_ok(
$$
SELECT mgs.fn_assert_fk_compatible(
    'test_mgs_types',
    'parent_fk',
    'id',
    'test_mgs_types',
    'child_fk',
    'id'
)
$$,
'fk compatible'
);

----------------------------------------------------------
-- FK INCOMPATIBLE
----------------------------------------------------------

SELECT throws_ok(
$$
SELECT mgs.fn_assert_fk_compatible(
    'test_mgs_types',
    'parent_fk',
    'id',
    'test_mgs_types',
    'child_bad_fk',
    'id'
)
$$,
'42804',
'.*Tipos raíz incompatibles.*',
'fk incompatible'
);

----------------------------------------------------------
-- FK DOMINIO
----------------------------------------------------------

SELECT lives_ok(
$$
SELECT mgs.fn_assert_fk_compatible(
    'test_mgs_types',
    'parent_domain',
    'id',
    'test_mgs_types',
    'child_domain',
    'id'
)
$$,
'fk dominio compatible'
);

SELECT lives_ok(
$$
SELECT mgs.fn_assert_fk_compatible(
    'test_mgs_types',
    'parent_domain',
    'id',
    'test_mgs_types',
    'child_bigint',
    'id'
)
$$,
'fk dominio bigint'
);

----------------------------------------------------------
-- FK SIN UNIQUE
----------------------------------------------------------

SELECT throws_ok(
$$
SELECT mgs.fn_assert_fk_compatible(
    'test_mgs_types',
    'parent_no_unique',
    'id',
    'test_mgs_types',
    'child_fk',
    'id'
)
$$,
'42830',
'.*PRIMARY KEY o UNIQUE.*',
'sin unique'
);

----------------------------------------------------------
-- FK UNIQUE COMPUESTA
----------------------------------------------------------

SELECT throws_ok(
$$
SELECT mgs.fn_assert_fk_compatible(
    'test_mgs_types',
    'parent_composite_unique',
    'codigo',
    'test_mgs_types',
    'child_composite_unique',
    'codigo'
)
$$,
'42830',
'.*una sola columna.*',
'unique compuesta rechazada'
);

----------------------------------------------------------
-- FK ARRAY
----------------------------------------------------------

SELECT throws_ok(
$$
SELECT mgs.fn_assert_fk_compatible(
    'test_mgs_types',
    'parent_array',
    'ids',
    'test_mgs_types',
    'child_array',
    'ids'
)
$$,
'42804',
'.*arrays.*',
'fk array'
);

----------------------------------------------------------
-- FK RANGE
----------------------------------------------------------

SELECT throws_ok(
$$
SELECT mgs.fn_assert_fk_compatible(
    'test_mgs_types',
    'parent_range_unique',
    'vigencia',
    'test_mgs_types',
    'child_range',
    'vigencia'
)
$$,
'42804',
'.*RANGE.*',
'fk range'
);

----------------------------------------------------------
-- FK MULTIRANGE
----------------------------------------------------------

SELECT throws_ok(
$$
SELECT mgs.fn_assert_fk_compatible(
    'test_mgs_types',
    'parent_multirange_unique',
    'vigencias',
    'test_mgs_types',
    'child_multirange',
    'vigencias'
)
$$,
'42804',
'.*MULTIRANGE.*',
'fk multirange'
);

----------------------------------------------------------
-- RESOLVE REGTYPE
----------------------------------------------------------

SELECT ok(
    mgs.fn_resolve_regtype_safe(
        'pg_catalog.uuid'
    ) IS NOT NULL,
    'resolve regtype'
);

SELECT *
FROM finish();

ROLLBACK;
