┌───────────────────────┐
│   CentroFormacion     │
├───────────────────────┤
│ PK IdCentro           │
│ CodigoCentro          │
│ Nombre                │
│ Regional              │
└───────────┬───────────┘
            │ 1
            │
            │ N
┌───────────▼───────────┐
│     Dependencia       │
├───────────────────────┤
│ PK IdDependencia      │
│ FK CentroId           │
│ Nombre                │
└───────────┬───────────┘
            │1
            │
            │N
┌───────────▼───────────┐
│       Usuario         │
├───────────────────────┤
│ PK IdUsuario          │
│ NombreCompleto        │
│ CorreoInstitucional   │
│ Rol                   │
│ FuncionOrganizacional │
│ FK DependenciaId      │
└───────┬───────┬───────┘
        │       │
        │       │
        │       └──────────────────────────┐
        │                                  │
        │                                  ▼
        │                    ┌─────────────────────────┐
        │                    │ EstructuraJerarquica    │
        │                    ├─────────────────────────┤
        │                    │ PK IdRelacion           │
        │                    │ FK UsuarioSuperiorId    │
        │                    │ FK UsuarioDependienteId │
        │                    │ TipoRelacion           │
        │                    └─────────────────────────┘
        │
        │ 1
        │
        │ N
┌───────▼────────┐
│   Actividad    │
├────────────────┤
│ PK IdActividad │
│ Titulo         │
│ FechaActividad │
│ Estado         │
│ Prioridad      │
│ FK Responsable │
└───────┬────────┘
        │
        │1
        │
        │N
┌───────▼──────────┐
│    Evidencia     │
├──────────────────┤
│ PK IdEvidencia   │
│ FK ActividadId   │
│ NombreArchivo    │
│ RutaArchivo      │
└──────────────────┘
