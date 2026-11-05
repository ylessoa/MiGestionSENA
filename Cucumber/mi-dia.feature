@MGS
@Sprint-3
@PowerApps
Feature: Mi Día

  @REQ_US-012
  @Smoke
  Scenario: Consultar actividades de hoy
    Given actividades programadas para hoy
    When el usuario abre Mi Día
    Then visualizará únicamente sus actividades

  @REQ_US-012
  Scenario: Consultar pendientes
    Given actividades pendientes
    When se carga la pantalla
    Then debe mostrarse el total de pendientes
