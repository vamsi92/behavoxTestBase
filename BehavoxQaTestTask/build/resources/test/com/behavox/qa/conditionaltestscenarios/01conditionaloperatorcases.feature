@smoke
Feature: Bitwise operator testcases

  Background:
    * url hostUrl
    * header Authorization = call read('../basic-auth.js') { username: '#(username)', password: '#(password)' }
    * configure retry = {count:20, interval:1000}

  Scenario: Groovy code with while loop and without return statement then validate response

    Given path postUrl
    * def payload = read('../conditionaltestscenarios/data/conditionaloperatordata.json')
    And request payload[0]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == 'null'

  Scenario: Groovy code with while loop and return statement then validate response

    Given path postUrl
    * def payload = read('../conditionaltestscenarios/data/conditionaloperatordata.json')
    And request payload[1]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '1'

  Scenario: Groovy code with if loop and continue statement then validate response

    Given path postUrl
    * def payload = read('../conditionaltestscenarios/data/conditionaloperatordata.json')
    And request payload[2]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '2'

  Scenario: Groovy code with if loop and without continue statement then validate response

    Given path postUrl
    * def payload = read('../conditionaltestscenarios/data/conditionaloperatordata.json')
    And request payload[3]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '0'

  Scenario: Groovy code with if and else statement then validate response

    Given path postUrl
    * def payload = read('../conditionaltestscenarios/data/conditionaloperatordata.json')
    And request payload[4]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == 'working'

  Scenario: Groovy code with switch statement then validate response

    Given path postUrl
    * def payload = read('../conditionaltestscenarios/data/conditionaloperatordata.json')
    And request payload[5]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '2'
