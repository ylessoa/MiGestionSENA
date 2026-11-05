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
  @REQ_US-014
  @Security
  Scenario: Editar actividad de otro usuario
    Given existe una actividad propiedad de otro usuario
    When intento modificar la actividad
    Then el sistema debe rechazar la operación
  @REQ_US-014
  @Concurrency
  Scenario: Actualización simultánea
    Given dos usuarios tienen abierta la misma actividad
    When ambos intentan guardar cambios
    Then el sistema debe preservar la última versión válida
    And registrar auditoría
    
