/*
==========================================================
MiGestionSENA
V003__modelo_mgs.sql
==========================================================
*/

SET search_path TO mgs;

/*--------------------------------------------------------
Centro Formación
--------------------------------------------------------*/

CREATE TABLE IF NOT EXISTS centro_formacion (

    id BIGSERIAL PRIMARY KEY,

    codigo_centro VARCHAR(20) NOT NULL UNIQUE,

    nombre VARCHAR(250) NOT NULL,

    codigo_regional VARCHAR(20),

    descripcion_regional VARCHAR(250),

    regional VARCHAR(150) NOT NULL,

    activo BOOLEAN NOT NULL DEFAULT TRUE,

    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

);

/*--------------------------------------------------------
Dependencia
--------------------------------------------------------*/

CREATE TABLE IF NOT EXISTS dependencia (

    id BIGSERIAL PRIMARY KEY,

    codigo_dependencia VARCHAR(50) NOT NULL UNIQUE,

    nombre VARCHAR(250) NOT NULL,

    centro_formacion_id BIGINT NOT NULL,

    activo BOOLEAN NOT NULL DEFAULT TRUE,

    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_dependencia_centro
        FOREIGN KEY (centro_formacion_id)
        REFERENCES centro_formacion(id)

);

/*--------------------------------------------------------
Usuario
--------------------------------------------------------*/

CREATE TABLE IF NOT EXISTS usuario (

    id BIGSERIAL PRIMARY KEY,

    documento VARCHAR(20) NOT NULL UNIQUE,

    nombre_completo VARCHAR(250) NOT NULL,

    correo_institucional VARCHAR(250) NOT NULL UNIQUE,

    clase_vinculacion_id SMALLINT,

    dependencia_id BIGINT NOT NULL,

    activo BOOLEAN NOT NULL DEFAULT TRUE,

    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_usuario_dependencia
        FOREIGN KEY (dependencia_id)
        REFERENCES dependencia(id),

    CONSTRAINT fk_usuario_clase
        FOREIGN KEY (clase_vinculacion_id)
        REFERENCES cat_clase_vinculacion(id)

);

/*--------------------------------------------------------
Proyecto
--------------------------------------------------------*/

CREATE TABLE IF NOT EXISTS proyecto (

    id BIGSERIAL PRIMARY KEY,

    codigo_proyecto VARCHAR(50) NOT NULL UNIQUE,

    nombre VARCHAR(250) NOT NULL,

    objetivo TEXT,

    responsable_id BIGINT NOT NULL,

    fecha_inicio DATE,

    fecha_fin DATE,

    avance NUMERIC(5,2) NOT NULL DEFAULT 0,

    estado VARCHAR(50),

    activo BOOLEAN DEFAULT TRUE,

    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_proyecto_usuario
        FOREIGN KEY (responsable_id)
        REFERENCES usuario(id),

    CONSTRAINT chk_proyecto_avance
        CHECK (avance BETWEEN 0 AND 100)

);

/*--------------------------------------------------------
Actividad
--------------------------------------------------------*/

CREATE TABLE IF NOT EXISTS actividad (

    id BIGSERIAL PRIMARY KEY,

    codigo_actividad VARCHAR(50) NOT NULL UNIQUE,

    titulo VARCHAR(250) NOT NULL,

    descripcion TEXT,

    responsable_id BIGINT NOT NULL,

    fecha_actividad DATE NOT NULL,

    avance NUMERIC(5,2) NOT NULL DEFAULT 0,

    estado_actividad_id SMALLINT NOT NULL,

    prioridad_id SMALLINT NOT NULL,

    activo BOOLEAN DEFAULT TRUE,

    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_actividad_usuario
        FOREIGN KEY (responsable_id)
        REFERENCES usuario(id),

    CONSTRAINT fk_actividad_estado
        FOREIGN KEY (estado_actividad_id)
        REFERENCES cat_estado_actividad(id),

    CONSTRAINT fk_actividad_prioridad
        FOREIGN KEY (prioridad_id)
        REFERENCES cat_prioridad(id),

    CONSTRAINT chk_actividad_avance
        CHECK (avance BETWEEN 0 AND 100)

);
