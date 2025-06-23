@feature_patch
Feature: Pruebas validando metodos patch

  Background:
    * headers {'x-api-key' : 'reqres-free-v1'}

  @test_patch_1
  Scenario: Validar que al actualizar un usuario, el servicio patch retorna un codigo 200
    Given url "https://reqres.in/api/users/2"
    And request {"name": "morpheus","job": "zion resident"}
    When method patch
    Then status 200


  @test_patch_2
  Scenario: Validar que al actualizar un usuario, el servicio patch retorna un codigo 200
    Given url "https://reqres.in/api/users/2"
    And request {"name": "morpheus","job": "zion resident"}
    When method patch
    And def fecha_actual = karate.get('java.time.LocalDate.now().toString()')
    * print fecha_actual
    Then match response == {name:"morpheus", job:"zion resident", updatedAt : '#? _ >= "#(fecha_actual)"'}
  # En este caso, se valida que el campo updatedAt sea mayor o igual a la fecha actual, que se obtiene en el paso anterior mediante el metodo karate.get, usando un script de java
