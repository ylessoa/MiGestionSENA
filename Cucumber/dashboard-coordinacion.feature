@MGS
@Sprint-6
@PowerBI
Feature: Dashboard coordinación

  @REQ_US-029
  @Smoke
  Scenario: Visualizar indicadores agregados
    Given un coordinador autenticado
    When consulta el dashboard
    Then visualizará información agregada del equipo

  @REQ_US-029
  Scenario: Evitar rankings individuales
    Given el dashboard de coordinación
    When se muestran indicadores
    Then no deben mostrarse comparaciones individuales
