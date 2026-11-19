@MGS
@Sprint-7
Feature: Piloto y adopción

  @REQ_US-031
  Scenario: Capacitar usuarios
    Given un piloto programado
    When se realiza la capacitación
    Then debe existir evidencia de asistencia

  @REQ_US-032
  @Smoke
  Scenario: Ejecutar piloto
    Given el entorno productivo disponible
    When inicia el piloto
    Then los usuarios deberán utilizar la solución

  @REQ_US-033
  Scenario: Gestionar hallazgos
    Given observaciones registradas
    When finaliza el piloto
    Then los hallazgos deben convertirse en elementos del backlog

  @REQ_US-033
  Scenario: Priorizar mejoras
    Given hallazgos documentados
    When se realice la evaluación
    Then debe existir una priorización para la versión 1.1
