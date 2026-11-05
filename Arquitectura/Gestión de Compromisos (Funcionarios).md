  ┌──────────────────────────┐
  │ CompromisoDesempeno      │
  ├──────────────────────────┤
  │ PK IdCompromiso          │
  │ Nombre                   │
  │ Meta                     │
  │ FuncionarioId            │
  └────────────┬─────────────┘
               │
               │ N
               │
               │ N
  ┌────────────▼─────────────┐
  │ ActividadCompromiso      │
  ├──────────────────────────┤
  │ PK Id                    │
  │ FK ActividadId           │
  │ FK CompromisoId          │
  └──────────────────────────┘
