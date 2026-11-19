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
  @REQ_US-009
  @Boundary
  Scenario: Registrar avance igual a cero
    Given un proyecto válido
    When registra avance 0
    Then el sistema debe aceptarlo

  @REQ_US-009
  @Boundary
  Scenario: Registrar avance igual a cien
    Given un proyecto válido
    When registra avance 100
    Then el sistema debe aceptarlo   

  @REQ_US-009
  @Negative
  Scenario: Registrar avance negativo
    Given un proyecto válido
    When registra avance -1
    Then el sistema debe rechazar el valor

  @REQ_US-009
  @Negative
  Scenario: Registrar avance superior a cien
    Given un proyecto válido
    When registra avance 101
    Then el sistema debe rechazar el valor

  @REQ_US-009
  @Negative
  Scenario: Fecha final menor que fecha inicial
    Given un proyecto nuevo
    When registra fecha inicio "2026-10-10"
    And registra fecha fin "2026-10-01"
    Then el sistema debe impedir guardar el proyecto  

  
