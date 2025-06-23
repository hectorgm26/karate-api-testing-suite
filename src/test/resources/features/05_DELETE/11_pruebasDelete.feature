@feature_delete
Feature: Pruebas validando el metodo delete

  Background:
    * headers {'x-api-key' : 'reqres-free-v1'}

  @test_delete_1
  Scenario: Validar que al eliminar un usuario, el codigo de respuesta sea 204
    Given url "https://reqres.in/api/users/2"
    When method delete
    Then status 204