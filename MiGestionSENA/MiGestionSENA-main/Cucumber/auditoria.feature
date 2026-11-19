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

  @REQ_US-026
  @Audit
  Scenario: Registrar usuario ejecutor
    Given una actualización exitosa
    When el sistema genera auditoría
    Then debe registrarse el usuario que ejecutó la acción  

 @REQ_US-026
  @Audit
  Scenario: Registrar fecha y hora
    Given una operación exitosa
    When se crea el registro de auditoría
    Then debe registrarse fecha y hora exactas   
