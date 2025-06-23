@feature_times
Feature: Pruebas validando los tiempos de respuesta de un servicio

  Background:
    * headers {'x-api-key' : 'reqres-free-v1'}

  @test_times_1
  Scenario: Validar que el tiempo de respueta del servicio sea menor a
    Given url "https://reqres.in/api/users/2"
    And request {"name": "morpheus","job": "zion resident"}
    When method patch
    And print "El tiempo de respuesta fue: " + responseTime
    Then assert responseTime < 2000
  # Validar que el tiempo de respuesta del servicio sea menor a 2 segundos, que son 2000 milisegundos