Alternate Keys
mgs_centroformacion
Clave alternativa:

mgs_codigo

Justificación: El código del centro es único dentro del SENA.

mgs_usuario
Claves alternativas:

mgs_documento

mgs_correo

Justificación: No deben existir usuarios duplicados.

mgs_dependencia
Clave alternativa compuesta:

mgs_nombre mgs_centroformacion

Justificación: Dos dependencias pueden compartir nombre únicamente si pertenecen a centros distintos.

mgs_proyecto
Clave alternativa:

mgs_nombre mgs_responsable

Justificación: Evita proyectos duplicados para un mismo responsable.

mgs_diariogestion
Clave alternativa compuesta:

mgs_usuario mgs_fecha

Justificación: Un usuario solo puede registrar un diario por día.
