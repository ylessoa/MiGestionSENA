@MGS
@Sprint-3
@PowerApps
Feature: Creación de actividades

  @REQ_US-013
  @Smoke
  Scenario: Crear actividad correctamente
    Given un usuario autenticado
    When registra una actividad válida
    Then la actividad debe almacenarse correctamente
    And el estado inicial debe ser "Planificada"

  @REQ_US-013
  Scenario: No permitir actividad sin título
    Given un usuario autenticado
    When registra una actividad sin título
    Then el sistema debe impedir guardar la actividad

  @REQ_US-013
  Scenario: Responsable automático
    Given un usuario autenticado
    When crea una actividad
    Then el responsable será el usuario actual
