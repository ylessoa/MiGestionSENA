@REQ_US-019
@Security
Scenario: Consultar usuarios fuera de la dependencia
  Given un coordinador autenticado
  When accede a información de otra dependencia
  Then el sistema debe ocultar los registros
@REQ_US-019
@Security
Scenario: Modificar actividad de un colaborador
  Given una actividad perteneciente a un funcionario
  When el coordinador intenta modificarla
  Then el sistema debe impedir la operación  
