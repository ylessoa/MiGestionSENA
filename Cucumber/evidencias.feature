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
