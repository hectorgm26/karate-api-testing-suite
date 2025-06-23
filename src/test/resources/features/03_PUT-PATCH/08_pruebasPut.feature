@feature_put
Feature: Pruebas validando metodos put

  Background:
    * headers {'x-api-key' : 'reqres-free-v1'}

  @test_put_1
  Scenario: Validar que al actualizar un usuario, el servicio retorna un codigo 200
    Given url "https://reqres.in/api/users/2"
    And request {"name": "morpheus","job": "zion resident"}
    When method put
    Then status 200


  @test_put_2
  Scenario: Validar que al actualizar un usuario, el servicio retorna el campo updatedAt
    Given url "https://reqres.in/api/users/2"
    And request {"name": "morpheus","job": "zion resident"}
    When method put
    Then match response.updatedAt == "#present"


  @test_put_3
  Scenario: Validar que al actualizar un usuario, el servicio retorna una fecha con un json parcial
    Given url "https://reqres.in/api/users/2"
    And request {"name": "morpheus","job": "zion resident"}
    When method put
    Then match response contains {updatedAt : '#? _ >= "2025-06-22"'}
  # Este test valida que la fecha de updatedAt sea mayor o igual a "2025-06-22"
  # El #? _ trata de encontrar un valor que cumpla con la condición dada, tratando como array la respuesta, evaluando solo una parte de la misma.
  # Es decir que dentro del arreglo exista un valor que cumpla con la condición de ser mayor o igual a "2025-06-22".
  # Esto se usa para hacer contains parciales, ya que por defecto el contains evalua el objeto completo.


  @test_put_4
  Scenario: Validar que al actualizar un usuario, el servicio retorna una fecha
    Given url "https://reqres.in/api/users/2"
    And request {"name": "morpheus","job": "zion resident"}
    When method put
    Then match response == {name:"morpheus", job:"zion resident", updatedAt: '#? _ >= "2025-06-22"'}


  @test_put_5
  Scenario: Validar que al actualizar un usuario, el servicio retorna una fecha con regex
    Given url "https://reqres.in/api/users/2"
    And request {"name": "morpheus","job": "zion resident"}
    When method put
    Then match response contains {updatedAt : '#regex ^2025-06-22T.*Z$'}
  # El #regex evalua que el valor de updatedAt sea una fecha con el formato correcto, es decir que comience con "2025-06-22T" y termine con "Z".
