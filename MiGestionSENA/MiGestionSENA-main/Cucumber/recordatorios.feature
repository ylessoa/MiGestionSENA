@MGS
@Sprint-4
@PowerAutomate
Feature: Recordatorios automáticos

  @REQ_US-023
  @Smoke
  Scenario: Enviar recordatorio de actividad
    Given una actividad próxima a iniciar
    When se cumple la ventana de notificación
    Then el usuario recibe una alerta

  @REQ_US-023
  Scenario: Enviar correo
    Given una actividad próxima
    When se ejecuta el flujo
    Then el usuario recibe un correo
