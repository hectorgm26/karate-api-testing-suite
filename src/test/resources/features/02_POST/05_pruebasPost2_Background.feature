@feature_post_request_background
Feature: Pruebas validando metodos post con background de configuracion

  Background:
    * headers {'x-api-key' : 'reqres-free-v1'}
    * def solicitud = {"name": "morpheus","job": "leader"}

  @test_post_4
  Scenario: Validar que al crear un usuario se recibe el codigo de respuesta 201
    Given url "https://reqres.in/api/users"
    And request solicitud
    When method post
    Then status 201

  @test_post_5
  Scenario: Validar que al crear un usuario, un campo de la respuesta reciba un id
    Given url "https://reqres.in/api/users"
    And request solicitud
    When method post
    Then match response.id == "#present"

  @test_post_6
  Scenario: Validar que al crear un usuario, la llamada sea correcta y no devuelva error
    Given url "https://reqres.in/api/users"
    And request solicitud
    When method post
    Then match response.error == "#notpresent"

  @test_post_7
  Scenario: Validar que se permite crear un usuario con nombre HectorGonzalezM
    Given url "https://reqres.in/api/users"
    And solicitud['name'] = "HectorGonzalezM"
    # Se puede tambien hacer como solicitud.name = "HectorGonzalezM".
    # ESTOS CAMBIOS AL REQUEST SOLO SE APLICAN EN EL SCENARIO DONDE SE HACE EL CAMBIO, NO EN TODOS LOS SCENARIOS DEL FEATURE
    And request solicitud
    When method post
    Then status 201