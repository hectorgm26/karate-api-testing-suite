@feature_post_responses
Feature: Pruebas validando metodos post con request en el scenario

  Background:
    * headers {'x-api-key' : 'reqres-free-v1'}

  @test_post_1
  Scenario: Validar que al crear un usuario se recibe el codigo de respuesta 201
    Given url "https://reqres.in/api/users"
    And request {"name": "morpheus","job": "leader"}
    When method post
    Then status 201

  @test_post_2
  Scenario: Validar que al crear un usuario, un campo de la respuesta reciba un id
    Given url "https://reqres.in/api/users"
    And request {"name": "morpheus","job": "leader"}
    When method post
    Then match response.id == "#present"

  @test_post_3
  Scenario: Validar que al crear un usuario, la llamada sea correcta y no devuelva error
    Given url "https://reqres.in/api/users"
    And request {"name": "morpheus","job": "leader"}
    When method post
    Then match response.error == "#notpresent"