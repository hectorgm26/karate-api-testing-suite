@feature_gets @regresiva_test
Feature: Pruebas con metodo GET en Karate

  Background:
    * headers {'x-api-key' : 'reqres-free-v1'}
    Given url "https://reqres.in/api/users/"

  @test_get1 @test_agrupado @regresiva_particular
  Scenario: Obtener usuarios existentes
    And path "3"
    When method get
    Then status 200

  @test_get2 @test_agrupado
  Scenario: Obtener usuarios inexistentes
    And path "888"
    When method get
    Then status 404