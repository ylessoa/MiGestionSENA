


    ┌────────────────────────────┐
    │ ObligacionContractual      │
    ├────────────────────────────┤
    │ PK IdObligacion            │
    │ Nombre                     │
    │ FechaLimite                │
    │ ContratistaId              │
    └──────────────┬─────────────┘
                   │
                   │ N
                   │
                   │ N
    ┌──────────────▼─────────────┐
    │ ActividadObligacion        │
    ├────────────────────────────┤
    │ PK Id                      │
    │ FK ActividadId             │
    │ FK ObligacionId            │
    └────────────────────────────┘
