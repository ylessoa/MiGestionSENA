@MGS
@Sprint-3
@PowerApps
Feature: Actualización de actividades

  @REQ_US-014
  @Smoke
  Scenario: Editar actividad existente
    Given una actividad registrada
    When el usuario modifica la descripción
    Then la actividad debe actualizarse correctamente

  @REQ_US-014
  Scenario: Registrar auditoría
    Given una actividad existente
    When se actualiza la actividad
    Then debe generarse un registro de auditoría
