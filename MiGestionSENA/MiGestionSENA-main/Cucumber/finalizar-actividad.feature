@MGS
@Sprint-3
@PowerApps
Feature: Finalización de actividades

  @REQ_US-015
  @Smoke
  Scenario: Cambiar estado a finalizada
    Given una actividad en curso
    When el usuario selecciona finalizar
    Then el estado será "Finalizada"

  @REQ_US-015
  Scenario: Actualizar indicadores
    Given una actividad finalizada
    When se recalculan indicadores
    Then debe incrementarse el total de actividades completadas
