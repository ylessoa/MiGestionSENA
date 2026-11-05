@MGS
@Sprint-1
@Dataverse
Feature: Gestión de proyectos

  @REQ_US-009
  @Smoke
  Scenario: Crear proyecto válido
    Given un usuario autenticado
    When registra un proyecto válido
    Then el proyecto debe almacenarse

  @REQ_US-009
  Scenario: Validar porcentaje de avance
    Given un proyecto existente
    When registra un avance superior a 100
    Then el sistema debe rechazar el valor
