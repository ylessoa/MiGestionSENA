@MGS
@Security
@Regression
Feature: Seguridad Dataverse

  @REQ_US-010
  Scenario: Usuario visualiza únicamente registros propios
    Given un usuario autenticado
    When consulta actividades
    Then solo debe visualizar actividades propias

  @REQ_US-010
  Scenario: Coordinador visualiza registros de su unidad
    Given un coordinador autenticado
    When consulta actividades
    Then solo debe visualizar actividades de su unidad organizacional

  @REQ_US-010
  Scenario: Administrador visualiza todos los registros
    Given un administrador autenticado
    When consulta actividades
    Then debe visualizar los registros de toda la organización

  @REQ_US-035
  Scenario: Aplicar jerarquía organizacional
    Given existe una jerarquía configurada
    When un coordinador consulta actividades
    Then únicamente visualizará registros de sus subordinados

  @REQ_US-034
  Scenario: Campo protegido por Field Security
    Given un usuario sin privilegios
    When intenta acceder al número de documento
    Then el valor debe mostrarse oculto
