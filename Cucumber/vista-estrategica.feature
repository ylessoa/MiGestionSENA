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
