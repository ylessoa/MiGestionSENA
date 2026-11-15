Dashboard Mi Día
Actividades Hoy

Filter( Actividades, Responsable.Email = User().Email && FechaActividad = Today() )

Pendientes

CountRows( Filter( Actividades, Estado <> "Finalizada" ) )

Completadas

CountRows( Filter( Actividades, Estado = "Finalizada" ) )
