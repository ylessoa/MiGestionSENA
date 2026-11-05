@MGS
@Sprint-6
@PowerBI
Feature: Dashboard estratégico

  @REQ_US-030
  @Smoke
  Scenario: Consultar indicadores institucionales
    Given un ordenador del gasto autenticado
    When consulta el dashboard estratégico
    Then visualizará indicadores por centro y dependencia

  @REQ_US-030
  Scenario: Consultar avance institucional
    Given información consolidada
    When carga el dashboard
    Then visualizará los resultados institucionales
