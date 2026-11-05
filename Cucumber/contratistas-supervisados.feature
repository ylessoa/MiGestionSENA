@MGS
@Sprint-5
Feature: Supervisión de contratistas

  @REQ_US-021
  @Smoke
  Scenario: Consultar contratistas
    Given un supervisor autenticado
    When accede a la vista de supervisión
    Then visualizará únicamente contratistas asignados

  @REQ_US-021
  Scenario: Consultar obligaciones
    Given contratistas asociados
    When consulta las obligaciones
    Then visualizará las obligaciones activas
