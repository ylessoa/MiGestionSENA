@MGS
@Sprint-3
@PowerApps
@SharePoint
Feature: Gestión de evidencias

  @REQ_US-016
  @Smoke
  Scenario: Registrar evidencia asociada
    Given una actividad existente
    When el usuario adjunta un archivo
    Then debe generarse un registro de evidencia

  @REQ_US-016
  Scenario: Guardar evidencia en SharePoint
    Given una evidencia nueva
    When finaliza la carga
    Then el documento debe almacenarse en SharePoint

  @REQ_US-016
  @Security
  Scenario: Impedir evidencia sin actividad
    Given una evidencia nueva
    When no tiene actividad asociada
    Then el sistema debe rechazar la operación
  @REQ_US-016
  @Boundary
  Scenario: Registrar archivo con tamaño máximo permitido
    Given una actividad existente
    When el usuario carga un archivo del tamaño máximo configurado
    Then la evidencia debe registrarse correctamente

  @REQ_US-016
  @Negative
  Scenario: Cargar archivo mayor al tamaño permitido
    Given una actividad existente
    When el usuario carga un archivo que excede el límite permitido
    Then el sistema debe rechazarlo
  @REQ_US-016
  @Negative
  Scenario: Cargar archivo con extensión no permitida
    Given una actividad existente
    When el usuario intenta cargar un archivo .exe
    Then el sistema debe bloquear la carga

  @REQ_US-016
  @Security
  Scenario: Acceder a evidencia sin permisos
    Given una evidencia perteneciente a otro usuario
    When se intenta acceder directamente al enlace
    Then el acceso debe ser denegado
  
