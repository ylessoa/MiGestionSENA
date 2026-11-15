Power Fx - Actividades
Mis actividades
Filter( mgs_actividad, mgs_responsable.Email = User().Email )

Actividades de hoy
Filter( mgs_actividad, mgs_responsable.Email = User().Email && mgs_fechaactividad = Today() )

Actividades pendientes
Filter( mgs_actividad, mgs_estado <> "Finalizada" )

Guardar actividad
Patch( mgs_actividad, Defaults(mgs_actividad), { mgs_titulo: txtTitulo.Text, mgs_fechaactividad: dpFecha.SelectedDate, mgs_estado: "Planificada" } )
