    ┌────────────────────┐
    │      Proyecto      │
    ├────────────────────┤
    │ PK IdProyecto      │
    │ Nombre             │
    │ Objetivo           │
    │ ResponsableId      │
    └─────────┬──────────┘
              │
              │ N
              │
              │ N
    ┌─────────▼──────────┐
    │ ActividadProyecto  │
    ├────────────────────┤
    │ PK Id              │
    │ FK ActividadId     │
    │ FK ProyectoId      │
    └─────────┬──────────┘
              │
              │
              ▼
          Actividad
