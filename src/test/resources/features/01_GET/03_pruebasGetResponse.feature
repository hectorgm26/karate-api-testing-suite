@feature_gets_responses
Feature: Pruebas validando responses con metodo GET en Karate

  Background:
    * headers {'x-api-key' : 'reqres-free-v1'}
    Given url "https://reqres.in/api"

  @test_get_responses1
  Scenario: Validar response completo al obtener un usuario existente
    And path "users", "2"
    When method get
    Then match response == {"data":{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"},"support":{"url":"https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral","text":"Tired of writing endless social media content? Let Content Caddy generate it for you."}}

  @test_get_responses2
  Scenario: Validar response parcial (una fraccion de la response) al obtener el listado de usuarios
    And path "users"
    And param page = 2
    When method get
    Then match response contains {"page": 2, "per_page": 6}

  @test_get_responses3
  Scenario: Validar response parcial de dato anidado dentro de un nodo, al obtener un usuario especifico
    And path "users", "2"
    When method get
    Then match response.data contains {"id":2,"email":"janet.weaver@reqres.in"}

  @test_get_responses4
  Scenario: Validar response parcial del tipo de dato anidado al obtener un usuario especifico
    And path "users", "2"
    When method get
    Then match response.data contains {id: "#number", email:"#string"}