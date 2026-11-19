@MGS
@Sprint-4
@PowerAutomate
Feature: Resumen semanal

  @REQ_US-025
  Scenario: Consolidar semana
    Given actividades registradas durante la semana
    When se ejecuta el flujo semanal
    Then se genera un consolidado

  @REQ_US-025
  Scenario: Incluir proyectos y evidencias
    Given actividades relacionadas
    When se genera el resumen
    Then deben incluirse proyectos y evidencias
