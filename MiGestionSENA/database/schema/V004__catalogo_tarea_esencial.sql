/*
==========================================================
MiGestionSENA
V004__catalogo_tarea_esencial.sql
==========================================================
*/

SET search_path TO mgs;

/*--------------------------------------------------------
Catalogo Maestro de Funciones Esenciales
--------------------------------------------------------*/

CREATE TABLE IF NOT EXISTS catalogo_tarea_esencial (

    id BIGSERIAL PRIMARY KEY,

    codigo_tarea VARCHAR(20) NOT NULL,

    codigo_funcion_oficial VARCHAR(50),

    version_manual VARCHAR(30),

    tipo_manual VARCHAR(100),

    nivel VARCHAR(30) NOT NULL,

    grado SMALLINT NOT NULL,

    area_funcional VARCHAR(250) NOT NULL,

    orden_funcion SMALLINT NOT NULL,

    verbo_accion VARCHAR(80),

    titulo_tarea VARCHAR(300) NOT NULL,

    descripcion_funcion_esencial TEXT NOT NULL,

    categoria_tarea VARCHAR(100) NOT NULL,

    frecuencia_sugerida VARCHAR(50),

    evidencia_sugerida VARCHAR(250),

    activa BOOLEAN NOT NULL DEFAULT TRUE,

    fuente VARCHAR(150) NOT NULL,

    fecha_creacion TIMESTAMP NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    fecha_actualizacion TIMESTAMP NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_catalogo_tarea_codigo
        UNIQUE (codigo_tarea),

    CONSTRAINT chk_catalogo_tarea_grado
        CHECK (grado >= 0),

    CONSTRAINT chk_catalogo_tarea_orden
        CHECK (orden_funcion > 0)

);

/*--------------------------------------------------------
Relacion Usuario - Tarea
--------------------------------------------------------*/

CREATE TABLE IF NOT EXISTS usuario_tarea_esencial (

    id BIGSERIAL PRIMARY KEY,

    usuario_id BIGINT NOT NULL,

    tarea_esencial_id BIGINT NOT NULL,

    responsable_principal BOOLEAN
        DEFAULT FALSE,

    fecha_asignacion DATE
        DEFAULT CURRENT_DATE,

    activo BOOLEAN
        DEFAULT TRUE,

    CONSTRAINT fk_usuario_tarea_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuario(id),

    CONSTRAINT fk_usuario_tarea_catalogo
        FOREIGN KEY (tarea_esencial_id)
        REFERENCES catalogo_tarea_esencial(id),

    CONSTRAINT uq_usuario_tarea
        UNIQUE (
            usuario_id,
            tarea_esencial_id
        )

);

/*--------------------------------------------------------
Actividad -> Tarea
--------------------------------------------------------*/

ALTER TABLE actividad

ADD COLUMN IF NOT EXISTS
tarea_esencial_id BIGINT;

/*--------------------------------------------------------
FK Actividad
--------------------------------------------------------*/

DO
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname =
        'fk_actividad_tarea_esencial'
    )
    THEN

        ALTER TABLE actividad

        ADD CONSTRAINT
        fk_actividad_tarea_esencial

        FOREIGN KEY (
            tarea_esencial_id
        )

        REFERENCES
        catalogo_tarea_esencial(id);

    END IF;

END;
$$;
