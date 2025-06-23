@feature_post_request_headers
Feature: Pruebas validando metodos post con headers

  Background:
    * headers {'x-api-key' : 'reqres-free-v1'}
    * configure headers = {Token : "123456789"}
  # Los headers seran sobreescritos en los scenarios cuando configuran un headers diferente

  # Pasar directo los headers como json dentro del scenario
  @test_post_11
  Scenario: Validar que al crear un usuario se recibe el codigo de respuesta 201
    Given url "https://reqres.in/api/users"
    And headers {Prueba : "Curso de Karate Framework", Clase : "Pruebas Post con Headers"}
    And def bodyRequest = read("../jsons/posts/create_user.json")
    And bodyRequest['job'] = "Developer"
    And bodyRequest.name = "Linux Torvalds"
    And request bodyRequest
    When method post
    Then status 201


  # Pasar los headers desde un archivo json
  @test_post_12
  Scenario Outline: Validar que al crear un usuario se recibe el codigo de respuesta 201 y el nombre del usuario es el que se envio en el body
    Given url "https://reqres.in/api/users"
    And def encabezados = read("../jsons/posts/create_user_headers.json")
    And headers encabezados
    And def bodyRequest = read("../jsons/posts/create_user.json")
    And bodyRequest['name'] = <nombre>
    And request bodyRequest
    When method post
    Then status 201

    Examples:
      | nombre            |
      | "Yanira Fontalba" |
  # | "Javier Llanquileo" |
  #  | "Juan Pablito"      |


  # Pasar los headers desde un archivo json y modificar los valores mediante un escenario outline
  @test_post_13
  Scenario Outline: Validar que al crear un usuario se recibe el codigo de respuesta 201 y el nombre del usuario es el que se envio en el body
    Given url "https://reqres.in/api/users"
    And def encabezados = read("../jsons/posts/create_user_headers.json")
    And encabezados.Prueba = <prueba>
    And headers encabezados
    And def bodyRequest = read("../jsons/posts/create_user.json")
    And bodyRequest['name'] = <nombre>
    And request bodyRequest
    When method post
    Then status 201

    Examples:
      | nombre              | prueba                      |
      | "Yanira Fontalba"   | "Curso de Karate Framework" |
      | "Javier Llanquileo" | "Curso de Rest Assured"     |
      | "Juan Pablito"      | "Curso de Postman"          |


  @test_post_14
  Scenario Outline: Validar que al crear un usuario se recibe el codigo de respuesta 201 y el nombre del usuario es el que se envio en el body, con headers dinámicos
    Given url "https://reqres.in/api/users"
    And headers {Prueba : <prueba>, Clase : <clase>}
    And def bodyRequest = read("../jsons/posts/create_user.json")
    And bodyRequest.name = <nombre>
    And bodyRequest.job = <job>
    And request bodyRequest
    When method post
    Then status 201

    Examples:
      | nombre              | job            | prueba                      | clase                                 |
      | "Yanira Fontalba"   | "Backend dev"  | "Curso de Karate Framework" | "Post con Headers desde Karate"       |
      | "Javier Llanquileo" | "Frontend dev" | "Curso de Rest Assured"     | "Post con headers desde Rest Assured" |
      | "Juan Pablito"      | "Devops"       | "Curso de Postman"          | "Post con headers desde Postman"      |

      
  @test_post_15
  Scenario: Validar que al crear un usuario se recibe el codigo de respuesta 201 con background
    Given url "https://reqres.in/api/users"
    And def bodyRequest = read("../jsons/posts/create_user.json")
    And bodyRequest['job'] = "Developer"
    And bodyRequest.name = "Linux Torvalds"
    And request bodyRequest
    When method post
    Then status 201

  @test_post_16
  Scenario: Validar que al crear un usuario se recibe el código 201 con combinación de headers
    Given url "https://reqres.in/api/users"

    # Paso 1: Definimos headers base (como api-key)
    * def baseHeaders = { 'x-api-key': 'reqres-free-v1' }

    # Paso 2: Definimos headers personalizados (Clase, Prueba, etc)
    * def customHeaders = { Header_General: "Desde-Background", Clase: "Pruebas Post con Headers", Prueba: "Curso de Karate Framework" }

    # Paso 3: Fusionamos todos los headers en uno solo
    * def allHeaders = karate.merge(baseHeaders, customHeaders)

    # Paso 4: Aplicamos los headers combinados
    * configure headers = allHeaders

    # Paso 5: Cuerpo de la petición
    * def bodyRequest = read("../jsons/posts/create_user.json")
    * bodyRequest.job = "Fullstack Engineer"
    * bodyRequest.name = "Ada Lovelace"

    And request bodyRequest
    When method post
    Then status 201

