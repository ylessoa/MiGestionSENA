@MGS
@Sprint-5
@Security
Feature: Vista estratégica

  @REQ_US-022
  @Smoke
  Scenario: Consultar indicadores institucionales
    Given un ordenador del gasto autenticado
    When accede a la vista estratégica
    Then visualizará indicadores consolidados

  @REQ_US-022
  Scenario: Acceso solo lectura
    Given la vista estratégica
    When intenta modificar información
    Then el sistema debe impedirlo

  @REQ_US-022
  @Negative
  Scenario: Ordenador intenta eliminar una actividad
    Given una actividad existente
    When el ordenador del gasto intenta eliminarla
    Then la operación debe ser rechazada  
  @REQ_US-022
  @Negative
  Scenario: Ordenador intenta editar un proyecto
    Given un proyecto existente
    When intenta modificar el porcentaje de avance
    Then el sistema debe impedir la edición   

    
