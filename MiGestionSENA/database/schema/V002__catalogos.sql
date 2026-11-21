/*
==========================================================
MiGestionSENA
V002__catalogos.sql
==========================================================
*/

SET search_path TO mgs;

/*--------------------------------------------------------
Clase Vinculación
--------------------------------------------------------*/

CREATE TABLE IF NOT EXISTS cat_clase_vinculacion (

    id SMALLSERIAL PRIMARY KEY,

    codigo VARCHAR(20) NOT NULL UNIQUE,

    nombre VARCHAR(100) NOT NULL UNIQUE,

    activo BOOLEAN NOT NULL DEFAULT TRUE

);

INSERT INTO cat_clase_vinculacion
(codigo,nombre)
VALUES
('FUNC','Funcionario'),
('CONT','Contratista'),
('INST','Instructor'),
('APRE','Aprendiz'),
('DIR','Directivo'),
('COOR','Coordinador')
ON CONFLICT DO NOTHING;

/*--------------------------------------------------------
Estados actividad
--------------------------------------------------------*/

CREATE TABLE IF NOT EXISTS cat_estado_actividad (

    id SMALLSERIAL PRIMARY KEY,

    codigo VARCHAR(20) NOT NULL UNIQUE,

    nombre VARCHAR(100) NOT NULL UNIQUE

);

INSERT INTO cat_estado_actividad
(codigo,nombre)
VALUES
('PLAN','Planificada'),
('CURSO','En Curso'),
('BLOQ','Bloqueada'),
('FIN','Finalizada'),
('CANC','Cancelada')
ON CONFLICT DO NOTHING;

/*--------------------------------------------------------
Prioridades
--------------------------------------------------------*/

CREATE TABLE IF NOT EXISTS cat_prioridad (

    id SMALLSERIAL PRIMARY KEY,

    codigo VARCHAR(20) NOT NULL UNIQUE,

    nombre VARCHAR(100) NOT NULL UNIQUE

);

INSERT INTO cat_prioridad
(codigo,nombre)
VALUES
('BAJA','Baja'),
('MEDIA','Media'),
('ALTA','Alta'),
('CRITICA','Crítica')
ON CONFLICT DO NOTHING;
