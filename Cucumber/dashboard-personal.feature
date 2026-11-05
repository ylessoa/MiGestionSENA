@REQ_US-028
@Boundary
Scenario: Usuario sin actividades
  Given un usuario sin actividades registradas
  When accede al dashboard
  Then deberá visualizar indicadores en cero

@REQ_US-028
@Boundary
Scenario: Usuario sin evidencias
  Given un usuario sin evidencias registradas
  When consulta el dashboard
  Then deberá visualizar cero evidencias  
