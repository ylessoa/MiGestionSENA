@MGS
@Sprint-3
@Security
Feature: Diario de gestión

  @REQ_US-017
  Scenario: Registrar diario
    Given un usuario autenticado
    When registra su diario
    Then el sistema debe almacenarlo

  @REQ_US-017
  Scenario: Impedir diarios duplicados
    Given existe un diario para la fecha actual
    When el usuario intenta crear otro
    Then el sistema debe impedirlo

  @REQ_US-017
  @Security
  @Smoke
  Scenario: Garantizar privacidad
    Given un coordinador autenticado
    When intenta acceder al diario de otro usuario
    Then el acceso debe ser denegado
