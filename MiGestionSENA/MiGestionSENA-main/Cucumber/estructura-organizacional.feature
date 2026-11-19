@MGS
@Sprint-1
@Security
@Dataverse
Feature: Gestión de estructura organizacional

  @REQ_US-007
  @Smoke
  Scenario: Crear relación jerárquica válida
    Given existe un usuario superior
    And existe un usuario dependiente
    When se crea la relación jerárquica
    Then la relación debe guardarse correctamente

  @REQ_US-007
  @Security
  Scenario: Evitar autorrelación
    Given un usuario existente
    When intenta registrarse como superior y dependiente
    Then el sistema debe rechazar la operación
