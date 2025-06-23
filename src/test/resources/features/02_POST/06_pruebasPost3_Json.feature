@feature_post_request_json
Feature: Pruebas validando metodos post desde un archivo json externo

  Background:
    * headers {'x-api-key' : 'reqres-free-v1'}

  @test_post_8
  Scenario: Validar que al crear un usuario se recibe el codigo de respuesta 201
    Given url "https://reqres.in/api/users"
    And def bodyRequest = read("../jsons/posts/create_user.json")
    And bodyRequest['job'] = "Programador"
    And bodyRequest.name = "Yanira Fontalba"
    And request bodyRequest
    When method post
    Then status 201

  @test_post_9
  Scenario: Validar que al crear un usuario, un campo de la respuesta reciba un id
    Given url "https://reqres.in/api/users"
    And def bodyRequest = read("../jsons/posts/create_user.json")
    And request bodyRequest
    When method post
    Then match response.id == "#present"

  @test_post_10
  Scenario Outline: Validar que al crear un usuario se recibe el codigo de respuesta 201 y el nombre del usuario es el que se envio en el body
    Given url "https://reqres.in/api/users"
    And def bodyRequest = read("../jsons/posts/create_user.json")
    And bodyRequest['name'] = <nombre>
    # En examples, la primera fila es el nombre del campo/columna, y como es un json, si en el Examples se ponen los valores entre comillas, no sera necesario poner las comillas en el <nombre>, pero si no se ponen comillas, si es necesario ponerlas en el <nombre>, quedando así: And bodyRequest['name'] = "Hector Gonzalez"
    And request bodyRequest
    When method post
    Then status 201

    Examples:
      | nombre              |
      | "Yanira Fontalba"   |
      | "Javier Llanquileo" |
      | "Juan Pablito"      |