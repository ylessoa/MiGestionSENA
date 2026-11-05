@MGS
@Sprint-4
@PowerAutomate
@Security
Feature: Auditoría automática

  @REQ_US-026
  @Smoke
  Scenario: Auditar creación
    Given una creación exitosa
    When se completa la transacción
    Then debe registrarse auditoría

  @REQ_US-026
  Scenario: Auditar actualización
    Given una modificación exitosa
    When se completa la operación
    Then debe registrarse auditoría

  @REQ_US-026
  Scenario: Auditar eliminación
    Given una eliminación exitosa
    When se completa la operación
    Then debe registrarse auditoría
