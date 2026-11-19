Power Fx - Proyectos
Mis proyectos
Filter( mgs_proyecto, mgs_responsable.Email = User().Email )

Calcular avance
Round( Average( Filter( mgs_actividadproyecto, Proyecto.Id = ThisItem.Id ), PorcentajeAvance ), 0 )

Proyectos activos
Filter( mgs_proyecto, mgs_avance < 100 )
