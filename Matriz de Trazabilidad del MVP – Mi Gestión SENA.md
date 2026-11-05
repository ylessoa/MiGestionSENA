Matriz de Trazabilidad del MVP – Mi Gestión SENA

La matriz de trazabilidad permite relacionar los objetivos del negocio, las épicas, las historias de usuario, los casos de uso y los criterios de aceptación. Esto facilita el seguimiento durante el desarrollo, las pruebas y la validación del MVP.

Objetivos de Negocio:
ID	ObjetivoOB-01	Organizar las actividades diarias de funcionarios y contratistas

OB-02	Hacer seguimiento a proyectos, compromisos y obligaciones

OB-03	Centralizar las evidencias de gestión

OB-04	Medir el cumplimiento mediante indicadores

OB-05	Garantizar trazabilidad y rendición de cuentas
Matriz de Trazabilidad General
Objetivo	Épica	Historia de Usuario	Caso de Uso	Criterios de AceptaciónOB-01	Gestión de acceso	HU-01 Iniciar sesión	CU-01 Iniciar sesión	CA-01.01 a CA-01.04

OB-01	Mi Día	HU-03 Visualizar actividades del día	CU-02 Consultar Mi Día	CA-03.01 a CA-03.04

OB-01	Gestión de actividades	HU-05 Crear actividad	CU-03 Crear actividad	CA-05.01 a CA-05.03

OB-01	Gestión de actividades	HU-07 Cambiar estado de actividad	CU-04 Gestionar tareas	CA-07.01 a CA-07.03

OB-02	Gestión de proyectos	HU-08 Crear proyecto	CU-05 Gestionar proyecto	CA-08.01 a CA-08.03

OB-02	Compromisos de desempeño	HU-10 Consultar compromisos	CU-06 Registrar avance de compromiso	CA-10.01 a CA-10.03

OB-02	Compromisos de desempeño	HU-11 Actualizar compromiso	CU-06 Registrar avance de compromiso	CA-11.01 a CA-11.03

OB-02	Obligaciones contractuales	HU-12 Consultar obligaciones	CU-07 Registrar avance de obligación contractual	CA-12.01 a CA-12.03

OB-02	Obligaciones contractuales	HU-13 Actualizar obligación contractual	CU-07 Registrar avance de obligación contractual	CA-13.01 a CA-13.03

OB-03	Evidencias	HU-14 Adjuntar evidencia	CU-08 Cargar evidencia	CA-14.01 a CA-14.03

OB-04	Indicadores	HU-16 Visualizar indicadores personales	CU-10 Consultar indicadores personales	CA-16.01 a CA-16.04

OB-05	Seguridad y Auditoría	Todas las HU	Todos los CU	Criterios Globales

Matriz de Trazabilidad por Historia de Usuario

Historia	Caso de Uso	Pantalla	Resultado EsperadoHU-01	CU-01	Login	Usuario autenticado

HU-03	CU-02	Dashboard / Mi Día	Visualización de actividades

HU-05	CU-03	Crear Actividad	Actividad registrada

HU-07	CU-04	Mis Tareas	Estado actualizado

HU-08	CU-05	Proyectos	Proyecto creado

HU-10	CU-06	Compromisos	Consulta de compromisos

HU-11	CU-06	Compromisos	Avance actualizado

HU-12	CU-07	Obligaciones Contractuales	Consulta de obligaciones

HU-13	CU-07	Obligaciones Contractuales	Avance contractual actualizado

HU-14	CU-08	Evidencias	Evidencia almacenada

HU-16	CU-10	Dashboard	Indicadores calculados


Matriz de Trazabilidad de Pantallas

Pantalla	Historias Relacionadas	Casos de UsoInicio de Sesión	HU-01	CU-01

Dashboard	HU-03, HU-16	CU-02, CU-10

Mi Día	HU-03	CU-02

Crear Actividad	HU-05	CU-03

Mis Tareas	HU-07	CU-04

Proyectos	HU-08	CU-05

Compromisos	HU-10, HU-11	CU-06

Obligaciones Contractuales	HU-12, HU-13	CU-07

Evidencias	HU-14	CU-08

Matriz de Trazabilidad para Pruebas (UAT)

ID Prueba	Historia	Escenario	Resultado EsperadoUAT-001	HU-01	Ingresar credenciales válidas	Acceso concedido

UAT-002	HU-01	Ingresar contraseña incorrecta	Mensaje de error

UAT-003	HU-03	Consultar agenda con actividades	Mostrar actividades del día

UAT-004	HU-05	Crear actividad válida	Actividad registrada

UAT-005	HU-07	Marcar actividad como completada	Estado actualizado

UAT-006	HU-08	Crear proyecto	Proyecto almacenado

UAT-007	HU-11	Actualizar compromiso	Porcentaje actualizado

UAT-008	HU-13	Actualizar obligación contractual	Cumplimiento recalculado

UAT-009	HU-14	Cargar archivo PDF	Evidencia registrada

UAT-010	HU-16	Consultar indicadores	Dashboard actualizado


Matriz de Trazabilidad para el Sprint 1 (MVP)

Prioridad	Historia	Módulo	DependenciaMUST	HU-01	Seguridad	Ninguna

MUST	HU-03	Mi Día	HU-01

MUST	HU-05	Actividades	HU-01

MUST	HU-07	Actividades	HU-05

MUST	HU-08	Proyectos	HU-05

MUST	HU-10	Compromisos	HU-01

MUST	HU-11	Compromisos	HU-10
MUST	HU-12	Obligaciones	HU-01
MUST	HU-13	Obligaciones	HU-12
MUST	HU-14	Evidencias	HU-05
MUST	HU-16	Indicadores	Todas las anteriores
