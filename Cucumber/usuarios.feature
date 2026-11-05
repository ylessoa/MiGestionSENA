@MGS
@Sprint-1
@Dataverse
@Regression
Feature: Gestión de usuarios

  @REQ_US-006
  @Smoke
  Scenario: Registrar usuario con documento único
    Given existe un usuario con documento "12345678"
    When intento crear otro usuario con documento "12345678"
    Then el sistema debe rechazar el registro
    And debe mostrar un mensaje indicando que el documento ya existe

  @REQ_US-006
  Scenario: Registrar usuario con correo único
    Given existe un usuario con correo "usuario@sena.edu.co"
    When intento crear otro usuario con correo "usuario@sena.edu.co"
    Then el sistema debe impedir la creación

  @REQ_US-006
  @Smoke
  Scenario: Registrar usuario válido
    Given un administrador autenticado
    When registra un usuario con datos válidos
    Then el usuario debe almacenarse correctamente
