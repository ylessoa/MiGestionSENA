@MGS
@Sprint-4
@PowerAutomate
Feature: Resumen diario

  @REQ_US-024
  Scenario: Generar resumen diario
    Given actividades activas
    When se ejecuta el flujo diario
    Then se genera el resumen

  @REQ_US-024
  Scenario: Enviar resumen
    Given un resumen generado
    When finaliza el flujo
    Then el usuario recibe el correo
