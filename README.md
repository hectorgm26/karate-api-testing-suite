# 🥋 Proyecto de Pruebas Automatizadas con Karate Framework

Este repositorio contiene un proyecto personal orientado al aprendizaje, exploración y validación del framework de testing **Karate**, enfocado en pruebas automatizadas de APIs RESTful. Aquí se agrupan ejemplos prácticos, buenas prácticas, estructuras comunes y funcionalidades esenciales del framework.

---

## 📚 Tabla de Contenidos

- [Introducción](#introducción)
- [Uso de Tags en Features](#uso-de-tags-en-features)
- [Estructura de un Feature](#estructura-de-un-feature)
- [Palabras Reservadas en Karate](#palabras-reservadas-en-karate)
- [Uso de Background](#uso-de-background)
- [Método GET](#método-get)
- [Método POST](#método-post)
- [Scenario Outline](#scenario-outline)
- [Método PUT](#método-put)
- [Método PATCH](#método-patch)
- [Validaciones de Tiempo y Assert](#validaciones-de-tiempo-y-assert)
- [Buenas Prácticas](#buenas-prácticas)

---

## Introducción

Karate es un framework que permite escribir pruebas de APIs de forma sencilla utilizando una sintaxis tipo Gherkin. Este proyecto busca demostrar:

- Ejecución de features y escenarios etiquetados.
- Validaciones de status, contenido y tiempos de respuesta.
- Reutilización de datos y lógica.
- Envío de requests y verificación de respuestas en múltiples métodos HTTP.

---

## Uso de Tags en Features

```gherkin
@tag_features
Feature: Validación del funcionamiento de tags

  @test_get
  Scenario: Obtener usuario por ID
    Given ...
```

Los tags permiten agrupar escenarios o features para ejecutarlos de forma selectiva.

Se pueden usar múltiples tags y compartir entre features distintos.

## Estructura de un Feature

```gherkin
Feature: Define una funcionalidad a probar

  Scenario: Caso de prueba
    Given: Paso inicial
    When: Acción a ejecutar
    Then: Resultado esperado
    And: Paso adicional
    But: Condición que restringe
```

## Palabras Reservadas en Karate

| Categoría | Palabras |
|-----------|----------|
| HTTP y Requests | url, method, params, headers, request, cookie |
| Validación de respuestas | response, status, match, contains, assert, responseTime |
| Lógica de ejecución | def, eval, delay, retry, call, callSingle, background |
| Funciones karate. | karate.callSingle, karate.configure, karate.embed, karate.env, karate.feature, karate.info, karate.match, karate.read, karate.retry, karate.scenario, karate.get |

## Uso de Background

```gherkin
Background:
  * headers { 'x-api-key': 'reqres-free-v1' }
  Given url 'https://reqres.in/api/users/'
```

Los Background definen pasos comunes para todos los escenarios de un feature.

Se puede usar `*` en lugar de `Given` para mayor flexibilidad.

Permiten declarar headers, variables (def), URL base y lógica compartida.

## Método GET

### Usando path para concatenar a la URL base

```gherkin
Background:
  Given url 'https://reqres.in/api/users/'

Scenario: Obtener usuario por ID
  And path '2'
  When method get
  Then status 200
```

### Acceso a la respuesta

```gherkin
* def data = response.data
* def firstName = data[0].first_name
* def lastName = data[0].last_name
* match response.data[0].first_name == 'George'
```

### Uso de params y params {}

```gherkin
And param page = 2

And params { page: 2, per_page: 6 }
```

## Método POST

### Request inline

```gherkin
Scenario: Crear usuario
  Given url 'https://reqres.in/api/users'
  And request { "name": "morpheus", "job": "leader" }
  When method post
  Then status 201
  And match response.id == '#present'
```

### Request desde Background

```gherkin
Background:
  * def solicitud = { "name": "morpheus", "job": "leader" }

Scenario:
  * solicitud.name = "HectorGonzalezM"
  And request solicitud
```

### Request desde archivo externo

```gherkin
Scenario:
  * def bodyRequest = read('../jsons/posts/create_user.json')
  And request bodyRequest
```

## Scenario Outline

Permite ejecutar un mismo escenario con distintos datos:

```gherkin
Scenario Outline: Crear múltiples usuarios
  Given url 'https://reqres.in/api/users'
  And request { "name": <name>, "job": <job> }
  When method post
  Then status 201

Examples:
  | name             | job        |
  | HectorGonzalezM  | Programador|
  | Yanira Fontalba  | Gerente    |
  | Juan Perez       | Analista   |
```

## Método PUT

```gherkin
Scenario: Actualizar usuario
  Given url 'https://reqres.in/api/users/2'
  And request { "name": "morpheus", "job": "zion resident" }
  When method put
  Then match response contains { updatedAt: '#? _ >= "2025-06-22"' }
```

## Método PATCH

```gherkin
Scenario: Actualización parcial
  Given url 'https://reqres.in/api/users/2'
  And request { "name": "morpheus", "job": "zion resident" }
  When method patch
  And def fecha_actual = karate.get('java.time.LocalDate.now().toString()')
  Then match response == { name: "morpheus", job: "zion resident", updatedAt: '#? _ >= "#(fecha_actual)"' }
```

## Validaciones de Tiempo y Assert

```gherkin
Scenario: Tiempo de respuesta
  Given url 'https://reqres.in/api/users/2'
  When method get
  Then assert responseTime < 2000
```

Otras validaciones con assert:

```gherkin
* assert response.status == 200
* assert response.data[0].first_name == 'George'
```

## Buenas Prácticas

✅ Mantén el orden lógico Given → When → Then  
✅ Usa Background para pasos comunes  
✅ Reutiliza lógica con call, read, y archivos externos  
✅ Valida estructura, tipos y tiempos  
✅ Cuida indentación y sintaxis sensible a mayúsculas  
✅ Usa Scenario Outline para pruebas data-driven  

---

## 🧠 Autor

**Héctor González**
