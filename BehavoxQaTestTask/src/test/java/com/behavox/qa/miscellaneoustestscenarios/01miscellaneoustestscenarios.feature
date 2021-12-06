@smoke
Feature: Miscellaneous testcases

  Background:
    * url hostUrl
    * header Authorization = call read('../basic-auth.js') { username: '#(username)', password: '#(password)' }
    * configure retry = {count:20, interval:1000}

  Scenario: Groovy code with list addition then validate response

    Given path postUrl
    * def payload = read('../miscellaneoustestscenarios/data/miscellaneousdata.json')
    And request payload[0]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '[11, 12, 13, 14, 15]'

  Scenario: Groovy code with list remove element then validate response

    Given path postUrl
    * def payload = read('../miscellaneoustestscenarios/data/miscellaneousdata.json')
    And request payload[1]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "COMPLETED"
    Then retry until response.result == '[12, 13, 14]'

  Scenario: Groovy code with array and index out of bounds without exception handling then validate response

    Given path postUrl
    * def payload = read('../miscellaneoustestscenarios/data/miscellaneousdata.json')
    And request payload[2]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == "FAILED"
    Then retry until response.result  contains 'ArrayIndexOutOfBoundsException'

  Scenario: Groovy code with array and index out of bounds with exception handling then validate response

    Given path postUrl
    * def payload = read('../miscellaneoustestscenarios/data/miscellaneousdata.json')
    And request payload[3]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == 'COMPLETED'
    Then retry until response.result == 'exception occured'

  Scenario: Groovy code with closure block then validate response

    Given path postUrl
    * def payload = read('../miscellaneoustestscenarios/data/miscellaneousdata.json')
    And request payload[4]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == 'COMPLETED'
    Then retry until response.result == 'closure called'

  Scenario: Groovy code with closure block which has parameters then validate response

    Given path postUrl
    * def payload = read('../miscellaneoustestscenarios/data/miscellaneousdata.json')
    And request payload[5]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == 'COMPLETED'
    Then retry until response.result == 'HelloWorld'

  Scenario: Groovy code with Map objects then validate response

    Given path postUrl
    * def payload = read('../miscellaneoustestscenarios/data/miscellaneousdata.json')
    And request payload[6]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == 'COMPLETED'
    Then retry until response.result == '{TopicName=Maps, TopicDescription=Methods in Maps, TopicID=1}'

  Scenario: Groovy code with Map objects that returns values then validate response

    Given path postUrl
    * def payload = read('../miscellaneoustestscenarios/data/miscellaneousdata.json')
    And request payload[7]
    When method POST
    Then status 200
    * def value = response.id
    Given path getUrl
    * param id = value
    When method GET
    Then status 200
    Then retry until response.status == 'COMPLETED'
    Then retry until response.result == '[Maps, Methods in Maps]'