@regresiva_test
Feature: Prueba inicial de configuracion

  Background:
    * headers {'x-api-key' : 'reqres-free-v1'}

  @prueba1 @regresiva_particular
  Scenario: Validacion de API de dias feriados de Chile
    Given url "https://api.boostr.cl/holidays.json"
    When method get
    Then status 200