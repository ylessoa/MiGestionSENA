@MGS
@Sprint-4
@PowerAutomate
Feature: Avance automático de proyectos

  @REQ_US-027
  @Smoke
  Scenario: Recalcular avance
    Given un proyecto con actividades asociadas
    When una actividad cambia a estado Finalizada
    Then el porcentaje de avance debe recalcularse

  @REQ_US-027
  Scenario: Actualizar porcentaje
    Given actividades completadas
    When finaliza el cálculo
    Then el porcentaje debe actualizarse automáticamente
