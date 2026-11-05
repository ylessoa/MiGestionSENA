@MGS
@Sprint-3
@PowerApps
Feature: Creación de actividades

  @REQ_US-013
  @Smoke
  Scenario: Crear actividad correctamente
    Given un usuario autenticado
    When registra una actividad válida
    Then la actividad debe almacenarse correctamente
    And el estado inicial debe ser "Planificada"

  @REQ_US-013
  Scenario: No permitir actividad sin título
    Given un usuario autenticado
    When registra una actividad sin título
    Then el sistema debe impedir guardar la actividad

  @REQ_US-013
  Scenario: Responsable automático
    Given un usuario autenticado
    When crea una actividad
    Then el responsable será el usuario actual

  @REQ_US-013
@Boundary
Scenario: Crear actividad con título de longitud mínima
  Given un usuario autenticado
  When registra una actividad con un título de 5 caracteres
  Then la actividad debe guardarse correctamente
@REQ_US-013
@Boundary
Scenario: Crear actividad con título de longitud máxima
  Given un usuario autenticado
  When registra una actividad con 250 caracteres en el título
  Then la actividad debe almacenarse correctamente
@REQ_US-013
@Negative
Scenario: Crear actividad con fecha vacía
  Given un usuario autenticado
  When intenta guardar una actividad sin fecha
  Then el sistema debe impedir el registro
@REQ_US-013
@Negative
Scenario: Crear actividad con hora final anterior a hora inicial
  Given un usuario autenticado
  When registra hora inicio "15:00"
  And registra hora fin "14:00"
  Then el sistema debe mostrar error de validación

@REQ_US-013
@Negative
Scenario: Crear actividad sin permisos
  Given un usuario deshabilitado
  When intenta registrar una actividad
  Then el sistema debe denegar la operación
